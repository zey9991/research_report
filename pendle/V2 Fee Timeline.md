### Tasks and Timeline

Date: 2025-02-23

1. ##### Initial Preparations (Progress: 0%, Expected Completion by 2.26)

- [ ] **Merge Dataset**
  - To construct time series data, Pool Metrics must be manually downloaded for each day (or at another chosen frequency).
  - It may be worth consulting the Data Group to explore potential simplifications.
  - If no simplifications are available, we could consider leveraging web scraping techniques to batch-download and merge the data.
- [ ] **Data Preprocessing**
  - Review and remove outlier samples from the dataset where appropriate.
  - Centralize the time series for all pools by assuming they share a common start date.
- [ ] **Introduction to Fee Ratio**
  - Defined as: **Fee Ratio = Current Fee Tier / Current Implied APY**
  - Currently, our team manually sets the initial Fee Ratio at **0.02** upon pool activation (so-called the "Golden Number").

2. ##### Optimizing the Initial Fee Ratio (Progress: 0%, Expected Completion by 3.6)

**Model 1: ARMAX**

- [ ] This model assumes that the **Efficient Ratio** is influenced by its own past values (lagged terms) as well as the past values of the **Fee Ratio**.
- [ ] For each pool:
  - If the **Efficient Ratio** is stationary, no further transformation is required.
  - If the **Efficient Ratio** is non-stationary, apply appropriate transformations, such as first-order differencing (converting ARMAX into ARIMAX), Box-Cox transformations, etc.
  - Iterate through all pools.
- [ ] Conduct residual diagnostics to ensure model assumptions hold.
- [ ] Examine the impact of each variable on the **Efficient Ratio** using **Impulse Response Functions (IRF)**. For long-term effects, compute the **Cumulative Impulse Response Function (CIRF)** to assess the influence of the **Fee Ratio** on the **Efficient Ratio**.

**Model 2: VAR**

- [ ] This model treats **Efficient Ratio** and **Fee Tier** as a system, assuming mutual influence between the two.
- [ ] For each pool, construct a VAR model incorporating both Efficient Ratio and Fee Tier, determining the optimal number of lags using BIC or similar criteria.
  - If both variables are stationary, no transformation is needed.
  - If both are non-stationary, first check for **cointegration relationships** before proceeding.
- [ ] Estimate model parameters, removing insignificant coefficients.
- [ ] Conduct residual diagnostics to validate assumptions.
- [ ] Compute **Impulse Response Functions (IRF)** and **Cumulative Impulse Response Functions (CIRF)** to analyze the impact of the **Fee Ratio** on the **Efficient Ratio**.

**Model 3: GARCH**

- [ ] Building upon **Model 1**, examine whether the squared residuals exhibit autocorrelation to determine if conditional heteroskedasticity exists. If present, volatility modeling is required.
- [ ] Prioritize the **GARCH model** to reduce the number of parameters and improve estimation efficiency.
- [ ] Perform diagnostics on the squared residuals to ensure model validity.
- [ ] Analyze **Impulse Response Functions (IRF)** and **Cumulative Impulse Response Functions (CIRF)** under the **GARCH framework**.

##### 3. Aggregating Results

- [ ] Based on the established models, derive optimal **Fee Ratio** parameters for specific groupings (e.g., pools where the base asset is **ETH**) and at a global level.