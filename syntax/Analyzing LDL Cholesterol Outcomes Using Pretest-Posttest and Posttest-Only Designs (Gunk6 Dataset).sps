*This SPSS syntax analyzes LDL cholesterol outcomes from the Gunk6.sav dataset using both pretest-posttest and posttest-only control group designs. The analyses include:

Filtering treatment group participants for one-group pretest-posttest comparisons.
McNemar’s test to evaluate changes in binary LDL status (high vs. not high) before and after the intervention.
Wilcoxon Signed-Ranks test to compare ordinal LDL categories pre- and post-intervention within the treatment group.
Chi-square test for posttest-only comparisons between treatment and control groups on LDL status.
Mann-Whitney U test to assess post-intervention ordinal LDL category differences by treatment group.

* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 6/Gunk6.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

*1) Filter for one-group pretest-posttest design.

DATASET ACTIVATE DataSet2.
USE ALL.
COMPUTE filter_$=(treat = 1).
VARIABLE LABELS filter_$ 'treat = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.


CROSSTABS
  /TABLES=hildla BY hildlb
  /FORMAT=AVALUE TABLES
  /STATISTICS=MCNEMAR 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

*2)Ordinal Wilcoxon's Signed Ranks test. 

NPAR TESTS
  /WILCOXON=ldl5cata WITH ldl5catb (PAIRED)
  /MISSING ANALYSIS.

FREQUENCIES VARIABLES=ldl5cata ldl5catb
  /ORDER=ANALYSIS.

*3)Posttest only control group. 

FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

CROSSTABS
  /TABLES=treat BY hildlb
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.

*4)Ordinal dependent variable on treatment groups before and after intervention.

CROSSTABS
  /TABLES=treat BY ldl5catb
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.


NPAR TESTS
  /M-W= ldl5catb BY treat(0 1)
  /MISSING ANALYSIS.
