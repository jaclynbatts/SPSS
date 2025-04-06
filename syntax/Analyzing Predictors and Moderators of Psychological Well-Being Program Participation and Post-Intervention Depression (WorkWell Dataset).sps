*This SPSS syntax file analyzes participation in a psychological well-being program (Enroll) and its effects on post-intervention depression scores (DepressPost), using the WorkWell-1.sav dataset. The syntax covers both predictive modeling of program enrollment and evaluation of the program’s outcomes, using a mix of logistic and linear regression analyses.

Key steps include:

Descriptive and frequency statistics for continuous and categorical variables.
Dummy variable creation for race/ethnicity categories.
Logistic regression models:
Six univariate models predicting Enroll from potential confounders.
One multivariable model including all six confounders.
Linear regression models:
Six univariate models predicting DepressPost from each confounder.
One multivariable regression with all confounders predicting DepressPost.
Independent t-test comparing depression scores by enrollment status.
ANCOVA (UNIANOVA) to evaluate Enroll effect on DepressPost, controlling for DepressPre, job stress, and social support.
Interaction/moderation analysis:
Testing whether the effect of Enroll varies by gender or pre-intervention depression, including mean-centering and interaction terms.
Two models for each interaction (with and without control variables).
This syntax evaluates both predictors of program participation and whether program effectiveness differs by individual characteristics like gender and initial depression levels.

* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Graded Assignment 3/WorkWell-1.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.
*Descriptive statistics for continuous variables.
DESCRIPTIVES VARIABLES=DepressPre JobStrPre SocSupPre DepressPost
  /STATISTICS=MEAN STDDEV MIN MAX.
*Frequencies for categorical variables.
FREQUENCIES VARIABLES=Female RaceEth College Enroll
  /ORDER=ANALYSIS.

*Run six logistic regression models, each predicting Enroll, and each containing
 one of the six potential confounders.
*Recode Race/ethnicity into dummy variable with NH White as reference group.
RECODE RaceEth (1=1) (2=0) (3=0) (4=0) (5=0) INTO RaceDum1.
RECODE RaceEth (1=0) (2=1) (3=0) (4=0) (5=0) INTO RaceDum2.
RECODE RaceEth (1=0) (2=0) (3=1) (4=0) (5=0) INTO RaceDum3.
RECODE RaceEth (1=0) (2=0) (3=0) (4=1) (5=0) INTO RaceDum4.
RECODE RaceEth (1=0) (2=0) (3=0) (4=0) (5=1) INTO RaceDum5.

VARIABLE LABELS RaceDum1 'Dummy: Non-Hispanic White'.
VARIABLE LABELS RaceDum2 'Dummy: Non-Hispanic Black'.
VARIABLE LABELS RaceDum3 'Dummy: Hispanic or Latino'.
VARIABLE LABELS RaceDum4 'Dummy: Asian'.
VARIABLE LABELS RaceDum5  'Dummy: Other Race/Ethnicity'.

VALUE LABELS RaceDum1 RaceDum2 RaceDum3 RaceDum4 RaceDum5
    1 'Yes'
    0 'No'.

 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER DepressPre
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX.   

 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER Female    
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX.   
 
 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER  RaceDum2 RaceDum3 RaceDum4 RaceDum5
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX. 

 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER  JobStrPre
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX. 
 
 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER  SocSupPre
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX. 

 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER  College
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX. 

*As a further test of whether DepressPre, Female, RaceEth, JobStrPre, SocSupPre, and/or College are associated with Enroll, run a single multivariable logistic regression model using all 
 six of these potential confounders simultaneously as independent variables.

 LOGISTIC REGRESSION VARIABLES Enroll    
  /METHOD=ENTER DepressPre Female RaceDum2 RaceDum3 RaceDum4 RaceDum5 
 JobStrPre SocSupPre College
  /CRITERIA=PIN(.05) /STATISTICS=MEAN STDDEV MIN MAX. 

*Run six linear regression models, each predicting DepressPost,
 and each containing one of the six potential confounders. 

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER DepressPre.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER Female.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER RaceDum2 RaceDum3 RaceDum4 RaceDum5.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER JobStrPre.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER SocSupPre.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER College.

*Multivariable linear regression with all six confounders. 

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER DepressPre Female RaceDum2 RaceDum3 RaceDum4 RaceDum5 JobStrPre SocSupPre College.

*Compare DepressPost means by Enroll (no covariates)
 
T-TEST GROUPS=Enroll(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=DepressPost
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

*Linear regression predicting DepressPost by Enroll, controlling for selected confounders.

UNIANOVA DepressPost BY Enroll WITH DepressPre JobStrPre SocSupPre    
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(Enroll) WITH(DepressPre=MEAN JobStrPre=MEAN SocSupPre=MEAN) 
  /PRINT DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=DepressPre Enroll JobStrPre SocSupPre.

*Two linear regression models to see if the effect of enrollment in the psychological
  well-being module appears to vary by gender. Do not include any control variables (other than gender) in the first model. 
COMPUTE FemEn= Female * Enroll.
EXECUTE.
*Model 1:.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER Female Enroll FemEn.
*Model 2.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER Female Enroll FemEn DepressPre JobStrPre SocSupPre.

*Linear regression model to see if they effect of enrollment in the psychological well-being module appears to vary 
 according to pretest depressive symptoms. Do not include any control variables (other than pretest depressive symptoms) 
 in the first model. 
COMPUTE DepressPreCent= DepressPre - 9.86.
COMPUTE DepressPreEnroll = DepressPreCent* Enroll.
EXECUTE.
*Model 1.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER DepressPreCent Enroll DepressPreEnroll.

*Model 2: Other control variables that were significant.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT DepressPost
  /METHOD=ENTER DepressPreCent Enroll DepressPreEnroll JobStrPre SocSupPre.



SAVE OUTFILE='/Users/kissmysoles/Desktop/Practical Data Management /Graded Assignment 3/Batts_GA3_RevisedOUTPUT.sav'
  /COMPRESSED.
