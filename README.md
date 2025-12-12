# Stochastic Volatility Modelling with LSTM Networks: A Hybrid Approach for S&P 500 Index Volatility Forecasting

This repository contains code and data for forecasting volatility in the S&P 500 using different modeling approaches, including Stochastic Volatility (SV), Long Short-Term Memory (LSTM) networks, and a Hybrid model. It also includes a basic investment strategy based on VIX inputs, as well as statistical tests for model comparison.

## Repository Structure

```project/
├── code/
│ ├── models/ # Main model notebooks (LSTM, Hybrid, SV)
│ ├── sensitivity/ # Sensitivity analysis notebooks for hybrid models
│ ├── evaluation/ # Statistical tests and metrics calculation
│ └── strategy/ # Investment strategy simulation
├── data/ # Input datasets and data preparation scripts
└── results/
├── hyperparameters/ # Final selected hyperparameters for models
└── model_outputs/ # Model predictions used in the paper
```


---

## Project Description

The goal of this project is to model and predict volatility in the S&P 500 index using various machine learning and statistical approaches, and to evaluate their effectiveness through performance metrics and statistical tests.

### Data Sources

- **S&P 500 Data** (`sp500_data.csv`): Primary market index data.
- **SV Predictions**: Generated using `stochastic_volatility.R` or read from `results/model_outputs/sv.csv`.
- **VIX Input Data**: Comes from `data/data_vix.csv` and `data/final_settle_df.csv`.

### Models

- **Stochastic Volatility (SV)**: Implemented in R with rolling window predictions.
- **LSTM**: Deep learning model trained on S&P 500 or combined data (`code/models/lstm.ipynb`).
- **Hybrid Model**: Combines SV predictions with S&P 500 data for improved accuracy (`code/models/hybrid.ipynb` and `code/models/hybrid_madl.ipynb`).

> **Note:** Hyperparameter tuning is performed internally within each model notebook. Raw tuning outputs are not included due to size. Final selected hyperparameters are provided in `results/hyperparameters/`.

### Sensitivity Analysis

- Supplementary notebooks exploring model architecture and parameters are in `code/sensitivity/`.
- These experiments are optional for reproducing the main results.

### Statistical Testing

- Statistical tests and metrics calculation are implemented in `code/evaluation/`:
  - `metrics calc.ipynb`
  - `stat test - sv_vs_lstm.ipynb`
  - `stat test_sv_lstm_vs_lstm.ipynb`
  - `stat test_sv_vs_sv_lstm.ipynb`
- Outputs are saved in `results/model_outputs/` (LSTM, Hybrid, SV baselines).

### Investment Strategy

- Simulation scripts are in `code/strategy/investment_strategy.ipynb`.
- Uses VIX signals from `code/strategy/data_vix_signals.csv`.
- Produces results replicating the strategy described in the paper.

---

## Reproducibility Workflow

To reproduce the main results:

1. Run model notebooks in `/code/models/` (outputs are saved to `results/model_outputs/`).
2. Run evaluation notebooks in `/code/evaluation/` to generate metrics and statistical tests.
3. Optionally, run sensitivity analysis in `/code/sensitivity/`.
4. Run investment strategy simulation in `/code/strategy/`.

**Note:** Only final hyperparameters and model outputs are included; raw tuning results and intermediate files are excluded due to large size.

---

## Installation

1. Clone the repository:
```bash
git clone [your_repo_url]
cd project

2. Install dependencies:
pip install -r requirements.txt