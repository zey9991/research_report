**** Quick Set up ****
clear all
import delimited "C:\Users\zey9991\Desktop\Pool Metrics_By Efficient Ratio_Table_20250208_Modified.csv", case(preserve) 
* 画图用
gen FeeTier_pct = FeeTier * 100  
gen EfficientRatio_pct = EfficientRatio * 100
separate EfficientRatio_pct, by(BaseAsset) veryshortlabel gen(EffRatioPctbyBase)
separate EfficientRatio_pct, by(YieldSource) veryshortlabel gen(EffRatioPctbyYield)
separate EfficientRatio_pct, by(chain) veryshortlabel gen(EffRatioPctbychain)
* 生成哑变量回归用
tabulate BaseAsset, generate(BaseAsset_d)
tabulate YieldSource, generate(YieldSource_d)
tabulate chain, gen(chain_d)
* 多次项回归用
gen FeeTier2 = FeeTier^2  // 生成 FeeTier 的二次项
gen FeeTier3 = FeeTier^3
gen FeeTier4 = FeeTier^4
gen FeeTier5 = FeeTier^5
// summarize FeeTier, meanonly
// gen FeeTier_c = FeeTier - r(mean)
// gen FeeTier_c2 = FeeTier_c^2
// gen FeeTier_c3 = FeeTier_c^3
// gen FeeTier_cpct = FeeTier_c * 100 
* 门槛回归用
sysdir set PERSONAL "D:\Stata18\ado\personal"

**** 核密度估计 ****
hist EfficientRatio,norm
graph rename EfficientRatiohist

hist FeeTier,norm
graph rename FeeTierhist

kdensity EfficientRatio, norm
graph rename EfficientRatiokdensity

kdensity FeeTier, norm xtitle("Fee Tier")
graph rename FeeTierkdensity

kdensity FeeTier_c, norm xtitle("Fee Tier Centered")
graph rename FeeTiercenteredkdensity

kdensity FeeTier_cpct, norm xtitle("Fee Tier Centered (%)") xlabel(, format(%9.2f)) 
graph rename FeeTiercenteredPercentkdensity


**** ScatterPlot ****
* Generate scatter plot with percentage formatting
set scheme stgcolor
///graph query, schemes
* colorvar(BaseAsset)
scatter EffRatioPctbyBase? FeeTier_pct, ///
    title("Scatter Plot of Fee Tier vs. Efficient Ratio (By BaseAsset)") ///
    xtitle("Fee Tier (%)") ///
    ytitle("Efficient Ratio (%)") ///
    xlabel(0(0.125)2, format(%9.2f)) /// Manually setting x-axis ticks with 0 included
    ylabel(, format(%9.2f))  
// graph rename scatterEffRatioandFeeTierByBaseAsset,replace
graph export "scatterEffRatioandFeeTierByBaseAsset.png", replace

* colorvar(YieldSource)
scatter EffRatioPctbyYield? FeeTier_pct, ///
    title("Scatter Plot of Fee Tier vs. Efficient Ratio (By YieldSource)") ///
    xtitle("Fee Tier (%)") ///
    ytitle("Efficient Ratio (%)") ///
    xlabel(0(0.25)2, format(%9.2f)) ///  
    ylabel(, format(%9.2f))  
// graph rename scatterEffRatioandFeeTierByYieldSource,replace
graph export "scatterEffRatioandFeeTierByYieldSource.png", replace

* colorvar(chain)
scatter EffRatioPctbychain? FeeTier_pct, ///
    title("Scatter Plot of Fee Tier vs. Efficient Ratio (By Chain)") ///
    xtitle("Fee Tier (%)") ///
    ytitle("Efficient Ratio (%)") ///
    xlabel(0(0.25)2, format(%9.2f)) ///  
    ylabel(, format(%9.2f))  
// graph rename scatterEffRatioandFeeTierByChain,replace
graph export "scatterEffRatioandFeeTierByChain.png", replace

twoway scatter EfficientRatio_pct FeeTier_pct, ///
    title("Scatter Plot of FeeTier vs. EfficientRatio") /// 
    xtitle("FeeTier (%)") ytitle("EfficientRatio (%)") /// 
    xlabel(0(0.25)2, format(%9.2f)) ylabel(, format(%9.2f)) /// 
    legend(off)  ///
	xline(0.24)

*BaseAsset mscatter
mscatter EfficientRatio_pct FeeTier_pct, alegend by(BaseAsset) ///
    xtitle("Fee Tier (%)") ///
    ytitle("Efficient Ratio (%)") ///
	xlabel(0(0.25)2, format(%9.2f)) ylabel(, format(%9.2f))
graph export "scatterEffRatioandFeeTierByBaseAsset2.png", replace

* 双重分组
* chain, BaseAsset
mscatter EfficientRatio_pct FeeTier_pct, over(BaseAsset) alegend by(chain) ///
    xtitle("Fee Tier (%)") ///
    ytitle("Efficient Ratio (%)") 
graph export "scatterEffRatioandFeeTierByBaseAssetandChain.png", replace
* chain, YieldSource
mscatter EfficientRatio_pct FeeTier_pct, over(YieldSource) alegend by(chain) ///
    xtitle("Fee Tier (%)") ///
    ytitle("Efficient Ratio (%)") 
graph export "scatterEffRatioandFeeTierByYieldSourceandChain.png", replace


**** Quadratic Regression ****
gen FeeTier2 = FeeTier^2  // 生成 FeeTier 的二次项
gen FeeTier3 = FeeTier^3
gen FeeTier4 = FeeTier^4
gen FeeTier5 = FeeTier^5

regress EfficientRatio FeeTier FeeTier_sq, nocons
regress EfficientRatio FeeTier FeeTier_sq DurationDay, nocons

* 生成 BaseAsset 的虚拟变量，并去掉第一个类别（避免多重共线性）
tabulate BaseAsset, generate(BaseAsset_d)

* 进行回归，包括 FeeTier, FeeTier_sq, DurationDay 以及 BaseAsset 的虚拟变量
regress EfficientRatio FeeTier DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust
est sto Linear

regress EfficientRatio FeeTier FeeTier2 DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust
est sto Quadratic

regress EfficientRatio FeeTier FeeTier2 FeeTier3 DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust
est sto Cubic

regress EfficientRatio FeeTier FeeTier2 FeeTier3 FeeTier4 DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust
est sto Quartic

regress EfficientRatio FeeTier FeeTier2 FeeTier3 FeeTier4 FeeTier5 DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust
est sto Quintic

esttab Linear Quadratic Cubic Quartic Quintic , mtitles r2 ar2 se star(* 0.1 ** 0.05 *** 0.01)


* Nonlinear OLS
nl (EfficientRatio = {b1}+{b2}*FeeTier + {gamma}*FeeTier^2 ///
                     + {b4}*DurationDay + {b5}*BaseAsset_d1 + {b6}*BaseAsset_d2 + {b7}*BaseAsset_d3 ), ///
   initial(b1 0 b2 1 gamma 0 b4 0 b5 0 b6 0 b7 0 ) robust

** Margin 
*Quadratic Margin
regress EfficientRatio FeeTier FeeTier2 DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust

* 计算 FeeTier 对 EfficientRatio 的边际效应
quietly margins, at(FeeTier=(0(0.0001)0.02)) 

* 绘制边际效应图
marginsplot, recast(line) recastci(rline) ///
	title("Marginal Effects of FeeTier on EfficientRatio") ///
    xtitle("FeeTier") ytitle("Marginal Effect of EfficientRatio") ///
    xlabel(0(0.0025)0.02) ///
    legend(off) ///
	ciopts(lpattern(dash))
graph rename Margin2,replace

*Cubic Margin
regress EfficientRatio FeeTier FeeTier2 FeeTier3 DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust

* 计算 FeeTier 对 EfficientRatio 的边际效应
quietly margins, at(FeeTier=(0(0.001)0.02))
quietly margins, at(FeeTier2=(0(0.00001)0.0004) )
quietly margins, at(FeeTier3=(0(0.000001)0.00008))

* 绘制边际效应图
marginsplot, recast(line) recastci(rline) ///
	title("Marginal Effects of FeeTier on EfficientRatio") ///
    xtitle("FeeTier") ytitle("Marginal Effect of EfficientRatio") ///
    xlabel(0(0.0025)0.02) ///
    legend(off) ///
	ciopts(lpattern(dash)) ///
	xdimension(FeeTier)
graph rename Margin3,replace

marginsplot, recast(line) recastci(rline) ///
	title("Marginal Effects of FeeTier on EfficientRatio") ///
    xtitle("FeeTier") ytitle("Marginal Effect of EfficientRatio") ///
    xlabel(0(0.000025)0.0004) ///
    legend(off) ///
	ciopts(lpattern(dash)) ///
	xdimension(FeeTier)


marginsplot, xdimension(FeeTier) ///
    title("Marginal Effects of FeeTier on EfficientRatio") ///
    xtitle("FeeTier") ytitle("Marginal Effect") ///
    xlabel(0(0.005)0.02) ///
    legend(off)

** 自己画边际预测图像
* 计算指定变量的中位数
summarize DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, detail
// scalar median_DurationDay = r(p50) if "`var'" == "DurationDay"
// scalar median_BaseAsset_d1 = r(p50) if "`var'" == "BaseAsset_d1"
// scalar median_BaseAsset_d2 = r(p50) if "`var'" == "BaseAsset_d2"
// scalar median_BaseAsset_d3 = r(p50) if "`var'" == "BaseAsset_d3"

* 生成 FeeTier 变量，步长为 0.0001
drop x*

set obs 2000 
gen x = ( _n ) * 0.00001  
gen x2=x^2
gen x3=x^3
* 计算目标变量
gen Prediction = 0.04397455 - 8.25 * x + 3999.2 * x2 - 132549.2 * x3

* 画出 FeeTier 和 target_var 的折线图
twoway         (scatter EfficientRatio FeeTier) ///
	(scatter Prediction x if  x > 0.01902 & x < 0.019025 , mcolor(red) msize(large) ) /// 
	(scatter Prediction x if  x > 0.00109 & x < 0.001095 , mcolor(black) msize(large) ) ///
	(line Prediction x, lcolor(blue) lwidth(medium)) /// 
	(function y=0.42178455, range(0 0.01902) lcolor(red) lpattern(dash) lwidth(medium)  ) ///
   (function y=0.01902, range(0 0.42178455) horizontal lcolor(red) lpattern(dash) lwidth(medium)) ///
		(function y=0.03956, range(0 0.00109) lcolor(black) lpattern(dash) lwidth(medium)  ) ///
   (function y=0.00109, range(0 0.03956) horizontal lcolor(black) lpattern(dash) lwidth(medium)), /// 
    title("Predictive Margins with Control Variables at Median Value") /// 
    xtitle("FeeTier") ytitle("Cubic Prediction") /// 
    xlabel(0(0.0025)0.02) ///
	ylabel(0(0.2)0.8, ) 
graph export "Predictive Margins with Control Variables at Median Value.png"




** 绘制调整R方和多项式阶数的图像

* 创建数据集
clear
input byte model adj_r2
1 0.217
2 0.220
3 0.230
4 0.227
5 0.227
end

* 绘制折线图并突出显示特定点
twoway (scatter adj_r2 model if model == 3, mcolor(red) msize(medium) )  ///
	   (line adj_r2 model, sort lcolor(blue) lwidth(medium)) ///
	   (function y=0.23, range(1 3) lcolor(red) lpattern(dash) lwidth(medium)) ///
       (function y=3, range(0.21 0.23) horizontal lcolor(red) lpattern(dash) lwidth(medium)), ///
    title("Adjusted R-Squared vs Polynomial Degree") ///
    xlabel(1(1)5) ///
    ylabel(0.21(0.01)0.24) ///
    xtitle("Polynomial Degree") ///
    ytitle("Adjusted R-Squared") ///
	 legend(off) 
graph rename ar2andPolynomial,replace
graph export "Adjusted R-Squared vs Polynomial Degree.png",replace
   
   
**** Threshold Regression ****

* 检验门槛效应
thresholdtest EfficientRatio FeeTier DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, q(FeeTier) trim_per(0.15) rep(5000)
graph rename thresholdtest1

thresholdtest EfficientRatio FeeTier DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, q(DurationDay) trim_per(0.15) rep(5000)
graph rename thresholdtest2

* 估计门槛模型
thresholdreg EfficientRatio FeeTier DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 , q(FeeTier) h(1)
graph rename thresholdreg1
graph export "Confidence Interval Construction for Threshold.png", replace

thresholdreg EfficientRatio FeeTier DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 , q(DurationDay) h(1)
graph rename thresholdreg2


* 进一步划分子样本查看有无门槛效应
drop if FeeTier<=0.0024

thresholdtest EfficientRatio FeeTier DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, q(FeeTier) trim_per(0.15) rep(5000)
graph rename thresholdtest2
//结果显示没有了，仅有一个门槛

** 门槛存在但系数与预期相反
* 求百分位数
summarize FeeTier, detail
centile FeeTier, centile(1 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75)
 
** 散点图带门槛值
* 生成散点图

 
**** 非参数估计 ****
*核密度回归
drop *kern
kernreg1 EfficientRatio FeeTier_c, k(3) np(100)  gen(EfficientRatio_kern FeeTier_ckern)
dis $S_1

*k近邻回归
knnreg EfficientRatio FeeTier_c, knum(10) gen(EfficientRatio_knn)

*局部多项式回归
drop *lpoly
lpoly EfficientRatio FeeTier_c, b($S_1) degree(3) gen(FeeTier_clpoly EfficientRatio_lpoly)

*lowess回归
drop *lowess
lowess EfficientRatio FeeTier_c, bwidth(0.1) gen(EfficientRatio_lowess )
lowess EfficientRatio FeeTier_c
	
twoway ///
    (scatter EfficientRatio FeeTier_c , colorvar(BaseAsset_num) colordiscrete coloruseplegend zlabel(, valuelabel) ) ///
    (lfit EfficientRatio FeeTier_c, lpattern("-")) ///
    (qfit EfficientRatio FeeTier_c, lpattern("-.")) ///
    (line EfficientRatio_kern FeeTier_ckern, lpattern("*") sort) ///
	(line EfficientRatio_knn FeeTier_c, lpattern("*") sort) ///
    (line EfficientRatio_lpoly FeeTier_clpoly, lpattern("*") sort) ///
	(line EfficientRatio_lowess FeeTier_c, lpattern("*") sort) ///
    ,title("Scatter Plot of Fee Tier vs. Efficient Ratio") ///
    xtitle("Fee Tier Centered ") ///
    ytitle("Efficient Ratio") ///
    xlabel(, ) ///
    ylabel(, format(%9.1f)) ///
	legend(position(12) ring(0.5)  cols(3) ) 
    
* 切换用pct进行回归并画图
drop EfficientRatio_pctkern FeeTier_cpctkern
kernreg1 EfficientRatio_pct FeeTier_cpct, k(3) np(100)  gen(EfficientRatio_pctkern FeeTier_cpctkern)
dis $S_1

drop EfficientRatio_pctknn
knnreg EfficientRatio_pct FeeTier_cpct, knum(10) gen(EfficientRatio_pctknn)

drop FeeTier_cpctlpoly EfficientRatio_pctlpoly
lpoly EfficientRatio_pct FeeTier_cpct, b($S_1) degree(1) gen(FeeTier_cpctlpoly EfficientRatio_pctlpoly)

drop EfficientRatio_pctlowess
lowess EfficientRatio_pct FeeTier_cpct, bwidth($S_1) gen(EfficientRatio_pctlowess )
	
twoway ///
    (scatter EfficientRatio_pct FeeTier_cpct , colorvar(BaseAsset_num) colordiscrete coloruseplegend zlabel(, valuelabel) ) ///
    (lfit EfficientRatio_pct FeeTier_cpct, lpattern("-")) ///
    (qfit EfficientRatio_pct FeeTier_cpct, lpattern("-.")) ///
    (line EfficientRatio_pctkern FeeTier_cpctkern, lpattern("*") sort) ///
	(line EfficientRatio_pctknn FeeTier_cpct, lpattern("*") sort) ///
    (line EfficientRatio_pctlpoly FeeTier_cpctlpoly, lpattern("*") sort) ///
	(line EfficientRatio_pctlowess FeeTier_cpct, lpattern("*") sort) ///
    ,title("Scatter Plot of Fee Tier vs. Efficient Ratio") ///
    xtitle("Fee Tier Centered (%)") ///
    ytitle("Efficient Ratio (%)") ///
    xlabel(, format(%9.3f)) ///
    ylabel(, format(%9.1f)) ///
	legend(position(12) ring(0.5)  cols(3) ) 

 
 
* Semipar
reg EfficientRatio FeeTier  DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, robust
est sto Linear

reg EfficientRatio_pct FeeTier_pct DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3
est sto linearpct

drop NonparEstimate NonparError
semipar EfficientRatio  DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 BaseAsset_d4, nonpar(FeeTier)  robust ci gen(NonparEstimate) partial(NonparError) xtitle(FeeTier) ytitle(EfficientRatio)  title("Kernel Regression Plot of EfficientRatio against FeeTier") test(3)
est sto PLM
graph rename Semipar,replace
graph export "Kernel Regression Plot of EfficientRatio against FeeTier.png",replace

drop NonparEstimatePct NonparErrorPct
semipar EfficientRatio_pct  DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3, nonpar(FeeTier_pct)  robust ci gen(NonparEstimatePct) partial(NonparErrorPct) xtitle(FeeTier) ytitle(EfficientRatio)  
est sto PLpct
graph rename SemiparPct,replace


esttab PLM Linear , mtitles r2 ar2 se star(* 0.1 ** 0.05 *** 0.01)
 


**** Outlier ****
summarize FeeTier, detail
graph box FeeTier

summarize EfficientRatio, detail
graph box EfficientRatio

* 计算指定分位数
centile FeeTier EfficientRatio, centile(0 1 2.5 5 95 97.5 99 100)


* 散点图带分位数1-99
scalar centileEff1=0.0004194
scalar centileEff99=0.6541161
scalar centileFee1=0.000388
scalar centileFee99=0.01

drop centilevar*
gen centilevar1="raw" if (EfficientRatio > centileEff1 & EfficientRatio < centileEff99 &FeeTier>centileFee1 &FeeTier<centileFee99) 
*两侧异常
replace centilevar1="FeeTier<1%Centile&EfficientRatio<1%Centile" if(FeeTier<centileFee1&EfficientRatio<centileEff1)
replace centilevar1="FeeTier<1%Centile&EfficientRatio>99%Centile" if(FeeTier<centileFee1&EfficientRatio>centileEff99)
replace centilevar1="FeeTier>99%Centile&EfficientRatio<1%Centile" if(FeeTier>centileFee99&EfficientRatio<centileEff1)
replace centilevar1="FeeTier>99%Centile&EfficientRatio>99%Centile" if(FeeTier>centileFee99&EfficientRatio>centileEff99)
*单侧异常
replace centilevar1="FeeTier<1%Centile" if(FeeTier<centileFee1&EfficientRatio>centileEff1&EfficientRatio<centileEff99)
replace centilevar1="EfficientRatio<1%Centile" if(FeeTier>centileFee1&FeeTier<centileFee99&EfficientRatio<centileEff1)
replace centilevar1="FeeTier>99%Centile" if(FeeTier>centileFee99&EfficientRatio > centileEff1 & EfficientRatio < centileEff99)
replace centilevar1="EfficientRatio>99%Centile" if(FeeTier>centileFee1 &FeeTier<centileFee99&EfficientRatio>centileEff99)

separate EfficientRatio_pct, by(centilevar1) veryshortlabel gen(EffRatioPctbyCentile1)

twoway (scatter EffRatioPctbyCentile1? FeeTier_pct) ///
    (function y=centileEff1*100, range(0 2) lcolor(orange) lpattern(dash) lwidth(medium)) ///
    (function y=centileEff99*100, range(0 2) lcolor(dkorange) lpattern(dash) lwidth(medium)) ///
    (function y=centileFee1*100, range(0 80) horizontal lcolor(midgreen) lpattern(dash) lwidth(medium)) ///
    (function y=centileFee99*100, range(0 80) horizontal lcolor(green) lpattern(dash) lwidth(medium)) ///
    , title("Scatter Plot of Fee Tier vs. Efficient Ratio") ///
      subtitle("Winsorized or Trimmed at 1%") ///
      xtitle("FeeTier(%)") ///
      ytitle("EfficientRatio(%)") ///
      xlabel(0(0.25)2) ///
      ylabel(0(20)80) ///
      legend(size(small) cols(1))

*2.5-97.5
scalar centileEff2=.0008641
scalar centileEff97=.3733998
scalar centileFee2=.0005
scalar centileFee97=.01

drop centilevar2
gen centilevar2="raw" if (EfficientRatio > centileEff2 & EfficientRatio < centileEff97 &FeeTier>centileFee2 &FeeTier<centileFee97) 
*两侧异常
replace centilevar2="FeeTier<2.5%Centile&EfficientRatio<2.5%Centile" if(FeeTier<centileFee2&EfficientRatio<centileEff2)
replace centilevar2="FeeTier<2.5%Centile&EfficientRatio>97.5%Centile" if(FeeTier<centileFee2&EfficientRatio>centileEff97)
replace centilevar2="FeeTier>97.5%Centile&EfficientRatio<2.5%Centile" if(FeeTier>centileFee97&EfficientRatio<centileEff2)
replace centilevar2="FeeTier>97.5%Centile&EfficientRatio>97.5%Centile" if(FeeTier>centileFee97&EfficientRatio>centileEff97)
*单侧异常
replace centilevar2="FeeTier<2.5%Centile" if(FeeTier<centileFee2&EfficientRatio>centileEff2&EfficientRatio<centileEff97)
replace centilevar2="EfficientRatio<2.5%Centile" if(FeeTier>centileFee2&FeeTier<centileFee97&EfficientRatio<centileEff2)
replace centilevar2="FeeTier>97.5%Centile" if(FeeTier>centileFee97&EfficientRatio > centileEff2 & EfficientRatio < centileEff97)
replace centilevar2="EfficientRatio>97.5%Centile" if(FeeTier>centileFee2 &FeeTier<centileFee97&EfficientRatio>centileEff97)

drop EffRatioPctbyCentile2*
separate EfficientRatio_pct, by(centilevar2) veryshortlabel gen(EffRatioPctbyCentile2)

twoway (scatter EffRatioPctbyCentile2? FeeTier_pct) ///
    (function y=100*centileEff2, range(0 2) lcolor(orange) lpattern(dash) lwidth(medium)) ///
    (function y=100*centileEff97, range(0 2) lcolor(dkorange) lpattern(dash) lwidth(medium)) ///
    (function y=100*centileFee2, range(0 80) horizontal lcolor(midgreen) lpattern(dash) lwidth(medium)) ///
    (function y=100*centileFee97, range(0 80) horizontal lcolor(green) lpattern(dash) lwidth(medium)) ///
    ,title("Scatter Plot of Fee Tier vs. Efficient Ratio") /// 
	subtitle("Winsorized or Trimmed at 2.5%") ///
      xtitle("FeeTier(%)") ///
      ytitle("EfficientRatio(%)") ///
	xlabel(0(0.25)2) ///
	ylabel(0(20)80) ///
      legend(size(small) cols(1))

*5-95
centile FeeTier EfficientRatio, centile(0 1 2.5 5 95 97.5 99 100)
scalar centileEff5=.0015495
scalar centileEff95=.2257768
scalar centileFee5=.0005
scalar centileFee95=.01

drop centilevar3
gen centilevar3="raw" if (EfficientRatio > centileEff5 & EfficientRatio < centileEff95 &FeeTier>centileFee5 &FeeTier<centileFee95) 
*两侧异常
replace centilevar3="FeeTier<5%Centile&EfficientRatio<5%Centile" if(FeeTier<centileFee5&EfficientRatio<centileEff5)
replace centilevar3="FeeTier<5%Centile&EfficientRatio>95%Centile" if(FeeTier<centileFee5&EfficientRatio>centileEff95)
replace centilevar3="FeeTier>95%Centile&EfficientRatio<5%Centile" if(FeeTier>centileFee95&EfficientRatio<centileEff5)
replace centilevar3="FeeTier>95%Centile&EfficientRatio>95%Centile" if(FeeTier>centileFee95&EfficientRatio>centileEff95)
*单侧异常
replace centilevar3="FeeTier<5%Centile" if(FeeTier<centileFee5&EfficientRatio>centileEff5&EfficientRatio<centileEff95)
replace centilevar3="EfficientRatio<5%Centile" if(FeeTier>centileFee5&FeeTier<centileFee95&EfficientRatio<centileEff5)
replace centilevar3="FeeTier>95%Centile" if(FeeTier>centileFee95&EfficientRatio > centileEff5 & EfficientRatio < centileEff95)
replace centilevar3="EfficientRatio>95%Centile" if(FeeTier>centileFee5 &FeeTier<centileFee95&EfficientRatio>centileEff95)

drop EffRatioPctbyCentile3*
separate EfficientRatio_pct, by(centilevar3) veryshortlabel gen(EffRatioPctbyCentile3)

twoway (scatter EffRatioPctbyCentile3? FeeTier_pct) ///
    (function y=100*centileEff5, range(0 2) lcolor(orange) lpattern(dash) lwidth(medium)) ///
    (function y=100*centileEff95, range(0 2) lcolor(dkorange) lpattern(dash) lwidth(medium)) ///
    (function y=100*centileFee5, range(0 80) horizontal lcolor(midgreen) lpattern(dash) lwidth(medium)) ///
    (function y=100*centileFee95, range(0 80) horizontal lcolor(green) lpattern(dash) lwidth(medium)) ///
    ,title("Scatter Plot of Fee Tier vs. Efficient Ratio") /// 
	subtitle("Winsorized or Trimmed at 5%") ///
      xtitle("FeeTier(%)") ///
      ytitle("EfficientRatio(%)") ///
	xlabel(0(0.25)2) ///
	ylabel(0(20)80) ///
      legend(size(small) cols(1))


**** Packages ****

ssc install estout
ssc install outreg2
ssc install winsor2

**** Robustness/Sensitivity ****
***winsor2
drop *_w*
drop *_tr*

**这部分可以直接应用winsor2
winsor2 FeeTier EfficientRatio, cuts(1 99) suffix(_w1)  
winsor2 FeeTier EfficientRatio, cuts(2.5 97.5) suffix(_w2) 
winsor2 FeeTier EfficientRatio, cuts(5 95) suffix(_w3) 
winsor2 FeeTier EfficientRatio, trim cuts(1 99) suffix(_tr1)  
winsor2 FeeTier EfficientRatio, trim cuts(2.5 97.5) suffix(_tr2) 
winsor2 FeeTier EfficientRatio, trim cuts(5 95) suffix(_tr3) 
**这部分建议基于FeeTier缩尾或截尾
*FeeTier2
gen FeeTier2_w1=FeeTier2
replace FeeTier2_w1=0.000388^2 if FeeTier<0.000388
replace FeeTier2_w1=0.01^2 if FeeTier>0.01

gen FeeTier2_w2=FeeTier2
replace FeeTier2_w2=0.0005^2 if FeeTier<0.0005
replace FeeTier2_w2=0.01^2 if FeeTier>0.01

gen FeeTier2_w3=FeeTier2
replace FeeTier2_w3=0.0005^2 if FeeTier<0.0005
replace FeeTier2_w3=0.01^2 if FeeTier>0.01

gen FeeTier2_tr1=FeeTier2
replace FeeTier2_tr1=. if FeeTier<0.000388
replace FeeTier2_tr1=. if FeeTier>0.01

gen FeeTier2_tr2=FeeTier2
replace FeeTier2_tr2=. if FeeTier<0.0005
replace FeeTier2_tr2=. if FeeTier>0.01

gen FeeTier2_tr3=FeeTier2
replace FeeTier2_tr3=. if FeeTier<0.0005
replace FeeTier2_tr3=. if FeeTier>0.01
*FeeTier3
gen FeeTier3_w1=FeeTier3
replace FeeTier3_w1=0.000388^3 if FeeTier<0.000388
replace FeeTier3_w1=0.01^3 if FeeTier>0.01

gen FeeTier3_w2=FeeTier3
replace FeeTier3_w2=0.0005^3 if FeeTier<0.0005
replace FeeTier3_w2=0.01^3 if FeeTier>0.01

gen FeeTier3_w3=FeeTier3
replace FeeTier3_w3=0.0005^3 if FeeTier<0.0005
replace FeeTier3_w3=0.01^3 if FeeTier>0.01

gen FeeTier3_tr1=FeeTier3
replace FeeTier3_tr1=. if FeeTier<0.000388
replace FeeTier3_tr1=. if FeeTier>0.01

gen FeeTier3_tr2=FeeTier3
replace FeeTier3_tr2=. if FeeTier<0.0005
replace FeeTier3_tr2=. if FeeTier>0.01

gen FeeTier3_tr3=FeeTier3
replace FeeTier3_tr3=. if FeeTier<0.0005
replace FeeTier3_tr3=. if FeeTier>0.01


**coefficients and p values
*Quadratic
regress EfficientRatio DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 FeeTier FeeTier2 , robust
outreg2 using "RobustnessQuadratic.xlsx",excel replace title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Quadratic)

local suffixes "_w1 _w2 _w3 _tr1 _tr2 _tr3"

* 系列一：未处理的 EfficientRatio 对处理后的 FeeTier 变量回归
foreach f of local suffixes {
    quietly regress EfficientRatio DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 ///
            FeeTier`f' FeeTier2`f', robust
	outreg2 using "RobustnessQuadratic.xlsx",excel append title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Quadratic`f'_0)
}
* 系列二：处理后的 EfficientRatio 对未处理的 FeeTier 变量回归
foreach f of local suffixes {
    quietly regress EfficientRatio`f' DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 ///
            FeeTier FeeTier2, robust
	outreg2 using "RobustnessQuadratic.xlsx",excel append title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Quadratic_0`f')
}

* 系列三：处理后的 EfficientRatio 对处理后的 FeeTier 变量回归
* 这里我们将 winsor/trim 后的 EfficientRatio 的后缀也视为 local 宏 effSuffixes
local effSuffixes "_w1 _w2 _w3 _tr1 _tr2 _tr3"
foreach r of local effSuffixes {
    foreach f of local suffixes {
         quietly regress EfficientRatio`r' DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 ///
                 FeeTier`f' FeeTier2`f', robust
		 outreg2 using "RobustnessQuadratic.xlsx",excel append title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Quadratic`f'`r')
    }
}


*Cubic
regress EfficientRatio DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 FeeTier FeeTier2 FeeTier3, robust
outreg2 using "RobustnessCubic.xlsx",excel replace title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Cubic)

local suffixes "_w1 _w2 _w3 _tr1 _tr2 _tr3"

foreach f of local suffixes {
    quietly regress EfficientRatio DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 ///
            FeeTier`f' FeeTier2`f' FeeTier3`f', robust
	outreg2 using "RobustnessCubic.xlsx",excel append title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Cubic`f'_0)
}

foreach f of local suffixes {
    quietly regress EfficientRatio`f' DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 ///
            FeeTier FeeTier2 FeeTier3, robust
	outreg2 using "RobustnessCubic.xlsx",excel append title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Cubic_0`f')
}

local effSuffixes "_w1 _w2 _w3 _tr1 _tr2 _tr3"
foreach r of local effSuffixes {
    foreach f of local suffixes {
         quietly regress EfficientRatio`r' DurationDay BaseAsset_d1 BaseAsset_d2 BaseAsset_d3 ///
                 FeeTier`f' FeeTier2`f' FeeTier3`f', robust
		 outreg2 using "RobustnessCubic.xlsx",excel append title("Robustness Analysis Results") tstat bdec(3) tdec(2) addstat(Adj-R2, `e(r2_a)') cttop(Cubic`f'`r')
    }
}


	
**max and min


**Substitute Control varibles
*YieldSource
regress EfficientRatio DurationDay YieldSource_d1 YieldSource_d2 YieldSource_d3 YieldSource_d4 YieldSource_d5 YieldSource_d6 YieldSource_d7 FeeTier , robust
est sto Linear

regress EfficientRatio DurationDay YieldSource_d1 YieldSource_d2 YieldSource_d3 YieldSource_d4 YieldSource_d5 YieldSource_d6 YieldSource_d7 FeeTier FeeTier2 , robust
est sto Quadratic

regress EfficientRatio DurationDay YieldSource_d1 YieldSource_d2 YieldSource_d3 YieldSource_d4 YieldSource_d5 YieldSource_d6 YieldSource_d7  FeeTier FeeTier2 FeeTier3, robust
est sto Cubic

regress EfficientRatio  DurationDay YieldSource_d1 YieldSource_d2 YieldSource_d3 YieldSource_d4 YieldSource_d5 YieldSource_d6 YieldSource_d7 FeeTier FeeTier2 FeeTier3 FeeTier4, robust
est sto Quartic

regress EfficientRatio DurationDay YieldSource_d1 YieldSource_d2 YieldSource_d3 YieldSource_d4 YieldSource_d5 YieldSource_d6 YieldSource_d7 FeeTier FeeTier2 FeeTier3 FeeTier4 FeeTier5 , robust
est sto Quintic

esttab Linear Quadratic Cubic Quartic Quintic , mtitles r2 ar2 se star(* 0.1 ** 0.05 *** 0.01)

summarize DurationDay YieldSource_d*, detail

*YieldSource Fitted Curve
drop x* Prediction

set obs 2000 
gen x = ( _n ) * 0.00001  
gen x2=x^2
gen x3=x^3
gen x4=x^4

scalar COEFF_00 = 0.00358 
scalar  COEFF_01 = -0.0029025  
scalar COEFF_1 = 41.10       
scalar COEFF_2 = -13558.1 
scalar COEFF_3 = 1683360.6
scalar COEFF_4 = -53133753.4   

gen Prediction = COEFF_00 + COEFF_01 + COEFF_1 * x + COEFF_2 * x2 + COEFF_3 * x3 +COEFF_4 * x4

local x_min_1 0.01688
local x_max_1 0.016885
local y_const_1 0.61392


* 绘图
twoway         (scatter EfficientRatio FeeTier) /// 
               (scatter Prediction x if x > `x_min_1' & x < `x_max_1', mcolor(red) msize(large)) /// 
               (line Prediction x, lcolor(blue) lwidth(medium)) /// 
               (function y=`y_const_1', range(0 `x_min_1') lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_1', range(0 `y_const_1') horizontal lcolor(red) lpattern(dash) lwidth(medium)) /// 
    ,title("Precition Curve if Substituting BaseAsset with YieldSource") /// 
    xtitle("FeeTier") ytitle("Cubic Prediction") /// 
    xlabel(0(0.0025)0.02) /// 
    ylabel(0(0.2)0.8)



*Chain
regress EfficientRatio DurationDay chain_d1 chain_d2 chain_d3 chain_d4 chain_d5 FeeTier , robust
est sto Linear

regress EfficientRatio DurationDay chain_d1 chain_d2 chain_d3 chain_d4 chain_d5 FeeTier FeeTier2 , robust
est sto Quadratic

regress EfficientRatio DurationDay chain_d1 chain_d2 chain_d3 chain_d4 chain_d5  FeeTier FeeTier2 FeeTier3, robust
est sto Cubic

regress EfficientRatio  DurationDay chain_d1 chain_d2 chain_d3 chain_d4 chain_d5 FeeTier FeeTier2 FeeTier3 FeeTier4, robust
est sto Quartic

regress EfficientRatio DurationDay chain_d1 chain_d2 chain_d3 chain_d4 chain_d5 FeeTier FeeTier2 FeeTier3 FeeTier4 FeeTier5 , robust
est sto Quintic

esttab Linear Quadratic Cubic Quartic Quintic , mtitles r2 ar2 se star(* 0.1 ** 0.05 *** 0.01)

summarize DurationDay chain_*, detail

*Chain Fitted Curve
drop x* Prediction

set obs 2000 
gen x = ( _n ) * 0.00001  
gen x2=x^2
gen x3=x^3
gen x4=x^4

scalar COEFF_00 = 0.0167  
scalar  COEFF_01 = 0.03327585  
scalar COEFF_1 = -10.98       
scalar COEFF_2 = 4559.6     
scalar COEFF_3 = -155741.6   

gen Prediction = COEFF_00 + COEFF_01 + COEFF_1 * x + COEFF_2 * x2 + COEFF_3 * x3 

local x_min_1 0.01823
local x_max_1 0.018235
local x_min_2 0.00129
local x_max_2 0.001295
local y_const_1 0.42157
local y_const_2 0.04306

* 绘图
twoway         (scatter EfficientRatio FeeTier) /// 
               (scatter Prediction x if x > `x_min_1' & x < `x_max_1', mcolor(red) msize(large)) /// 
               (scatter Prediction x if x > `x_min_2' & x < `x_max_2', mcolor(black) msize(large)) /// 
               (line Prediction x, lcolor(blue) lwidth(medium)) /// 
               (function y=`y_const_1', range(0 `x_min_1') lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`y_const_2', range(0 `x_min_2') lcolor(black) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_1', range(0 `y_const_1') horizontal lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_2', range(0 `y_const_2') horizontal lcolor(black) lpattern(dash) lwidth(medium)), /// 
    title("Precition Curve if Substituting BaseAsset with Chain") /// 
    xtitle("FeeTier") ytitle("Cubic Prediction") /// 
    xlabel(0(0.0025)0.02) /// 
    ylabel(0(0.2)0.8)




**** heterogeneity ****
**BaseAsset
sum EffRatio*bychain*
sum EffRatio*byYield*
sum EffRatioPctbyBase*

separate EfficientRatio, by(BaseAsset) veryshortlabel gen(EffRatiobyBase)

**Polynomial
local Base "1 2 3 4"
foreach B of local Base {
	quietly regress EffRatiobyBase`B' DurationDay FeeTier , robust 
	est sto Linear

	quietly regress EffRatiobyBase`B' DurationDay FeeTier FeeTier2 , robust
	est sto Quadratic

	quietly regress EffRatiobyBase`B' DurationDay FeeTier FeeTier2 FeeTier3, robust
	est sto Cubic

	quietly regress EffRatiobyBase`B'  DurationDay FeeTier FeeTier2 FeeTier3 FeeTier4, robust
	est sto Quartic

	quietly regress EffRatiobyBase`B' DurationDay FeeTier FeeTier2 FeeTier3 FeeTier4 FeeTier5 , robust
	est sto Quintic

	esttab Linear Quadratic Cubic Quartic Quintic , mtitles r2 ar2 se star(* 0.1 ** 0.05 *** 0.01)
}

drop DurationDay_Base*
gen DurationDay_BaseETH=DurationDay
replace DurationDay_BaseETH=. if BaseAsset_d2==1

gen DurationDay_BaseStable=DurationDay
replace DurationDay_BaseStable=. if BaseAsset_d4==1

summarize DurationDay_Base* , detail

gen FeeTierByBase2=FeeTier
replace FeeTierByBase2=. if BaseAsset_d2==1

gen FeeTierByBase4=FeeTier
replace FeeTierByBase4=. if BaseAsset_d4==1

*BaseAsset==ETH Fitted Curve
drop x* Prediction
drop if FeeTier>0.01

set obs 2000 
gen x = ( _n ) * 0.000005  
gen x2=x^2
gen x3=x^3
gen x4=x^4

scalar COEFF_00 = 0.115 
scalar  COEFF_01 = 0.00000559*142  
scalar COEFF_1 = -135.8      
scalar COEFF_2 = 48714.1     
scalar COEFF_3 = -3459493.1  

gen Prediction = COEFF_00 + COEFF_01 + COEFF_1 * x + COEFF_2 * x2 + COEFF_3 * x3 

local x_min_1 0.00768
local x_max_1 0.007687
local x_min_2 0.00170
local x_max_2 0.001705
local y_const_1 0.37903
local y_const_2 0.00872
twoway         (scatter EffRatiobyBase2 FeeTier) /// 
               (scatter Prediction x if x > `x_min_1' & x < `x_max_1', mcolor(red) msize(large)) /// 
               (scatter Prediction x if x > `x_min_2' & x < `x_max_2', mcolor(black) msize(large)) /// 
               (line Prediction x, lcolor(blue) lwidth(medium)) /// 
               (function y=`y_const_1', range(0 `x_min_1') lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`y_const_2', range(0 `x_min_2') lcolor(black) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_1', range(0 `y_const_1') horizontal lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_2', range(0 `y_const_2') horizontal lcolor(black) lpattern(dash) lwidth(medium)), /// 
    title("Precition Curve if BaseAsset is ETH") /// 
    xtitle("FeeTier") ytitle("Cubic Prediction") /// 
    xlabel(0(0.0025)0.01) /// 
    ylabel(0(0.2)0.8) 

*BaseAsset==Stable Fitted Curve
drop x* Prediction
drop if FeeTier>0.01

set obs 2000 
gen x = ( _n ) * 0.000005  
gen x2=x^2
gen x3=x^3
gen x4=x^4

scalar COEFF_00 = 0.0232 
scalar  COEFF_01 = -0.000196*129  
scalar COEFF_1 = 63.25      
scalar COEFF_2 = -16615.4     
scalar COEFF_3 = 1276871.6 

gen Prediction = COEFF_00 + COEFF_01 + COEFF_1 * x + COEFF_2 * x2 + COEFF_3 * x3 

local x_min_1 0.00768
local x_max_1 0.007687
local x_min_2 0.00170
local x_max_2 0.001705
local y_const_1 0.37903
local y_const_2 0.00872
twoway         (scatter EffRatiobyBase2 FeeTier) /// 
               (scatter Prediction x if x > `x_min_1' & x < `x_max_1', mcolor(red) msize(large)) /// 
               (scatter Prediction x if x > `x_min_2' & x < `x_max_2', mcolor(black) msize(large)) /// 
               (line Prediction x, lcolor(blue) lwidth(medium)) /// 
               (function y=`y_const_1', range(0 `x_min_1') lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`y_const_2', range(0 `x_min_2') lcolor(black) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_1', range(0 `y_const_1') horizontal lcolor(red) lpattern(dash) lwidth(medium)) /// 
               (function y=`x_min_2', range(0 `y_const_2') horizontal lcolor(black) lpattern(dash) lwidth(medium)), /// 
    title("Precition Curve if BaseAsset is ETH") /// 
    xtitle("FeeTier") ytitle("Cubic Prediction") /// 
    xlabel(0(0.0025)0.01) /// 
    ylabel(0(0.2)0.8) 
