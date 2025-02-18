# V2 Fee Report

The Logic:

**How to find the optimal FeeTier?**

In this report, I fit the data using different models and identify the maximum point based on the shape of the fitted curves. These maximum points can be considered as the optimal FeeTier.

**Model Results**

If we assume that there should be a relationship between **EfficientRatio** and **FeeTier** that first increases and then decreases (similar to an inverted U-shape), with a maximum value, the following results can be used as a reference when setting the FeeTier:

- When initially using a cubic regression model, the fitted curve shows a maximum value at **(FeeTier = 0.01902, EfficientRatio = 0.37781)**.

![Predictive Margins with Control Variables at Median Value](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Predictive%20Margins%20with%20Control%20Variables%20at%20Median%20Value2.png)

- In the robustness check, the polynomial fitted curve still shows a maximum value after replacing the control variables:

  - Replacing **BaseAsset** with **Chain**: **(FeeTier = 0.01823, EfficientRatio = 0.42157)**.

  ![Precition Curve if Substituting BaseAsset with Chain](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Precition%20Curve%20if%20Substituting%20BaseAsset%20with%20Chain.png)

  - Replacing **BaseAsset** with **YieldSource**: **(FeeTier = 0.01688, EfficientRatio = 0.61392)**.

  ![Precition Curve if Substituting BaseAsset with YieldSource](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Precition%20Curve%20if%20Substituting%20BaseAsset%20with%20YieldSource.png)

- In the heterogeneity check, for the **ETH BaseAsset** group, the fitted curve still shows a maximum value at **(FeeTier = 0.00768, EfficientRatio = 0.37903)**.

![Precition Curve if BaseAsset is ETH](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Precition%20Curve%20if%20BaseAsset%20is%20ETH.png)

If we do not make the assumptions above and focus purely on data exploration, we can conclude that the currently set FeeTier is too low.

- In the polynomial regression model, the linear model also performs reasonably well, though it is less effective than the cubic model.
- The kernel regression plot of the **partially linear model** (similar to the fitted curve) also shows a monotonically increasing relationship.

![Kernel Regression Plot of EfficientRatio against FeeTier](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Kernel%20Regression%20Plot%20of%20EfficientRatio%20against%20FeeTier.png)

- In the heterogeneity analysis, when performing grouped regressions based on **BaseAsset**, except when **BaseAsset** is ETH, the fitted curves for other groups do not show a maximum or minimum within the open interval of **FeeTier**. This suggests that, as **FeeTier** increases, the model still expects **EfficientRatio** to continue increasing.

![Precition Curve if BaseAsset is Stable](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Precition%20Curve%20if%20BaseAsset%20is%20Stable.png)

Additionally, **in some cases, the model detected a minimum value**. **The reason for this minimum is not yet clear from an economic or financial theory perspective**, so this part of the result should be interpreted with caution. If necessary, it may be considered as a reference to avoid these regions when setting the FeeTier.

- The **Threshold regression model** indicates a threshold value of **0.0024**. When **FeeTier ≤ Threshold**, the regression coefficient is negative, meaning the minimum occurs at **FeeTier = 0.0024**.
- In the baseline cubic regression model, the fitted curve shows a minimum at **(FeeTier = 0.00109, EfficientRatio = 0.03956)**.

![Predictive Margins with Control Variables at Median Value](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Predictive%20Margins%20with%20Control%20Variables%20at%20Median%20Value2.png)

- In the robustness check, the polynomial fitted curve still shows a minimum after replacing control variables:
  - Replacing **BaseAsset** with **Chain**: **(FeeTier = 0.00129, EfficientRatio = 0.04306)**.

![Precition Curve if Substituting BaseAsset with Chain](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Precition%20Curve%20if%20Substituting%20BaseAsset%20with%20Chain.png)

- In the heterogeneity analysis, for the **ETH BaseAsset** group, the fitted curve still shows a minimum at **(FeeTier = 0.00170, EfficientRatio = 0.00872)**.

![Precition Curve if BaseAsset is ETH](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Precition%20Curve%20if%20BaseAsset%20is%20ETH.png)