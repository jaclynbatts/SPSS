* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 10/LBW (2).sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

*Simple linear regression model with low birth weight as the dependent variable and the dummy variable 
   indicator of receiving adequate prenatal care as the sole independent variable.


DATASET ACTIVATE DataSet2.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT birthwgt
  /METHOD=ENTER prenatal.

* Create an interaction term between the prenatal care and health insurance variable. That is, use a compute 
    command to multiple prenatal by insured to create the new variable named prenatXins. 

COMPUTE prenatXins=prenatal * insured.
EXECUTE.

*Run a linear regression model with birth weight as the dependent variable and prenatal care,
    insurance status, and the prenatal care by insurance status interaction term as independent variables.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT birthwgt
  /METHOD=ENTER prenatal insured prenatXins.

*Create a mean-centered version of the perceived racism variable. Use a compute command to subtract the 
    mean value of the variable racism from that variable itself to create a new variable 
    named racismcent. 

DESCRIPTIVES VARIABLES=racism
  /STATISTICS=MEAN STDDEV MIN MAX.

COMPUTE RacismCent=racism-2.5127.
EXECUTE.

*Create an interaction tern between prenatal care and the mean-centered exposure to racism variable, 
named prexrac.
COMPUTE PreXRac=prenatal * RacismCent.
EXECUTE.

*Run a linear regression model with birth weight as the dependent variable and prenatal care, mean-centered 
    exposure to racism, and the interaction term.


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT birthwgt
  /METHOD=ENTER prenatal RacismCent PreXRac.
