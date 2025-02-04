### Tasks and Timeline

Date: 2025-02-04

1. **Preliminary** (Completed: 100%)

   - Fee calculation
   - Pool metrics
   - Data preprocessing

2. **The Most Suitable Efficient Metrics** (Progress: 75%, Expected Completion: By 2.11)

   - Candidate metrics
   - Rationale for choosing the metric:
     1. **Test 1**: Economic or financial meanings
     2. **Test 2**: Explanatory power
     3. **Test 3**: Sensitivity (Shannon entropy)

3. **Optimal Fee Tier Range** (Progress: 0%, Expected Completion: By 2.11)

   - Regression analysis: Quadratic regression to test if the U-shape is significant
     1. Generally, it is believed that excessively high or low fee tiers affect pool efficiency, so there is a reasonable hypothesis that fee tier and pool efficiency are related in a U-shaped curve.
     2. [Stata: How to Properly Test for the Presence of a U-shaped Relationship](https://www.lianxh.cn/news/cff9a87584f9b.html)
     3. [utest: Testing for U-shaped and Inverted U-shaped Relationships](https://zhuanlan.zhihu.com/p/150555194)
   - Machine learning model: An alternative approach, with slightly reduced interpretability.

4. **Further Exploration** (Progress: 0%, Expected Completion: By 2.25)
   - Robustness analysis: Test the robustness of the model results
   - Heterogeneity analysis:
     1. Investigate how fee tier affects explicit and implicit fees
     2. Explore result differences by grouping based on other features, such as:
        - Similarity of underlying assets
        - Start or expiry dates
   - Introduce additional data sources or metrics
   
5. **Post-Completion Tasks** (Progress: 0%, Expected Completion: TBD)

   - Regularly update with the latest dataset to check for changes in results

   -  Monitor whether the optimal fee tier identified in this report has increased the efficiency of the V2 pools in practice.

   - Consider automating certain processes through programming