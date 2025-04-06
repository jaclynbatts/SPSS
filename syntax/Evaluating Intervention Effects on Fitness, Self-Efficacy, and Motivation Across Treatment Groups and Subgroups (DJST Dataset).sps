*This SPSS syntax analyzes the impact of a school-based intervention on physical activity, cardiovascular fitness, self-efficacy, and value-expectancy using the DJSTPrePost.sav dataset. The analysis includes both full-sample and subgroup evaluations, using appropriate statistical tests for repeated measures and small sample sizes. Key steps include:

Pretest-posttest paired sample t-tests within the treatment group for continuous variables.
Nonparametric tests:
McNemar's test to assess change in proportions of poor fitness (binary HR classification).
Wilcoxon signed-rank tests for ordinal fitness categories and small sample subgroup comparisons.
Between-group posttest comparisons using independent samples t-tests and Mann-Whitney U tests.
Chi-square test comparing posttest poor fitness proportions by treatment group.
ANCOVA models (UNIANOVA) for each continuous outcome, controlling for pretest values to evaluate treatment effect.
Subgroup analysis of boys and girls in Clara Barton school, using nonparametric tests appropriate for small sample sizes to compare pre-post change and between-group differences.
This comprehensive approach allows for both broad and nuanced evaluation of intervention effectiveness across behavioral and physiological outcomes.

* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Graded Assignment 2/DJSTPrePost.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

*1. Limiting your attention to members of the treatment group, 
 determine whether and by how much self-efficacy, value-expectancy, physical activity, and heart rate changed between pretest and posttest.

DATASET ACTIVATE DataSet2.
USE ALL.
COMPUTE filter_$=(TREAT = 1).
VARIABLE LABELS filter_$ 'TREAT = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.

T-TEST PAIRS=SEpre VEpre PHYSACTpre HRpre WITH SEpost VEpost PHYSACTpost HRpost (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

*2. Still limiting your attention to members of the treatment group, determine whether there was any change, and if so how much,
  between pretest and posttest in (a) the proportion of participants who had poor fitness (heart rates above 110 beats/minute).

NPAR TESTS
  /MCNEMAR=HRPoorpre WITH HRPoorpost (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.
*and (b) the proportions of participants across the five fitness categories: excellent, good, average, poor, and very poor.

NPAR TESTS
  /WILCOXON=HRCatpre WITH HRCatpost (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

*3. Next, ignore the pretest data and compare the treatment and control groups on the following posttest measures: 
    self-efficacy, value-expectancy, physical activity, and heart rate.
FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

T-TEST GROUPS=TREAT(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=SEpost VEpost PHYSACTpost HRpost
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

*4. Compare the treatment and control groups in terms of (a) the proportion of participants 
 who were had poor fitness (heart rates above 110 beats/minute) at posttest. 

 CROSSTABS
  /TABLES=TREAT BY HRPoorpost
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

 *and (b) the proportions of participants across the five fitness categories.

NPAR TESTS
  /M-W= HRCatpost BY TREAT(0 1)
  /STATISTICS=DESCRIPTIVES 
  /MISSING ANALYSIS.

*5. For each continuous posttest variable (i.e., self-efficacy, value-expectancy, physical activity, and heart rate), 
 carry out an analysis that incorporates the corresponding pretest variable into an examination 
 of the effect of being in the treatment group versus the control group.

UNIANOVA SEpost BY TREAT WITH SEpre
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(TREAT) WITH(SEpre=MEAN) 
  /PRINT ETASQ DESCRIPTIVE PARAMETER
  /CRITERIA=ALPHA(.05)
  /DESIGN=TREAT SEpre.

UNIANOVA VEpost BY TREAT WITH VEpre
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(TREAT) WITH(VEpre=MEAN) 
  /PRINT ETASQ DESCRIPTIVE PARAMETER
  /CRITERIA=ALPHA(.05)
  /DESIGN=TREAT VEpre.

UNIANOVA PHYSACTpost BY TREAT WITH PHYSACTpre
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(TREAT) WITH(PHYSACTpre=MEAN) 
  /PRINT ETASQ DESCRIPTIVE PARAMETER
  /CRITERIA=ALPHA(.05)
  /DESIGN=TREAT PHYSACTpre.

UNIANOVA HRpost BY TREAT WITH HRpre
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(TREAT) WITH(HRpre=MEAN) 
  /PRINT ETASQ DESCRIPTIVE PARAMETER
  /CRITERIA=ALPHA(.05)
  /DESIGN=TREAT HRpre.

*
Carry out the analyses requested in Task 1 for (a) girls in Clara Barton.

FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

USE ALL.
COMPUTE filter_$=(MALE=0  & SCHOOL = 1).
VARIABLE LABELS filter_$ 'MALE=0  & SCHOOL = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.

NPAR TESTS
  /WILCOXON=HRpre SEpre PHYSACTpre VEpre WITH HRpost SEpost PHYSACTpost VEpost (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

*(b) boys in Clara Barton. Note that your analyses should be appropriate for the small sample sizes in these subgroups.

FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

USE ALL.
COMPUTE filter_$=(MALE=1  & SCHOOL = 1).
VARIABLE LABELS filter_$ 'MALE=1  & SCHOOL = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.

NPAR TESTS
  /WILCOXON=HRpre SEpre PHYSACTpre VEpre WITH HRpost SEpost PHYSACTpost VEpost (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

*7. Likewise, carry out analyses requested in Task 3 for (a) girls in Clara Barton.
 
 FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

USE ALL.
COMPUTE filter_$=(MALE=0  & SCHOOL = 1).
VARIABLE LABELS filter_$ 'MALE=0  & SCHOOL = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.

NPAR TESTS
  /M-W= HRpost PHYSACTpost VEpost SEpost BY TREAT(0 1)
  /STATISTICS=DESCRIPTIVES 
  /MISSING ANALYSIS.

  
 *and (b) boys in Clara Barton, 
 making sure that your analysis is appropriate to the small sample size.

FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

USE ALL.
COMPUTE filter_$=(MALE=1  & SCHOOL = 1).
VARIABLE LABELS filter_$ 'MALE=1  & SCHOOL = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.

NPAR TESTS
  /M-W= HRpost PHYSACTpost VEpost SEpost BY TREAT(0 1)
  /STATISTICS=DESCRIPTIVES 
  /MISSING ANALYSIS.
