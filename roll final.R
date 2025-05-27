library(stochvol)
library(tidyquant)
library(dplyr)
library(ggplot2)
library(parallel)

# Load the data
sp500_data <- tq_get("^GSPC", from = "1997-02-01", to = "2025-01-01", get = "stock.prices") %>%
  select(date, adjusted) %>%
  rename(Close = adjusted) %>%
  mutate(log_return = log(Close / lag(Close))) %>%
  na.omit()  # Remove first NA

log_returns <- sp500_data$log_return 
dates <- sp500_data$date

sv_test <- svsample_roll(
  y = sp500_data$log_return[1:504],
  n_ahead = 1,
  forecast_length = 1,
  keep_draws = TRUE
)
print("h_{t+1} range:")
print(range(sv_test[[1]]$prediction$h))
print("Volatility range:")
print(range(sv_test[[1]]$prediction$vol))
print("Median volatility:")
print(median(sv_test[[1]]$prediction$vol))
# Parameters
training_window <- 252 * 2  # 2 years of data for training
quantile_to_predict <- 0.5  # Median prediction
n_ahead <- 1
forecast_length <- 1
refit_window <- "moving"

# Define start dates and indices
start_dates <- as.Date(c("2000-01-01", "2001-01-01", "2002-01-01", "2003-01-01", "2004-01-01",
                         "2005-01-01", "2007-01-01", "2008-01-01", "2009-01-01", "2010-01-01",
                         "2011-01-01", "2012-01-01"))
buffer_days <- 365 * 2 + 18
adjusted_start_dates <- start_dates - buffer_days
start_indices <- sapply(adjusted_start_dates, function(start_date) {
  index <- which(dates >= start_date)[1]
  if (!is.na(index) && dates[index] > start_date) {
    index <- index - 1  # Try moving back if possible
  }
  return(index)
})



# Pre-allocate the predictions data frame
num_windows <- length(dates) - training_window - n_ahead
predictions <- data.frame(Training_Start = rep(NA, num_windows),
                          Training_End = rep(NA, num_windows),
                          Prediction_Start = rep(NA, num_windows),
                          SV_Prediction = rep(NA, num_windows))

# Set up a cluster with 5 cores
cl <- makeCluster(5)

clusterExport(cl, list("log_returns", "dates", "training_window", "n_ahead", 
                       "quantile_to_predict", "svsample_roll", "refit_window", "forecast_length"))

get_sv_predictions_parallel <- function(start_index) {
  predictions <- parLapply(cl, seq(start_index, length(dates) - training_window - n_ahead, by = 1), function(i) {
    # Ensure that all necessary variables are in scope within this function
    window_data <- log_returns[i:(i + training_window - 1)]
    
    
    training_start <- dates[i]
    training_end <- dates[i + training_window - 1]
    prediction_start <- dates[i + training_window]
    
    # Call the svsample_roll function (assuming it's defined or loaded in the environment)
    sv_result <- svsample_roll(
      y = window_data_offset,
      n_ahead = n_ahead,
      forecast_length = forecast_length,
      refit_window = refit_window,
      calculate_quantile = quantile_to_predict,
      calculate_predictive_likelihood = TRUE,
      keep_draws = FALSE
    )
    
    predicted_quantile <- if (!is.null(sv_result[[1]]$predicted_quantile)) {
      unname(sv_result[[1]]$predicted_quantile)
    } else {
      NA
    }
    
    return(data.frame(
      Training_Start = training_start,
      Training_End = training_end,
      Prediction_Start = prediction_start,
      SV_Prediction = predicted_quantile
    ))
    
  })
  
  # Combine the results into one data frame
  predictions <- do.call(rbind, predictions)
  
  return(predictions)
}

# Run the parallel function to get predictions
final_predictions <- get_sv_predictions_parallel(min(start_indices, na.rm = TRUE))

# Stop the parallel cluster
stopCluster(cl)

# Save the results as a CSV file
write.csv(final_predictions, "sv.csv", row.names = FALSE)

# Print completion message
cat("Predictions saved to sv_predictions.csv\n")


