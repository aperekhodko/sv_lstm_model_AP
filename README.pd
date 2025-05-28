readme_content = """# S&P 500 Volatility Forecasting and Investment Strategy

This repository contains code and data for forecasting volatility in the S&P 500 using different modeling approaches, including Stochastic Volatility (SV), Long Short-Term Memory (LSTM) networks, and a Hybrid model. It also includes a basic investment strategy based on VIX inputs, as well as statistical tests for model comparison.

## Repository Structure

- `sp500_data.csv`: Core dataset with S&P 500 data.
- `sv.csv`: Input datasets for VIX and SV-based modeling.
- `stochastic volatiity.R`: R script for generating Stochastic Volatility (SV) predictions.
- `lstm/`: Folder containing pre-tuned LSTM model configurations and hyperparameters.
- `hybrid/`: Folder containing Hybrid model configurations and hyperparameters.
- `lstm.ipynb`: Jupyter notebook implementing LSTM model.
- `hybrid.ipynb`: Jupyter notebook implementing Hybrid model using both SV and S&P 500 data.
- `investment strategy.ipynb`: Implementation of a trading strategy using VIX data.
- `stat test - sv_vs_lstm.ipynb`, `stat test_sv_lstm_vs_lstm.ipynb`, `stat test_sv_vs_sv_lstm.ipynb`: Statistical tests comparing the forecasting performance of different models.
- `data_vix.csv`, `final_settle_df.csv`: Input data for VIX investment strategy

## Project Description

The goal of this project is to model and predict volatility in the S&P 500 index using various machine learning and statistical approaches, and to evaluate their effectiveness through performance metrics and statistical tests.

### Data Sources

- **S&P 500 Data** (`sp500_data.csv`): Primary market index data.
- **SV Predictions**: Generated using the `roll final.R` script or read from `sv.csv`.
- **VIX Input Data**: Comes from `data_vix.csv` and a`final_settle_df.csv`.

### Models

- **Stochastic Volatility (SV)**: Implemented in R with rolling window predictions.
- **LSTM**: Deep learning model trained on S&P 500 or combined data.
- **Hybrid Model**: Combines SV predictions with S&P 500 data for improved accuracy.

### Strategy

An investment strategy is implemented in `investment strategy.ipynb`, based on volatility predictions and VIX input data.

### Statistical Testing

Multiple notebooks compare the prediction performance of the models using statistical hypothesis testing.
