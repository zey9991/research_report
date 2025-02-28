# Background

In the previous report, we explored the relationship between **FeeTier** and **EfficientRatio** on an absolute basis, where the **FeeTier** used was a fixed value.

However, the current approach employed by our team adjusts the pools' **FeeTier** based on a relative metric, **FeeRatio**, which is defined as FeeTier/Current Implied APY.

If this **FeeRatio** deviates significantly from 0.02 (e.g., below 0.016 or above 0.025), the **FeeTier** is adjusted to bring the ratio closer to 0.02.

In this report, we aim to expand our analysis of **FeeTier** and **EfficientRatio** by examining them dynamically. By modeling the time-series relationship between **FeeRatio** and **EfficientRatio**, we can evaluate how fluctuations in the **FeeRatio** affect the pool’s **EfficientRatio**.

The ultimate goal of this report is to determine whether setting the **FeeRatio** at 0.02 is optimal. If not, we seek to identify a more suitable value.

# Definition

## FeeRatio

The **FeeRatio** used by our team to set the **FeeTier** is:
$$
FeeRatio=\frac{FeeTier}{Implied APY}
$$
An empirical rule for determining this parameter is to set **FeeRatio = 0.02**, which means that **FeeTier = 0.02 × Implied APY**.

- **For roll-over pools:** If **FeeTier / Implied APY** deviates too much from 0.02, we adjust the **FeeTier** to approximately **0.02 × Implied APY**.
- **For new pools:** We estimate a “reasonable Implied APY it will be trading at” and set the initial **FeeTier** to **0.02 × Assumed Initial APY**.

In the dataset used for this report, the **Implied APY** is weighted by trading volume on a daily basis. If no transactions occur on a given day, the last available valid value is used.

## EfficientRatio

We introduce the **EfficientRatio** as a metric to assess the **capital efficiency** of specific pools. It is calculated as:

$$
\begin{aligned}
&EfficientRatio=\frac{Average\ Daily\ Swap\ Fee * 365}{Avg\ Daily\ LP\ TVL}
\end{aligned}
$$
This ratio compares the total annualized swap fees to the **Average Daily LP TVL** (Total Value Locked) of the pool. A higher **EfficientRatio** indicates that the pool generates more fees per unit of liquidity, suggesting better operational efficiency.

# Dataset Preprocessing

The dataset utilized in this report is available in the "Adhoc Report" section of the Pool Metrics dataset, with data retrieved on 2025-02-28.

Our preprocessing steps primarily involved:

- Removing observations with date parsing issues
- Dropping observations where the date (`dt`) fell outside the pool's active period (i.e., `dt < Start Date` or `dt > Expiry Date`)
- Deleting data for pools that had no transactions upon launch, resulting in missing **AverageIY** and **FeeRatio** values
- Performing linear interpolation for pools with missing AMM TVL data, and removing pools that had missing data at either end of the time window
- Deleting data from 2025-02-28 for pools with missing **AverageIY** and **FeeRatio** values

Through these preprocessing operations, we ensured that no missing values for **FeeRatio** or **EfficientRatio** remained in the dataset.

After these operations, we were left with a dataset containing 34,549 rows and 200 unique pools.

# Modeling: An Example

To illustrate the process of modeling the relationship between time-series FeeRatio and EfficientRatio, we can give an example.





# Aggregating Results