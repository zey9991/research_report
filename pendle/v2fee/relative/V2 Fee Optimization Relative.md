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

The dataset utilized in this report is available in the "Adhoc Report" section of the Pool Metrics dataset, with data retrieved on 2025-03-07.

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
OptimalFeeRatio_{Bedrock UniETH 27JUN2024}=0.02165444
$$
To visually demonstrate this, we can plot the following graph:

![image-20250307165143450](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250307165143450.png)

# Aggregating Results

Now that we have determined the optimal FeeRatio for Bedrock UniETH 27JUN2024, we can apply this algorithm to all the pools. After estimating the optimal FeeRatio for each pool, we can aggregate the results to derive a global Optimal FeeRatio based on a certain criterion.

Typically, we consider two different methods for this aggregation.

## Weighted Average

The first method is the weighted average. For example, we can set the weights based on TVL or any other metric that we deem important. The accuracy of the global optimal FeeRatio obtained through this method depends entirely on how we set the weights. The advantage of this method is its flexibility, as it allows us to adjust the weights according to specific metrics. However, the drawback is that it lacks statistical evidence, meaning we cannot determine whether the global parameter we obtain is statistically reasonable.

Here, we demonstrate a weighted average method based on the historical average TVL of the pools. For example, below are the historical average TVL and the corresponding optimal FeeRatios for 10 pools:

| Pool                                   | Optimal FeeRatio | TVL                |
| -------------------------------------- | ---------------- | ------------------ |
| Aave_aUSDC_26DEC2024                   | 0.007500975      | 579748.0574682716  |
| Aave_Ethereum_USDT_26JUN2025           | 0.020744433      | 239716.48101730828 |
| Aerodrome_VIR/CBBTC_26JUN2025          | 0.019218241      | 1242137.948072133  |
| Aladdin_sdCRV_26JUN2025                | 0.014224466      | 318792.09819704015 |
| Amphor_LRT_26DEC2024                   | 0.009941479      | 5106022.381041232  |
| Amphor_LRT_26SEP2024                   | 0.014894995      | 9335083.455937527  |
| ankrBNB_26JUN2025                      | 0.019481182      | 754382.9861734031  |
| ankrETH_WETH_BalancerLP_Aura_26SEP2024 | 0.041466278      | 314340.80509406887 |
| ankrETH_WETH_BalancerLP_Aura_28MAR2024 | 0.003118437      | 169800.63078518893 |
| ARB_ETH_Camelot_27JUN2024              | 0.032033558      | 809023.8249134828  |

The global optimal FeeRatio for these samples would be: 0.014929819

Once we have this data for all pools, we can calculate the global optimal FeeRatio that applies to all 206 pools: 
$$
OptimalFeeRatio_{wa}= 0.01520877
$$

## Estimating the Overall Mean

Another way to aggregate data from all pools is by estimating the **overall mean**. Compared to the weighted average method, this approach is more **statistically rigorous**. Specifically, we assume that the global optimal **FeeRatio** follows a specific probability distribution—such as a normal distribution. Given that we have **over two hundred pools**, we can treat their optimal FeeRatios as **samples drawn from this distribution**. Using **Maximum Likelihood Estimation (MLE)**, we can estimate the **mean** and **variance** of the overall distribution. The estimated mean, in particular, serves as a **statistically sound global optimal FeeRatio**, which we can use to set the **global parameter**.

The estimated overall mean is: **0.02796956**. This implies that the global optimal FeeRatio should be set to this number.

One advantage of this method is that it allows us to **construct a confidence interval** for our estimate. The **95% confidence interval** for the overall mean is: **( 0.008019949 , 0.04791916 )**

Even if our assumption of normality does not hold—i.e., the true distribution of the **optimal FeeRatio** is not exactly normal—our estimate remains **statistically valid** due to the **Central Limit Theorem (CLT)**. The CLT states that as the **sample size increases**, the **sampling distribution of the sample mean** approaches a normal distribution, **provided that the samples are independently and identically distributed (i.i.d.)**.

To gain a better understanding of the distribution of optimal FeeRatios, we visualize it using both a **histogram** and a **kernel density estimate (KDE)**. While a histogram represents the frequency distribution of observed values, the KDE provides a **smoother approximation** of the underlying probability density function.

The plot below illustrates the histogram alongside the kernel density estimate:

![Histogram, Kernel Density and Normal Density of Optimal FeeRatio](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250308152141718.png)

> **Note:** One extreme outlier has been **removed**. The pool **Lombard_LBTC_26JUN2025** has an estimated **optimal FeeRatio** of **2.0997459579**, which is likely **unreliable** due to the **small sample size (only 16 samples)**, making the estimate highly unstable.
>
> As a comparison, after removing this extreme outlier, the **new estimate** for the overall mean is **0.01786333** with a **95% confidence interval** of (0.01547763,0.02024903). This result aligns closely with the **weighted average method**. Thus, if we consider removing this extreme outlier to be **reasonable**, we may set the **optimal FeeRatio** as **0.01786333**.

**Key Observations**

- Even with a large sample size, we do not observe a clear bell-shaped normal density curve. This is primarily due to **truncation near zero**, where optimal FeeRatios are bounded from below. However, this truncation does **not** invalidate the Central Limit Theorem. If a random variable is truncated within a certain range (e.g., near zero), its shape may be altered, but as long as the truncated variable remains **i.i.d. with finite variance**, the CLT still holds, and the sample mean will converge to a normal distribution.

- Additionally, the distribution of **Optimal FeeRatios exhibit heavier tails** than a normal distribution. This suggests the possibility of **infinite variance**, which would **invalidate the CLT**. In such cases, the sample mean may converge to a **stable distribution** other than the normal distribution. 

To make the data **better conform to a normal distribution**, we apply a **log transformation** to the **optimal FeeRatio** and replot the histogram and KDE for comparison:

![Histogram, Kernel Density and Normal Density of log(Optimal FeeRatio)](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250308154954780.png)

The transformed distribution **appears much closer** to a normal probability density curve.

To formally verify whether the **log-transformed optimal FeeRatio** follows a normal distribution, we conduct **three common normality tests**:

| Test Method                          | Test Statistic | p-value | Conclusion (α = 0.05)                                |
| ------------------------------------ | -------------- | ------- | ---------------------------------------------------- |
| Shapiro-Wilk Normality Test          | W = 0.98976    | 0.1523  | Fail to reject H₀ (Data may be normally distributed) |
| Anderson-Darling Normality Test      | A = 0.7594     | 0.0475  | Reject H₀ (Data may not be normally distributed)     |
| Lilliefors (Kolmogorov-Smirnov) Test | D = 0.056449   | 0.1145  | Fail to reject H₀ (Data may be normally distributed) |

- The **Shapiro-Wilk** and **Lilliefors tests** yield **p-values > 0.05**, meaning we **fail to reject** the null hypothesis, suggesting that the **data may be normally distributed**.
- However, the **Anderson-Darling test** produces a **p-value slightly below 0.05**, indicating a **potential deviation** from normality.
- Since different tests have varying **sensitivity and statistical power**, results can differ. Overall, while the **Anderson-Darling test** suggests some deviation, the other two tests **do not detect significant departures from normality**.
- Therefore, the **log-transformed optimal FeeRatio** can be **reasonably approximated** by a normal distribution.

Using this transformation, we estimate the **mean of the log-transformed distribution** to be **-4.39146**, with an estimated variance of **0.78376**.

To express this result in our desired form, we must recall the properties of the **log-normal distribution**. Suppose a random variable $$X$$ follows a log-normal distribution, meaning:
$$
lnX\sim N(\mu, \sigma^2)
$$
Letting $$Y=lnX$$， we know that for a normally distributed variable $$Y$$, the expectation and variance are given by $$E(Y)=\mu$$ and $$Var(Y)=\sigma^2$$. Now, we seek to recover the expected value of $$X$$ . It can be shown that:
$$
E(X)=e^{\mu+\frac{\sigma^2}{2}}
$$
Using this formula, we compute the back-transformed mean as **0.01832333**, suggesting that we should set:
$$
OptimalFeeRatio_{log(om)}=0.01832333
$$
This result is **remarkably close** to our earlier estimate of **0.01786333**, obtained after removing the extreme outlier.

The **95% confidence interval** for the log-transformed mean is (-4.512649 , -4.270271). To compute the variance of the original distribution, we apply the following transformation:
$$
Var(X)=e^{2\mu+\sigma^2}(e^{\sigma^2}-1)
$$
Substituting our estimates, we obtain the original variance as $$3.99431929\times10^{-4}$$. Consequently, the **95% confidence interval** for the back-transformed mean is **(0.01558748 , 0.02105918)**

Thus, we can conclude that the **optimal FeeRatio** should be set to approximately 0.01832333. This transformation-based estimate aligns with previous results while providing **greater statistical robustness** by addressing potential distributional issues.

# Robustness Analyses

## Starting from the Global Optimal FeeRatio

Since our current model essentially ignores the time-series characteristics and resembles a cross-sectional regression, we can pool all the data from the active periods of each pool into a single dataset, comprising over 30,000 data points. Using this dataset, we can directly estimate the regression parameters, fit the curve, and find the FeeRatio that maximizes the fitted curve. This will serve as the global optimal FeeRatio parameter.

**Why didn’t we do this from the beginning?** This is because, when considering the time-series characteristics, the differences between the pools are substantial, such as differing active days. Consequently, we cannot use this method of pooling all the pools’ data to directly estimate parameters. This means that we must estimate the optimal FeeRatio for each pool separately and aggregate the results. In subsequent reports, we will see this more clearly when we apply specialized time-series modeling techniques.

To initiate our global regression model, we first visualize the relationship between **FeeRatio** and **Coefficient** using a scatter plot, similar to our approach in the previous section.

![image-20250308095745817](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250308095745817.png)

From the plot above, we observe several **outliers** in both **FeeRatio** and **EfficientRatio**. Since **Ordinary Least Squares regression is highly sensitive to outliers**, it is prudent to address these extreme values. However, for completeness, we will still provide the original regression results without outlier adjustments.

As in the **Absolute Fee Report**, we employ **winsorization** and **trimming** at the **1%**, **2.5%**, and **5%** tails to mitigate the impact of outliers. The table below presents the corresponding results:

| scenario       | best_degree | Optimal FeeRatio       |
| -------------- | ----------- | ---------------------- |
| None           | 1           | 4.161816589(discarded) |
| Trim_1%        | 10          | 0.050055974            |
| Trim_2.5%      | 10          | 0.005280442            |
| Trim_5%        | 7           | 0.004971396            |
| Winsorize_1%   | 8           | 0.052772435            |
| Winsorize_2.5% | 10          | 0.034525311            |
| Winsorize_5%   | 9           | 0.019269072            |

From the table above, we observe that performing global regression without any outlier adjustment produces an **Optimal FeeRatio** of approximately **4.16**, which is clearly unreasonable and should be discarded. In contrast, applying **trimming** and **winsorization** yields significantly lower and more reasonable values for the **Optimal FeeRatio**.

However, the **Optimal FeeRatio** obtained from **2.5% and 5% trimming** appears **too low**, suggesting that these levels of trimming might be excessive. Meanwhile, the results from **winsorization** exhibit much smaller variations. This makes sense, as **trimming removes extreme samples entirely**, whereas **winsorization only replaces extreme values with threshold values**, making the results more sensitive to trimming than winsorization.

Considering that the scatter plot does not reveal an overwhelming number of outliers, a **1% trimming or winsorization** appears to be the most appropriate choice, while **2.5% and 5% adjustments might be overly aggressive**. 

To illustrate this point, we provide scatter plots for the **1% trimming** and **1% winsorization** cases below. As shown, after applying these adjustments, there are no apparent outliers remaining. This further supports the conclusion that a **1% adjustment is sufficient**, while **higher levels of trimming or winsorization may be unnecessary**.

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250308114734472.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20250308114654930.png)

For reference, our previous **weighted average approach** suggested an **Optimal FeeRatio** of approximately **0.015**, while the **overall mean estimation** approach yielded **0.018**. If we believe that a **1% adjustment is sufficient**, the **Optimal FeeRatio** could be even higher, around **0.05**.

# Heterogeneity Analysis

Previously, we aggregated the data using two different approaches to derive the globally optimal **FeeRatio** parameter. However, an important question remains: **Does the optimal FeeRatio parameter vary across different groups?** Specifically, do pools with BaseAssets such as **ETH** or **Stablecoins** require different adjustments? In this section, we investigate this issue in detail.

## Weighted Average

By applying the **historical average TVL-weighted** approach to different BaseAssets, we can efficiently compute the **Optimal FeeRatio** for each group. The results are summarized in the table below:

| Base Asset | Weighted Avg Optimal FeeRatio | Pool Count |
| ---------- | ----------------------------- | ---------- |
| BTC        | 0.0283                        | 16         |
| ETH        | 0.0142                        | 109        |
| Other      | 0.0130                        | 27         |
| Stable     | 0.0129                        | 59         |

The findings suggest that **BTC pools can sustain a significantly higher FeeRatio**, nearly twice that of ETH pools. Meanwhile, the remaining three groups (ETH, Other, and Stablecoins) exhibit relatively **lower optimal FeeRatios**.

## Estimating the Overall Mean

An alternative approach is to estimate the **overall mean** within each group. However, it is crucial to acknowledge a limitation: Some groups contain **relatively small sample sizes** (e.g., the BTC group has only **16 samples**), which may not be sufficient for the **central limit theorem** to hold. As a result, the estimated values might not be highly reliable. Nevertheless, as we accumulate more within-group samples in the future, the precision of our estimates will improve.

The table below presents the estimated **population mean and variance** for each group, obtained by leveraging the properties of the **log-normal distribution**. The last two columns provide the **95% confidence intervals** for the estimated means.

| Base Asset | n    | Estimated Mean | Estimated Variance | Lower Mean | Upper Mean |
| ---------- | ---- | -------------- | ------------------ | ---------- | ---------- |
| BTC        | 15   | 0.0258         | 0.000390           | 0.0177     | 0.0375     |
| ETH        | 109  | 0.0209         | 0.000563           | 0.0176     | 0.0248     |
| Other      | 27   | 0.0141         | 0.000468           | 0.00914    | 0.0218     |
| Stable     | 59   | 0.0145         | 0.000113           | 0.0123     | 0.0172     |

- The **optimal FeeRatio** estimated for the **BTC group** is slightly **lower** than that obtained via the weighted average method, whereas the remaining three groups exhibit **higher values**.
- Notably, the **ETH group's optimal FeeRatio has increased significantly** to **0.0209**, deviating from the weighted average estimate.

### Statistical Tests for Group Differences

To rigorously assess whether the differences across these four groups are **statistically significant**, we conduct formal hypothesis testing.

- If the test confirms **significant differences**, it would justify **group-specific** optimal FeeRatio settings.
- Conversely, if no significant differences are found, it suggests that all samples might originate from a **single underlying distribution**, meaning we could use the **global mean** estimated in the previous section (*Aggregating Results*).

Since the **log-transformed Optimal FeeRatio** follows a distribution closer to normality, we apply a **one-way ANOVA** to examine differences in **log(Optimal FeeRatio)** across groups.

On the other hand, since the **original Optimal FeeRatio** follows a **log-normal-like** distribution, we use a **non-parametric test** (e.g., the **Kruskal–Wallis test**) to compare group differences.

**One-Way ANOVA Results (log-transformed Optimal FeeRatio)**

| Factor     | Df   | Sum Sq | Mean Sq | F Value | Pr(>F)  |
| ---------- | ---- | ------ | ------- | ------- | ------- |
| Base Asset | 3    | 11.18  | 3.728   | 5.043   | 0.00216 |
| Residuals  | 206  | 152.29 | 0.739   | -       | -       |

Since the **p-value** is **0.00216 < 0.01**, we can conclude with **99% confidence** that the four groups come from **different populations**.

**Kruskal–Wallis Test Results (Original Optimal FeeRatio)**

| Test                         | Chi-Squared | Df   | P-Value  |
| ---------------------------- | ----------- | ---- | -------- |
| Kruskal-Wallis rank sum test | 13.621      | 3    | 0.003469 |

Similarly, since the **p-value** is **0.003469 < 0.01**, we again conclude with **99% confidence** that the four groups come from **different distributions**.

Both the parametric (**ANOVA**) and non-parametric (**Kruskal–Wallis**) tests confirm that **the four groups belong to different populations**, providing strong justification for estimating and applying **group-specific optimal FeeRatios**.

## Grouped Regression

Similar to our approach in the **robustness analysis**, we conduct **grouped regression** on all observed data to determine the **optimal FeeRatio** for each group. At the same time, we must remain mindful of **outlier treatment**.

The table below presents the **optimal FeeRatio** and the corresponding **expected EfficientRatio** for each group under different outlier treatment strategies. 

We include **expected EfficientRatio** as an additional reference metric, as it helps assess the validity of the estimated **optimal FeeRatio**. 

For instance, in the **ETH group**, while the estimated **optimal FeeRatio** of **0.126472967** falls within a plausible range, the corresponding **expected EfficientRatio** is an **unreasonably high** **179.44558250**. This suggests that the **optimal FeeRatio** for this group should be discarded.

**Grouped Regression Results for Base Asset ETH**

| Scenario       | Best Degree | Optimal FeeRatio | Expected EfficientRatio |
| -------------- | ----------- | ---------------- | ----------------------- |
| None           | 1           | 0.126472967      | 179.44558250            |
| Trim_1%        | 10          | 0.049968788      | 0.03776242              |
| Trim_2.5%      | 10          | 0.005258390      | 0.02293102              |
| Trim_5%        | 8           | 0.005351746      | 0.02314881              |
| Winsorize_1%   | 10          | 0.049490670      | 0.03995776              |
| Winsorize_2.5% | 10          | 0.044177179      | 0.02587934              |
| Winsorize_5%   | 7           | 0.004198041      | 0.02890451              |

- The result without any trimming or winsorizing (the first row in the table above) should be discarded because the expected **Efficient Ratio** is clearly too high and unreasonable.

**Grouped Regression Results for Base Asset BTC**

| Scenario       | Best Degree | Optimal FeeRatio | Expected EfficientRatio |
| -------------- | ----------- | ---------------- | ----------------------- |
| None           | 1           | 4.161816589      | 0.04456677              |
| Trim_1%        | 10          | 0.020167154      | 0.02367652              |
| Trim_2.5%      | 10          | 0.020335376      | 0.02232156              |
| Trim_5%        | 10          | 0.028928699      | 0.02290693              |
| Winsorize_1%   | 10          | 0.020586818      | 0.02452002              |
| Winsorize_2.5% | 10          | 0.029047145      | 0.02379953              |
| Winsorize_5%   | 10          | 0.028618067      | 0.02545570              |

- The result without any trimming or winsorizing (the first row in the table above) should be discarded because the expected **Optimal Fee Ratio** is clearly too high and unreasonable.

**Grouped Regression Results for Base Asset Stable**

| Scenario       | Best Degree | Optimal FeeRatio | Expected EfficientRatio |
| -------------- | ----------- | ---------------- | ----------------------- |
| None           | 5           | 0.143177100      | 0.26432985              |
| Trim_1%        | 6           | 0.053678695      | 0.09706117              |
| Trim_2.5%      | 9           | 0.029525993      | 0.09703206              |
| Trim_5%        | 7           | 0.029069703      | 0.07220110              |
| Winsorize_1%   | 4           | 0.036057461      | 0.09251266              |
| Winsorize_2.5% | 9           | 0.029689288      | 0.10027767              |
| Winsorize_5%   | 7           | 0.029086683      | 0.09372134              |

**Grouped Regression Results for Base Asset Other**

| Scenario       | Best Degree | Optimal FeeRatio | Expected EfficientRatio |
| -------------- | ----------- | ---------------- | ----------------------- |
| None           | 10          | 0.163047672      | 0.33788477              |
| Trim_1%        | 9           | 0.014886009      | 0.04869810              |
| Trim_2.5%      | 2           | 0.015837980      | 0.02334372              |
| Trim_5%        | 5           | 0.005269409      | 0.01938041              |
| Winsorize_1%   | 9           | 0.014886009      | 0.06479983              |
| Winsorize_2.5% | 10          | 0.014415999      | 0.06136141              |
| Winsorize_5%   | 10          | 0.013305047      | 0.03348580              |

# Conclusions

本文提供了一种粗略地设置每个pool的最优FeeRatio的几种方法，不同的方法结果各异，方法也各有优劣。具体来说

- 如果我们采用求解各个池子的最优FeeRatio并聚合的方法
- 如果我们采用直接对全部样本回归