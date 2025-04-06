*This SPSS syntax examines predictors of low birth weight (LBW) using a series of logistic regression models. The dataset (LBW (1).sav) is used to assess how prenatal care, medical mistrust, health insurance status, education level, and perceived racism relate to the likelihood of an infant being born under 2500 grams. Key steps include:

Creating a binary variable (lowbw) to indicate low birth weight status.
Running descriptive statistics and frequencies for all variables including the derived indicator.
Building a series of logistic regression models:
Model 1: Prenatal care as the sole predictor of LBW.
Model 2: Controlling for medical mistrust.
Model 3: A full model including prenatal care, mistrust, insurance, dummy-coded education levels, and perceived racism.
Dummy coding education into five categorical variables for inclusion in regression modeling.
Interpreting odds ratios and model fit to assess which social and structural variables significantly influence LBW outcomes.

* Encoding: UTF-8.

GET
  FILE='/Users/laffy/Library/Mobile Documents/com~apple~CloudDocs/Desktop/Practical Data '+
    'Management /Practice assignment 9/LBW (1).sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

*Create new variable named LBW that takes value 0 if the birth weight of the infant was greater 
    than or equal to 2500 grams and 1 if it was less than 2500 grams.


DATASET ACTIVATE DataSet1.
RECODE birthwgt (Lowest thru 2500=1) (2500 thru Highest=0) INTO lowbw.
VARIABLE LABELS  lowbw 'low birth weight indicator'.
EXECUTE.

*Run frequencies/descriptives on all variables in the data set including new derived 
    indicator of low birth weight. 

FREQUENCIES VARIABLES=prenatal insured education lowbw
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=racism mistrust birthwgt
  /STATISTICS=MEAN STDDEV MIN MAX.

*Step 3: Logistic regression model with low birth weight as the dependent variable and 
 the dummy variable indicator of receiving adequate prenatal care as the sole independent
 variable. 

LOGISTIC REGRESSION VARIABLES lowbw
  /METHOD=ENTER prenatal 
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

*Medical Mistrust Index as a control variable to the logistic regression model.

LOGISTIC REGRESSION VARIABLES lowbw
  /METHOD=ENTER prenatal mistrust
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX.


*Create four or five dummy variables representing the five levels of education in this data set.

RECODE education (1=1) (2=0) (3=0) (4=0) (5=0) INTO Edcat1.
RECODE education (1=0) (2=1) (3=0) (4=0) (5=0) INTO Edcat2.
RECODE education (1=0) (2=0) (3=1) (4=0) (5=0) INTO Edcat3.
RECODE education (1=0) (2=0) (3=0) (4=1) (5=0) INTO Edcat4.
RECODE education (1=0) (2=0) (3=0) (4=0) (5=1) INTO Edcat5.
VARIABLE LABELS  Edcat1 'Education category 1'.
VARIABLE LABELS  Edcat2 'Education category 2'.
VARIABLE LABELS  Edcat3 'Education category 3'.
VARIABLE LABELS  Edcat4 'Education category 4'.
VARIABLE LABELS  Edcat5 'Education category 5'.
VALUE LABELS Edcat1 Edcat2 Edcat3 Edcat4 Edcat5
    1 'Yes' 
    0 'No'.
EXECUTE.

*Add dummy indicator of having versus not having health insurance, four education 
 dummy variables, and the perceived racism scale score to the logistic regression.

LOGISTIC REGRESSION VARIABLES lowbw
  /METHOD=ENTER prenatal mistrust insured Edcat2 Edcat3 Edcat4 Edcat5 racism
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX.


