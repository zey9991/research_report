# Guideline

## Methodology Used in the Absolute Report

To illustrate the differences, let’s first revisit the approach we took in the Absolute report.

### **Objective**

Our goal was to determine the optimal **FeeTier** that maximizes the **EfficientRatio**.

### **Challenge**

The exact functional relationship between these two variables is unknown.

### **Strategy**

To address this, we aimed to maximize the expected **EfficientRatio** given a specific **FeeTier** and then determine the optimal **FeeTier** accordingly. Mathematically, this can be expressed as the following optimization problem:
$$
arg\max_{FeeTier} E(EfficientRatio|FeeTier)
$$
where E(EfficientRatio∣FeeTier)E(\text{EfficientRatio} | \text{FeeTier})E(EfficientRatio∣FeeTier) represents the conditional expectation of **EfficientRatio** given **FeeTier**. Alternatively, we can interpret it as a function of **FeeTier**: 
$$
E(EfficientRatio|FeeTier)=f(FeeTier)
$$
In an informal way,, we assume the following relationship holds:
$$
EfficientRatio=f(FeeTier)
$$
Thus our goal it to 
$$
arg\max_{FeeTier}f(FeeTier)
$$
### **Implementation**

To estimate this function, we employed appropriate regression models. Specifically, when setting all control variables to their median values, we obtained the following estimated function:
$$
f(FeeTier)=0.04397-8.25FeeTier+3999.2FeeTier^2-132549.2FeeTier^3
$$
Using this estimated function, we derived the optimal **FeeTier** accordingly.

The figure below illustrates the predicted **EfficientRatio** across different **FeeTier** values while holding control variables at their median values.

![Predictive Margins with Control Variables at Median Value](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Predictive%20Margins%20with%20Control%20Variables%20at%20Median%20Value2.png)

## **Why Not Start with the Global Optimal FeeRatio?**

From a broader perspective, we can structure our **Standard Operating Procedure (SOP)** for finding the optimal **FeeRatio** as follows:

1. **Model each pool individually**
2. **Determine the optimal FeeRatio for each pool**
3. **Aggregate results to derive the global optimal FeeRatio**

### **Key Assumptions**

We assume that each pool operates under distinct conditions and should therefore have its own optimal **FeeRatio** rather than a universal one.

Additionally, we **cannot** simply merge all the data into a **balanced panel dataset**. This is because different pools have varying active periods—some may be live while others remain inactive—leading to inconsistencies in the dataset.

### **Conclusion**

Given these constraints, a more reasonable approach is to start by analyzing individual pools and then aggregate the results using appropriate methods.

## **Why Not Use the Previous Method to Search for the Optimal FeeRatio?**

At first glance, it seems reasonable to model **FeeRatio** and **EfficientRatio** pool by pool, just as we did before.

For instance, we might assume that these two variables follow the functional form:
$$
EfficientRatio_t=\beta_0+\beta_1FeeRatio_t+\beta_2FeeRatio_t^2+\beta_3FeeRatio_t^3+\epsilon_t \tag{1}
$$
However, things change when we shift to a **time-series framework**.

Firstly, the results of statistical test show that we can not reject the null hypothesis that most of FeeRatio in different pools are not stationary. 

### **Why Can’t We Model Like (1) with Nonstationary Time-Series?**

The primary issue is **spurious regression**.

Research shows that regressing two unrelated but **nonstationary** time-series often leads to misleading conclusions—creating the illusion of a strong relationship when, in reality, none exists.

### **Additional Challenges**

Beyond spurious regression, time-series data typically exhibit **autocorrelation**, meaning that observations are correlated with their past values. This necessitates incorporating **lagged terms** into the model.

A commonly used time-series model, **ARIMAX(p,0,q)**, can be written as:
$$
\begin{aligned}
EfficientRatio_t=&\phi_1EfficientRatio_{t-1}+...+\phi_pEfficientRatio_{t-p}\\
&+\beta_1FeeRatio_t+\beta_2FeeRatio_t^2+\beta_3FeeRatio_t^3\\
&+\varepsilon_t+\theta_1\varepsilon_{t-1}+...+\theta_q\varepsilon_{t-q}
\end{aligned} \tag{2}
$$
 Where $$\phi_i$$ and $$\theta_i$$ are the parameters to be estimated. 

While model (2) accounts for past values of **EfficientRatio** and estimation errors, it raises two further questions:

**1️⃣ Should We Include Lagged Terms of FeeRatio?**

Since we consider past values of **EfficientRatio**, shouldn't we also include time-lagged terms for **FeeRatio**? For example:
$$
\begin{aligned}
EfficientRatio_t=&\phi_1EfficientRatio_{t-1}+...+\phi_pEfficientRatio_{t-p}\\
&+\beta_1FeeRatio_t+\beta_2FeeRatio_t^2+\beta_3FeeRatio_t^3\\
&+\beta_4FeeRatio_{t-1}+\beta_5FeeRatio_{t-1}^2+\beta_6FeeRatio_{t-1}^3\\
&+\varepsilon_t+\theta_1\varepsilon_{t-1}+...+\theta_q\varepsilon_{t-q}
\end{aligned} 
$$

📌 **Answer:** The necessity of adding these lagged terms can be formally tested through statistical methods.

**2️⃣ What If the Time-Series Are Nonstationary?**

To apply this model, we must first **check the stationarity** of both time-series. If even one of them is **nonstationary**, the entire model collapses.

📌 **This is a fundamental limitation**—and unfortunately, statistical tests show that **most FeeRatio series are nonstationary**, making this approach unworkable in practice.

The **Vector Autoregression (VAR) model** suffers from similar issues, further complicating its applicability.

## How to Handle Nonstationary Cases?

In traditional time-series modeling, there are typically two approaches:

1. **Differencing**: This method is analogous to taking derivatives in discrete cases. For model (2), we can transform the variables as follows to achieve stationarity: $$\Delta EfficientRatio_t\equiv EfficientRatio_t-EfficientRatio_{t-1}$$ and $$\Delta FeeRatio_t$$ 

   If the resulting series remains nonstationary, we continue differencing until stationarity is achieved.

   - **The downside**: After differencing, interpreting the coefficients becomes more complex, especially when multiple rounds of differencing are required.
   - **Practical challenge**: Our dataset contains nearly 200 pools, but the required differencing order varies among them—some pools need only one round, while others may require two or more. This variation complicates the automation of model selection and estimation.

2. **Cointegration**: If both variables are nonstationary but become stationary after the same number of differencing steps and pass certain statistical tests, we can establish a **long-term equilibrium relationship** between them. In such cases, we can model them without differencing using the **Vector Error Correction Model (VECM)**.

   - **The challenge**: Not all pools meet the stringent conditions for cointegration, making automation difficult.

### In summary

In short, traditional time-series models such as ARIMAX, VAR, and VECM require the following steps:

```
For each pool:
1. Test stationarity and select the appropriate model:
   1.1. If both variables are stationary, use ARMAX or VAR.
   1.2. If at least one variable is nonstationary:
       1.2.1. Test for cointegration:
           1.2.1.1. If cointegration exists, use VECM:
               1.2.1.1.1. Determine the order of integration and ensure they match.
               1.2.1.1.2. Conduct cointegration tests.
           1.2.1.2. If no cointegration is found, apply differencing and use ARIMAX or VAR.
2. Determine the appropriate number of lag terms.
3. Fit the model and estimate parameters.
4. (Optional) Compare model performance using goodness-of-fit metrics.
5. Check whether residuals satisfy model assumptions.

After model estimation, interpret the results and aggregate findings to determine the global optimal FeeRatio.
```

### Why Use State-Space Models (SSM)?

By adopting **State-Space Models (SSM)**, we can significantly simplify Step 1 in the process above. Unlike traditional time-series models, SSM does not require explicit stationarity tests or differencing, thus avoiding the associated challenges.

> - **Reference:**
>   [PKU Course on Financial Time Series](https://www.math.pku.edu.cn/teachers/lidf/course/fts/ftsnotes/html/_ftsnotes/ssm.html#ssm-cases-arima)
>   **Advantages of State-Space Models:**
>   - More flexible, allowing for time-varying mechanisms that are difficult to incorporate in ARIMA models.
>   - Handles missing values with ease.
>   - Facilitates the inclusion of additional explanatory variables, allowing for time-varying regression coefficients and calendar adjustments.
>   - Provides a unified framework for forecasting.
>   - Does not require stationarity or differencing.

By leveraging SSM, we can streamline the modeling process, making it more efficient and adaptable for analyzing FeeRatio dynamics across different pools.

## Other Problems to Solve

After estimating the parameters, how can we determine the **optimal FeeRatio** for each pool?

- The time-series model is defined in a **recursive form**. For example, we can express it as:

$$
\begin{aligned}
EfficientRatio_t=A*FeeRatio_{t}+\varepsilon_t\\
FeeRatio_t=B*FeeRatio_{t-1}+\eta_t
\end{aligned}
$$

- Even with the estimated parameters, determining the **optimal FeeTier** within this system is nontrivial:
  - In a **linear system**, an optimal FeeRatio may not exist within the open interval of its feasible range.
  - In a **nonlinear system**, we must account for the impact of past values, which may necessitate running simulations to explore optimal solutions.

(To be verified) One possible approach is to consider a **fixed-coefficient regression model** within the **State-Space Model (SSM) framework**. However, the limitations of this approach remain unclear and require further investigation. At the very least, two critical aspects need to be addressed:

1. **Synchronization Effects** – Whether the impact of FeeRatio on EfficientRatio exhibits **consistent time-dependent patterns** across different pools.
2. **Stationarity** – If stationarity is not required, this approach may be a viable solution. However, if stationarity must be ensured, additional transformations or constraints might be necessary.

Mathematically, this model can be expressed as:
$$
\begin{aligned}
EfficientRatio_t&=\beta_1FeeRatio_t+\beta_2FeeRatio_t^2(+...) \\
FeeRatio_t&=FeeRatio_{t-1}+\eta_t,\ \{\eta_t\} \sim \text{i.i.d}\  N(0,\sigma_\eta^2)
\end{aligned}
$$

----------

This formulation assumes that **FeeRatio follows a random walk**, which allows for dynamic adaptation while keeping the regression structure relatively simple. Further empirical validation is needed to determine whether this model effectively captures the underlying dynamics of the system.

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
- Performing linear interpolation for pools with missing **AMM TVL** data, and removing pools that had missing data at either end of the time window
- Performing linear interpolation for pools with missing **FeeRatio** data, and removing pools that had missing data at either end of the time window
- Deleting data from 2025-03-07 for pools with missing **AverageIY** and **FeeRatio** values。

Through these preprocessing operations, we ensured that no missing values for **FeeRatio** or **EfficientRatio** remained in the dataset.

After these operations, we were left with a dataset containing 34,075 rows and 206 unique pools.

# Modeling: An Example

To illustrate the process of modeling the relationship between the time-series data of FeeRatio and EfficientRatio, we can present an example.

In this section, we select one pool for analysis. Here, we choose **Bedrock UniETH 27JUN2024**.

We can visualize the changes in FeeTier, Average Implied APY, FeeRatio, and EfficientRatio through the following graphs.

![Bedrock_UniETH_27JUN2024](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Bedrock_UniETH_27JUN2024.png)

From the graph above, we observe the following for **Bedrock UniETH 27JUN2024**:

- The **FeeTier** was slightly reduced on **2024-03-29**.
- There is a clear negative correlation between the trends of **FeeRatio** and **Average Implied APY**.
- The **EfficientRatio** shows significant fluctuations, especially after the pool was launched. There was a brief and sharp rise and fall in **EfficientRatio** shortly after the pool went live, reaching a peak after the minor FeeTier adjustment, followed by a gradual decline.

Ignoring the time-series characteristics, we can directly plot FeeRatio and EfficientRatio on a scatter plot:

![Bedrock_UniETH_27JUN2024_scatter](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Bedrock_UniETH_27JUN2024_scatter.png)



## Fixed-Coefficient Regression Model

As we did in the Absolute Fee report, we propose the following polynomial model:
$$
EfficientRatio_t=\beta_0+\sum_{i=1}^l\beta_iFeeRatio_t^i+\varepsilon_t \tag{1}
$$
For example, if we are using a quadratic regression model, equation (1) would become:
$$
EfficientRatio_t=\beta_0+\beta_1FeeRatio_t+\beta_2FeeRatio_t^2+\varepsilon_t
$$
In polynomial model, we make the following assumptions:

- **FeeRatio only has a contemporaneous effect** on EfficientRatio, so we do not include any time-lagged terms in the model. This is essentially equivalent to a fixed-coefficient regression model that does not account for time-series properties.
- **FeeRatio has a nonlinear impact** on EfficientRatio, meaning it will generally maximize EfficientRatio at some point.
- The **coefficients remain fixed** over time, i.e., they do not change over time t.

If we assume that $$\varepsilon_t$$ follows an **independently and identically distributed normal distribution** for all t, we can estimate the parameters using **Ordinary Least Squares (OLS)**.

However, since time-series variables often exhibit autocorrelation, which violates the assumptions of OLS, we can address this issue by using **Heteroskedasticity and Autocorrelation Consistent Standard Errors (HAC)**.

For the **Bedrock UniETH 27JUN2024** pool, to avoid overfitting, we can determine the order of the polynomial by using information criteria such as AIC, BIC, and adjusted R-squared

- In the previous **Absolute Fee Report**, we primarily used adjusted R-squared to determine the order of the model. To make the results more robust, here we also include two well-known information criteria: **Akaike Information Criterion (AIC)** and **Bayesian Information Criterion (BIC)**.
- **AIC (Akaike Information Criterion)** is a measure used to assess the quality of a statistical model, taking into account both the goodness of fit and the complexity of the model. 
- **BIC (Bayesian Information Criterion)** is similar to AIC but adds a stronger penalty for model complexity. 

Below are the results of the model order selection using these criteria:

| Order    | AIC             | BIC             | Adjusted R²      |
| -------- | --------------- | --------------- | ---------------- |
| Order 1  | -615.6144       | -607.2270       | 0.04637790       |
| Order 2  | -619.0889       | -607.9057       | 0.08083762       |
| Order 3  | -617.5069       | -603.5279       | 0.07617842       |
| Order 4  | -622.9277       | -606.1529       | 0.12364304       |
| Order 5  | -629.9155       | -**610.3450**\* | 0.17930455       |
| Order 6  | -630.5270       | -608.1606       | 0.18978180       |
| Order 7  | -631.1899       | -606.0278       | 0.20040412       |
| Order 8  | -**634.3102**\* | -606.3523       | **0.22669069\*** |
| Order 9  | -632.3108       | -601.5571       | 0.21972807       |
| Order 10 | -632.3447       | -598.7953       | 0.22575924       |

- In the table, "Order" represents the highest degree term included in the model. For example, "Order 5" means that terms up to the fifth power are included in the model.
- The asterisk (*) indicates the optimal choice for each criterion.

As can be seen, both AIC and adjusted R-squared suggest including up to the 8th-degree terms, while BIC supports a model with up to the 5th degree. We can further examine the parameter estimates for both models to make a more informed decision:

First, here are the regression coefficients and their significance for the 5th-degree model:

|               | Estimate    | HAC        | HAC t value | p           |
| ------------- | ----------- | ---------- | ----------- | ----------- |
| (Intercept)   | -0.83       | 0.31       | -2.70       | 0.008026528 |
| I(FeeRatio^1) | 127.22      | 47.13      | 2.70        | 0.00799978  |
| I(FeeRatio^2) | -6840.16    | 2660.26    | -2.57       | 0.011409168 |
| I(FeeRatio^3) | 171529.50   | 69757.76   | 2.46        | 0.015424721 |
| I(FeeRatio^4) | -2029699.00 | 859282.30  | -2.36       | 0.019852888 |
| I(FeeRatio^5) | 9150067.00  | 4016318.00 | 2.28        | 0.024560109 |

Then, here are the results for the 8th-degree model:

|               | Estimate          | HAC              | HAC t value | p           |
| ------------- | ----------------- | ---------------- | ----------- | ----------- |
| (Intercept)   | 10.75             | 5.10             | 2.11        | 0.037353205 |
| I(FeeRatio^1) | -2722.28          | 1280.79          | -2.13       | 0.035687355 |
| I(FeeRatio^2) | 286991.00         | 134984.90        | 2.13        | 0.035633926 |
| I(FeeRatio^3) | -16425470.00      | 7805936.00       | -2.10       | 0.037537143 |
| I(FeeRatio^4) | 560599000.00      | 271032000.00     | 2.07        | 0.040845893 |
| I(FeeRatio^5) | -11737660000.00   | 5794862000.00    | -2.03       | 0.045128286 |
| I(FeeRatio^6) | 147872900000.00   | 74676740000.00   | 1.98        | 0.050072164 |
| I(FeeRatio^7) | -1028782000000.00 | 531632700000.00  | -1.94       | 0.055429049 |
| I(FeeRatio^8) | 3036354000000.00  | 1604924000000.00 | 1.89        | 0.061019427 |

- From the p-values, we can observe that the regression coefficients in the 5th-degree model are significantly different from zero, even after HAC adjustment.
- Furthermore, the p-values of the coefficients in the 5th-degree model are better than those in the 8th-degree model.

Considering that BIC favors simpler models and the significance levels of the regression coefficients are better in the 5th-degree model, we ultimately decide to choose the 5th-degree model to describe the relationship between FeeRatio and EfficientRatio for this pool.

Additionally, we can calculate the maximum point of the fitted curve, which represents the optimal FeeRatio for maximizing EfficientRatio.
$$
(FeeRatio=2.165444\%, Expected EfficientRatio=5.642599\%)
$$
To visually demonstrate this, we can plot the following graph:
![image-20250307165143450](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250307165143450.png)

# Aggregating Results

Now that we have determined the optimal FeeRatio for Bedrock UniETH 27JUN2024, we can apply this algorithm to all the pools. After estimating the optimal FeeRatio for each pool, we can aggregate the results to derive a global Optimal FeeRatio based on a certain criterion.

Typically, we consider two different methods for this aggregation.

## Weighted Average

The first method is the weighted average. For example, we can set the weights based on TVL or any other metric that we deem important. The accuracy of the global optimal FeeRatio obtained through this method depends entirely on how we set the weights. The advantage of this method is its flexibility, as it allows us to adjust the weights according to specific metrics. However, the drawback is that it lacks statistical evidence, meaning we cannot determine whether the global parameter we obtain is statistically reasonable.

Here, we demonstrate a weighted average method based on the historical average TVL of the pools. For example, below are the historical average TVL and the corresponding optimal FeeRatios for 10 pools:



The global optimal FeeRatio for these samples would be:



Once we have this data for all pools, we can calculate the global optimal FeeRatio that applies to all 206 pools:





## Estimating the Overall Mean

Another way to aggregate the data from all pools is through the estimation of the overall mean. Compared to the weighted average method, this approach has more statistical grounding. Specifically, we can assume that the global optimal FeeRatio follows a specific distribution, such as a normal distribution. With the optimal FeeRatios from over two hundred pools, we can treat these as samples drawn from this distribution. We can then apply specific methods, such as Maximum Likelihood Estimation (MLE), to estimate the mean and variance of this overall distribution. In particular, the mean we estimate can be considered a statistically sound estimate of the global optimal FeeRatio, which we can use to set the global parameter.

We can estimate the overall mean to be: (Insert estimated mean value)
 This implies that the global optimal FeeRatio should be set to: (Insert global optimal FeeRatio)

Another benefit of using this method is that we can provide a confidence interval for the estimate. The 95% confidence interval for the overall mean is calculated as: (Insert 95% confidence interval)

The downside of this method is that it relies on our assumption about the overall distribution. If the optimal FeeRatio does not follow a normal distribution or any other distribution we have assumed, then our estimate may be flawed.



# Robustness Analyses

## Starting from the Global Optimal FeeRatio

Since our current model essentially ignores the time-series characteristics and resembles a cross-sectional regression, we can pool all the data from the active periods of each pool into a single dataset, comprising over 30,000 data points. Using this dataset, we can directly estimate the regression parameters, fit the curve, and find the FeeRatio that maximizes the fitted curve. This will serve as the global optimal FeeRatio parameter.

Why didn’t we do this from the beginning? This is because, when considering the time-series characteristics, the differences between the pools are substantial, such as differing active days. Consequently, we cannot use this method of pooling all the pools’ data to directly estimate parameters. This means that we must estimate the optimal FeeRatio for each pool separately and aggregate the results. In the next subsection, we will see this more clearly when we apply specialized time-series modeling techniques—specifically, the State Space Model.

## Estimate the parameters using State Space Model

# Heterogeneity Analysis

Previously, we aggregated the data using two methods to obtain the global optimal FeeRatio parameter. However, we are also concerned whether the optimal FeeRatio parameter changes by grouping—for example, whether adjustments are needed for pools with BaseAssets of ETH or Stablecoins. In this section, we will focus on exploring this issue.

# Conclusions

1
