*This SPSS syntax analyzes data from the AgeHeight.sav file to examine how height varies in relation to age, sex, and academic grade level. It applies multiple statistical techniques, including:

Scatterplot visualization of the relationship between age and height.
Simple linear regression to assess how age predicts height.
Creation of a dummy variable to represent male gender.
Regression analysis testing the relationship between height and gender (via the dummy variable).
Independent samples t-test to compare average height between boys and girls.
Multiple linear regression to examine the relationship between height and grade level using dummy variables.
One-way ANOVA to test height differences across grade levels and perform post-hoc comparisons.
These analyses provide insight into developmental trends and group differences in height among children.

* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 7/AgeHeight.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

*1: Create a scatteplot with age on the horizontal axis and height on the vertical axis. 

DATASET ACTIVATE DataSet2.
GRAPH
  /SCATTERPLOT(BIVAR)=AGE WITH HEIGHT
  /MISSING=LISTWISE.

*2:Run a Linear Regression (Height varies relation to age). 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT HEIGHT
  /METHOD=ENTER AGE
  /RESIDUALS DURBIN
  /CASEWISE PLOT(ZRESID) OUTLIERS(3).

*3:Create a Dummy Variable for Male (MALE). 
COMPUTE MALE = (SEX = 2).
VARIABLE LABELS MALE "Male Dummy Variable (1=Male, 0=Female)".
VALUE LABELS MALE
  0 "Female"
  1 "Male".
EXECUTE.

*4. Regression (Height varies relation to dummy variable MALE. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT HEIGHT
  /METHOD=ENTER MALE
  /RESIDUALS DURBIN
  /CASEWISE PLOT(ZRESID) OUTLIERS(3).

*5. Use an independent samples t-test to test the null hypothesis that the average heights of girls
  and boys are identical in this population. 
T-TEST GROUPS=SEX(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=HEIGHT
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

*7) Regression Model ( Relation of height and grades).

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT HEIGHT
  /METHOD=ENTER KinderDum FirstDum SecondDum ThirdDum FourthDum
  /RESIDUALS DURBIN
  /CASEWISE PLOT(ZRESID) OUTLIERS(3).

*8) One-Way ANOVA .

ONEWAY HEIGHT BY GRADE
  /ES=OVERALL
  /STATISTICS DESCRIPTIVES HOMOGENEITY 
  /PLOT MEANS
  /MISSING ANALYSIS
  /CRITERIA=CILEVEL(0.95)
  /POSTHOC=TUKEY ALPHA(0.05).


