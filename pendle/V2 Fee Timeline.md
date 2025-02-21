### Tasks and Timeline

Relative Fee

Date: 2025-02-21

1. Initial Preparations (Progress: 0%, Expected Completion by 2.25)

- **Dataset Consolidation**
  - To construct time series data, Pool Metrics must be manually downloaded for each day (or at another chosen frequency).
  - It may be worth consulting the Data Group to explore potential simplifications.
  - If no simplifications are available, we could consider leveraging web scraping techniques to batch-download and merge the data.
- **Data Preprocessing**
  - Review and remove outlier samples from the dataset where appropriate.
  - Centralize the time series for all pools by assuming they share a common start date.
- **Introduction to Fee Ratio**
  - Defined as: **Fee Ratio = Current Fee Tier / Current Implied APY**
  - Currently, our team manually sets the initial Fee Ratio at **0.02** upon pool activation (considered the "Golden Number").

2. Optimizing the Initial Fee Ratio (Progress: 0%, Expected Completion by 3.4)

##### **Model 1: ADL Model for Fee Ratio**

- The optimal initial **Fee Ratio** can be determined as the long-term equilibrium in this model.
- For each pool:
  - Define an **error correction model** (ECM). If Fee Ratio is a stationary process, its long-term equilibrium value can be directly estimated.
  - If Fee Ratio is non-stationary, special handling is required. In extreme cases, non-stationary samples may need to be excluded.
  - Iterate through all pools to compute their long-term equilibrium values.
- The global optimal initial Fee Ratio can then be derived via a weighted average approach:
  - Possible weighting factors include **TVL, Trading Volume, or Efficient Ratio**.
- Similarly, an optimal initial Fee Ratio can be computed for different pool categories (e.g., pools where **Base Asset = ETH**).
- **Limitation:** This model does not explicitly establish a relationship between **Fee Ratio** and the optimal **Efficient Ratio**. Efficient Ratio remains a latent variable in this framework, meaning the model cannot directly confirm whether the computed long-term equilibrium of Fee Ratio actually leads to optimal efficiency.

##### **Model 2: Long-Term Equilibrium Between Fee Ratio and Efficient Ratio**

- This model assumes that **Efficient Ratio** is influenced by its own past values (lagged terms) as well as the past values of **Fee Ratio**.
- For each pool:
  - If both **Fee Ratio** and **Efficient Ratio** are stationary, long-term equilibrium parameters can be estimated.
  - If both variables are non-stationary but exhibit **cointegration**, long-term equilibrium parameters can still be derived.
  - Iterate through all pools to compute their long-term equilibrium parameters.
- The global optimal initial Fee Ratio can then be derived via a weighted average approach:
  - Possible weighting factors include **TVL, Trading Volume, or Efficient Ratio**.
- Similarly, an optimal initial Fee Ratio can be computed for different pool categories (e.g., pools where **Base Asset = ETH**).
- Limitation: This model assumes a linear long-term equilibrium, expressed as $$y=ϕ+θx$$, where ϕ and θ are the estimated long-term parameters.
  - Within this linear framework, the optimal **Fee Ratio** for maximizing **Efficient Ratio** is restricted to the endpoints of the estimated range.
  - This means the model cannot precisely determine the true optimal initial **Fee Ratio** beyond these constraints.

----

Absolute Fee (**Archived**)

1. **Preliminary** (Completed: 100%)
   - Fee calculation
   - Pool metrics
   - Data preprocessing
2. **The Most Suitable Efficient Metrics** (Completed: 100%)
   - Candidate metrics
   - Rationale for choosing the metric: Economic or financial meanings
3. **Optimal Fee Tier Range** (Completed: 100%)
   - Three Models
     - Cubic Regression Model
     - Threshold Regression Model
     - Partially Linear Model
4. **Further Exploration** (Progress: 75%)
   - Robustness analysis: Test the robustness of the model results
   - Heterogeneity analysis:
     1. Investigate how fee tier affects explicit and implicit fees
     2. Explore result differences by grouping based on other features, such as:
        - Similarity of underlying assets
        - Start or expiry dates
   - Introduce additional data sources or metrics
5. **Post-Completion Tasks** (Progress: 0%)
- Regularly update with the latest dataset to check for changes in results
  
-  Monitor whether the optimal fee tier identified in this report has increased the efficiency of the V2 pools in practice.
   
- Consider automating certain processes through programming