### **Weekly Meeting Update:**

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

