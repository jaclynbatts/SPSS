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

*Linear regression with medical mistrust index as a control variable:
 
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
