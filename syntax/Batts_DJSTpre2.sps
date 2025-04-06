* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Graded Assignment 1/School1PRE.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.
*Merging School 2 Data. 
DATASET ACTIVATE DataSet1.
ADD FILES /FILE=*
  /FILE='/Users/kissmysoles/Desktop/Practical Data Management /Graded Assignment 1/School2PRE.sav'.
EXECUTE.
*Merging School 3 Data. 
ADD FILES /FILE=*
  /FILE='/Users/kissmysoles/Desktop/Practical Data Management /Graded Assignment 1/School3PRE.sav'.
EXECUTE.
*Check for misentries. 
FREQUENCIES VARIABLES= SCHOOL MALE RACE GRADE
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES= A1pre A2pre A3pre A4pre A5pre A6pre A7pre A8pre
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES= B1pre B2pre B3pre B4pre B5pre B6pre B7pre B8pre
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES= C1pre C2pre C3pre C4pre C5pre C6pre C7pre C8pre
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES= PHYSACTpre HRpre TREAT
  /ORDER=ANALYSIS.
EXECUTE.
* Descriptive statistics for Likert-scale variables.
DESCRIPTIVES VARIABLES= C1pre C2pre C3pre C4pre C5pre C6pre C7pre C8pre
  /STATISTICS=MEAN STDDEV MIN MAX.
EXECUTE.
*Value-expectancies for each of the eight possible outcomes of physical activity. 
COMPUTE VE1pre=A1pre * C1pre.
COMPUTE VE2pre = A2pre * C2pre.
COMPUTE VE3pre = A3pre * C3pre.
COMPUTE VE4pre = A4pre * C4pre.
COMPUTE VE5pre = A5pre * C5pre.
COMPUTE VE6pre = A6pre * C6pre.
COMPUTE VE7pre = A7pre * C7pre.
COMPUTE VE8pre = A8pre * C8pre.
EXECUTE.

VARIABLE LABELS VE1pre "Value-Expectancy for Coping with Stress".
VARIABLE LABELS VE2pre "Value-Expectancy for Having Fun".
VARIABLE LABELS VE3pre "Value-Expectancy for Making New Friends".
VARIABLE LABELS VE4pre "Value-Expectancy for Being in Shape".
VARIABLE LABELS VE5pre "Value-Expectancy for Being Attractive".
VARIABLE LABELS VE6pre "Value-Expectancy for Having Plenty of Energy".
VARIABLE LABELS VE7pre "Value-Expectancy for Getting Hot and Sweaty".
VARIABLE LABELS VE8pre "Value-Expectancy for Being Good at Sports or Other Activities".
EXECUTE.

*Compute Cronbach’s alpha for the eight derived value-expectancy measures 
    (VE1pre through VE8pre) and for the eight items measuring self-efficacy 
    (B1pre through B8pre).
RELIABILITY
  /VARIABLES=VE1pre VE2pre VE3pre VE4pre VE5pre VE6pre VE7pre VE8pre 
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=B1pre B2pre B3pre B4pre B5pre B6pre B7pre B8pre
 /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.

*Derive a baseline value-expectancy scale score (VEpre) as the mean of the eight value-expectancy measures (VE1pre through VE8pre) 
 and a baseline self-efficacy scale score (SEpre) as the mean of the eight self-efficacy indicators (B1pre through B8pre).

COMPUTE VEpre=MEAN(VE1pre,VE2pre,VE3pre,VE4pre,VE5pre,VE6pre,VE7pre,VE8pre).
EXECUTE.

COMPUTE SEpre=MEAN(B1pre,B2pre,B3pre,B4pre,B5pre,B6pre,B7pre,B8pre).
EXECUTE.

VARIABLE LABELS VEpre "Mean Value-Expectancy ".
EXECUTE.

VARIABLE LABELS SEpre "Mean Self-Efficacy ".
EXECUTE.


*"Categorizes HRpre into the  variable HRCatpre, classifying heart rate levels as :
 excellent (1), good (2), average (3), poor (4), and very poor (5).
IF  (HRpre < 80) HRCatpre=1.
IF  (HRpre>=80 & HRpre<90) HRCatpre=2.
IF  (HRpre>=90 & HRpre<110) HRCatpre=3.
IF  (HRpre>=110 & HRpre<120)HRCatpre=4.
IF  (HRpre>=120) HRCatpre=5.
VARIABLE LABELS HRCatpre 'Ordered category of HR'.
VALUE LABELS HRCatpre 1 'excellent' 2 'good' 3 'average' 4 'poor' 5 'very poor'.
EXECUTE.
*Dichotomize  variable HRPoorpre so that students whose heart rate is below 110 beats/minute are categorized as not poor (coded 0) 
 and those whose heart rates are greater than or equal to 110 are categorized as poor (coded 1).
COMPUTE HRPoorpre=0.
IF (HRpre >= 110) HRPoorpre=1.
EXECUTE.
VARIABLE LABELS HRPoorpre 'Dichotomized HR'.
VALUE LABELS HRPoorpre
    0 "Not Poor"
    1 "Poor".
EXECUTE.

* Obtain frequencies and/or descriptive statistics on the following derived variables: SEpre, VEpre, HRCatpre, and HRPoorpre.
DESCRIPTIVES VARIABLES=VEpre SEpre
  /STATISTICS=MEAN STDDEV MIN MAX.
FREQUENCIES VARIABLES=HRCatpre HRPoorpre
  /ORDER=ANALYSIS.

*. Obtain subgroup-specific frequencies and/or descriptive statistics for each of the derived variables mentioned in Part 10, 
 plus MALE, RACE, GRADE, SCHOOL, PHYSACTpre, and HRpre for the treatment and control groups.
SORT CASES BY TREAT.
SPLIT FILE BY TREAT.
DESCRIPTIVES VARIABLES=VEpre SEpre PHYSACTpre HRpre
  /STATISTICS=MEAN STDDEV MIN MAX.
FREQUENCIES VARIABLES=HRCatpre HRPoorpre MALE RACE GRADE  
  /ORDER=ANALYSIS.
SPLIT FILE OFF.

*Run pairwise correlations between SEpre, VEpre, PHYSACTpre, and HRpre.
CORRELATIONS
  /VARIABLES=SEpre VEpre PHYSACTpre HRpre 
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.


