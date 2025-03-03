### **Weekly Meeting Update:**

Date: 2025-03-03

Over the past week, my primary focus has been on the following tasks:

- After discussing with Jon, I completed the data cleaning process, ensuring that the remaining FeeRatio and EfficientRatio values for all samples are free from missing data. Additionally, even with updates to the dataset, the code remains reusable.
- I tested the stationarity of FeeRatio and EfficientRatio and found that most FeeRatios fail the unit root test, indicating that they are not stationary. Furthermore, the stationarity of FeeRatio and EfficientRatio varies across different pools, as detailed in the table below.

|                   | FeeRatio_none_p | FeeRatio_drift_p | FeeRatio_trend_p | EfficientRatio_3_none_p | EfficientRatio_3_drift_p | EfficientRatio_3_trend_p |
| :---------------- | :-------------- | :--------------- | :--------------- | :---------------------- | :----------------------- | :----------------------- |
| (0,0.01] Count    | 4.00000000      | 11.00000000      | 18.00000000      | 146.00000000            | 150.00000000             | 153.00000000             |
| (0.01,0.05] Count | 8.00000000      | 4.00000000       | 13.00000000      | 17.00000000             | 10.00000000              | 14.00000000              |
| (0.05,0.10] Count | 4.00000000      | 7.00000000       | 8.00000000       | 10.00000000             | 9.00000000               | 8.00000000               |
| (0.10,1] Count    | 182.00000000    | 176.00000000     | 159.00000000     | 25.00000000             | 29.00000000              | 23.00000000              |
| (0,0.01] Prop     | 0.02020202      | 0.05555556       | 0.09090909       | 0.73737374              | 0.75757576               | 0.77272727               |
| (0.01,0.05] Prop  | 0.04040404      | 0.02020202       | 0.06565657       | 0.08585859              | 0.05050505               | 0.07070707               |
| (0.05,0.10] Prop  | 0.02020202      | 0.03535354       | 0.04040404       | 0.05050505              | 0.04545455               | 0.04040404               |
| (0.10,1] Prop     | 0.91919192      | 0.88888889       | 0.80303030       | 0.12626263              | 0.14646465               | 0.11616162               |

- Stationarity is a critical aspect in traditional time-series modeling. The inconsistency in stationarity between the two variables has made the previously selected model unsuitable in all cases. For example, one variable might be stationary while the other is not, requiring differencing, but differenced models make the coefficients difficult to interpret. This led me to explore a new theoretical approach: the state-space model. This model can unify the previously selected models and is more concise and powerful. It can accommodate both linear and nonlinear situations, but I will need several days to review the literature and familiarize myself with it. Here is a brief idea of how I plan to model it:

$$
\begin{aligned}
FeeRatio_t & =AFeeRatio_{t-1}+\epsilon_t,\ \{\epsilon_t\}\sim \text{i.i.d}\ N(0,\sigma_\epsilon^2)\\
EfficientRatio_{t+1} & =BEfficientRatio_t+\eta_t,\ \{\eta_t\} \sim \text{i.i.d}\  N(0,\sigma_\eta^2)
\end{aligned}
$$

- In practice, we can consider a fixed coefficient regression model. However, the limitations of this model are not yet fully clarified and may include at least two factors: (1) testing for synchronization effects and (2) whether the model is stationary. If stationarity is not required, this approach may be suitable for our problem.

$$
\begin{aligned}
EfficientRatio_t&=\beta_1FeeRatio_t+\beta_2FeeRatio_t^2(+...) \\
FeeRatio_t&=FeeRatio_{t-1}+\eta_t,\ \{\eta_t\} \sim \text{i.i.d}\  N(0,\sigma_\eta^2)
\end{aligned}
$$

----------

Date: 2025-02-25

Over the past week, I’ve been reviewing various time-series models and have largely finalized the models needed for modeling **Fee Ratio** and **Efficient Ratio**. My main focus for the upcoming week will be attempting to implement these models.

**Question on Data Retrieval**

Does Looker Studio provide an efficient way to export time-series data? Specifically:

- For **By EfficientRatio** under **Pool Metrics**, is there a way to transform this into a time-series format (e.g., daily data) for export?
- For **By SwapFee**, the time span can be selected, but if the data needs to be downloaded manually for each period, the process becomes quite tedious.

Is there a more streamlined way to handle this? If not, I may need to explore web scraping techniques as an alternative.

—>Yes, we can. With Jon and AR7's assistance, we anticipate resolving the data retrieval issue very soon.

-------------

Date: 2025-02-18

Most of the robustness and heterogeneity analyses have been completed, with the remaining parts expected to be finished shortly.

**Robustness Analysis Results**

The results from the polynomial regression model show that the outcomes are not particularly sensitive to the replacement of control variables. The maximum value still occurs when **FeeTier** is large (close to 1.7%).

In contrast, the polynomial regression model is more sensitive to tail-trimming and winsorization. This is reflected in the increased explanatory power of the quadratic model with a monotonically increasing relationship, while the cubic model’s cubic term becomes insignificant more frequently. This suggests that the cubic model's results are more heavily influenced by extreme values. 

- Notably, a pool with a 2% FeeTier (**USUALX 27MAR2025**) is still active, and if its **EfficientRatio** changes significantly in the future, it may have a substantial impact on the results of this model.

**Heterogeneity Analysis Results**

When performing grouped regressions based on **BaseAsset**, the cubic regression model remains the optimal choice only when **BaseAsset** is ETH, and both the minimum and maximum values are detected. For **BaseAsset** values of BTC, Stable, or Other, there is a more monotonic relationship between **EfficientRatio** and **FeeTier**, with the fitted curve not showing a minimum or maximum within the open interval of **FeeTier**.

----------

Date: 2025-02-14

The dataset has been updated with February 8th data. 

I have checked and make sure that the numerator of the EfficientRatio includes all the fees we needed.

I created several scatter plots to visually explore the relationship between **FeeTier** and **EfficientRatio**. The scatter plots are color-coded based on categorical variables.

Next, I attempted to model the relationship between **FeeTier** and **EfficientRatio** using three nonlinear models that seemed most appropriate for the task. It's clear that a simple linear regression model is inadequate, as the optimal **FeeTier** for a straight line would only occur at the endpoints of the range.

- **Polynomial Regression Model**: Initially, I used a quadratic model, anticipating a potential inverted U-shaped relationship between **EfficientRatio** and **FeeTier**, where very low or very high **FeeTier** values would reduce the mean of **EfficientRatio**. However, the quadratic model did not align with the theoretical expectation, and the key coefficients were not significant.
- I then tried models with higher-order terms. After evaluating the adjusted R-squared values, I selected a cubic model. The results revealed an approximate inverted S-shape, with **EfficientRatio** increasing and then decreasing as **FeeTier** rises. The maximum value of the predicted curve was found near **FeeTier = 0.01902**, with a corresponding **EfficientRatio** of 0.37781. Additionally, the predictive curve also has a minimum point, where **EfficientRatio** reaches its lowest value of 0.03956 at **FeeTier = 0.00109**. 
- **Threshold Regression Model**: I next applied a threshold regression model, which fits a "piecewise" function. This model assumes that when **FeeTier** exceeds a certain threshold, the effect on **EfficientRatio**—both in magnitude and direction—changes. The model detected a threshold at **FeeTier = 0.0024**. Below this value, an increase in **FeeTier** actually leads to a decrease in **EfficientRatio**, with the opposite effect occurring above the threshold. Notably, this threshold value is very close to the minimum point detected in the cubic regression model.
- **Partial Linear Model**: Finally, I used a partial linear model, which makes no specific assumptions about the functional form of **FeeTier**. After testing, I found that the estimated results from this model were similar to the cubic model and can be considered as a supplementary approach.

Below is a table summarizing the key results for each model.

| Model Type                                  | Quadratic                                                    | Cubic                                                        | Threshold                                      | Partial Linear                                               |
| ------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------------------------- | ------------------------------------------------------------ |
| **Fitted Curve Shape**                      | Monotonically increasing                                     | S-shaped curve rotated 90 degrees counterclockwise           | V-shaped                                       | Monotonically increasing                                     |
| **Maximum Point Detected in Open Interval** | /                                                            | FeeTier = 0.01902                                            | /                                              | /                                                            |
| **Min Identified in Open Interval**         | /                                                            | FeeTier = 0.00109                                            | FeeTier = 0.0024                               | /                                                            |
| **Main Limitations**                        | Monotonically increasing doesn't meet theoretical expectations | Insufficient high FeeTier samples, the maximum point of EfficientRatio may be biased, needs verification | Poor fit of the model when FeeTier < Threshold | Test indicates this model can be approximated by a Cubic model |

In conclusion, the preliminary takeaway is that we can set **FeeTier** quite low, below, say, 0.2%, or set it higher, around 1%. Of course, the exact value for **FeeTier** should also take into account market dynamics, strategic goals, and other relevant factors.

Of course, all of these models might have potential issues, including but not limited to insufficient sample size, the impact of outliers, and omitted variables. As a next step, I plan to conduct robustness checks on these models. Additionally, I will perform heterogeneity/ ˌhetərədʒəˈniːəti / analysis based on different groupings.

