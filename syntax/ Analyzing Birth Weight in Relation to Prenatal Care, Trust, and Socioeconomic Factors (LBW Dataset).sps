*This SPSS syntax explores the relationships between birth weight and a range of social, behavioral, and healthcare access variables using data from LBW.sav. The script includes:

Descriptive statistics for key variables, including birth weight, perceived racism, and medical mistrust.
Frequencies for categorical predictors such as prenatal care, insurance status, and education level.
Simple linear regression examining the relationship between prenatal care and birth weight.
Multiple regression models controlling for medical mistrust, insurance coverage, education level (dummy-coded), and perceived racism.
Creation of binary dummy variables to capture different education levels and insurance status for use in regression models.
These analyses aim to assess the extent to which social determinants and prenatal care access impact birth outcomes, particularly low birth weight (LBW).

* Encoding: UTF-8.
GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 8/LBW.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

*Run Frequencies/Descriptives on variables.

DATASET ACTIVATE DataSet2.
DESCRIPTIVES VARIABLES=racism mistrust birthwgt
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=prenatal insured education
  /ORDER=ANALYSIS.

*Simple linear regression: Birth weight vs Prenatal Care.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT birthwgt
  /METHOD=ENTER prenatal.

*Linear regression with medical mistrust index as a control variable.
 
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT birthwgt
  /METHOD=ENTER prenatal mistrust.

*Dummy labels representing the five levels of education in this data set. 
COMPUTE edu_less_hs = (education = 1).
COMPUTE edu_hs = (education = 2).
COMPUTE edu_some_college = (education = 3).
COMPUTE edu_college = (education = 4).
COMPUTE edu_more_college = (education = 5).
EXECUTE.

VARIABLE LABELS edu_less_hs 'Less HS'
               edu_hs 'HS Grad'
               edu_some_college 'Some College'
               edu_college 'College Grad'
               edu_more_college 'Beyond College'.

VALUE LABELS edu_less_hs edu_hs edu_some_college edu_college edu_more_college
  0 'No' 
  1 'Yes'.
EXECUTE.

*Last question.

COMPUTE has_insurance = (insured = 1).
VARIABLE LABELS has_insurance 'Has Health Insurance'.
VALUE LABELS has_insurance 0 'No' 1 'Yes'.
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT birthwgt
  /METHOD=ENTER prenatal mistrust has_insurance edu_less_hs edu_some_college edu_college edu_more_college racism.
