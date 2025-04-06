*This SPSS syntax analyzes data from the Gunk5.sav file to evaluate the effectiveness of an intervention targeting cholesterol knowledge, self-efficacy, motivation, and LDL cholesterol levels. Multiple research designs and statistical tests are employed to assess treatment effects in both the general sample and Hispanic/Latino subgroups. Key components include:

Paired sample t-tests to test pretest-posttest differences in the treatment group only.
Wilcoxon signed-rank tests for nonparametric comparison of pre- and post-intervention scores in Hispanic/Latino participants.
Independent sample t-tests comparing posttest outcomes between treatment and control groups.
Mann-Whitney U tests for subgroup-specific posttest-only comparisons in Hispanic/Latino participants.
ANCOVA models (pretest-posttest control group design) to compare posttest outcomes while controlling for 
pretest values across knowledge, self-efficacy, motivation, and LDL cholesterol.

* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 5/Gunk5.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.
*Limit analysis to participants assigned to treatment group.  

DATASET ACTIVATE DataSet2.
USE ALL.
COMPUTE filter_$=(treat = 1).
VARIABLE LABELS filter_$ 'treat = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.
*Pretest post-test design statistical test of the null hypothesis of no intervention on knowledge scale scores. 

T-TEST PAIRS=knowa WITH knowb (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.
*Pretest post-test design statistical test of the null hypothesis of no intervention on self-efficacy scale score, motivation scale score, and LDL levels.

T-TEST PAIRS=selfeffa motiva ldla WITH selfeffb motivb ldlb (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

*Limit analysis to participants categorized as Hispanic or Latino. 

USE ALL.
COMPUTE filter_$=(treat = 1 &  latino = 1).
VARIABLE LABELS filter_$ 'treat = 1 &  latino = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.
*Nonparametric statistical test of the null hypothesis of no intervention on self-efficacy scale score, motivation scale score, and LDL levels.
NPAR TESTS
  /WILCOXON=knowa selfeffa motiva ldla WITH knowb selfeffb motivb ldlb (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.
*Posttest only control group design .
FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

T-TEST GROUPS=treat(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=knowb
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

T-TEST GROUPS=treat(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=selfeffb motivb ldlb
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).
*Posttest only Hispanic/Latino. 

USE ALL.
COMPUTE filter_$=(latino = 1).
VARIABLE LABELS filter_$ 'latino = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
_SLINE OFF.

NPAR TESTS
  /M-W= knowb selfeffb motivb ldlb BY treat(0 1)
  /MISSING ANALYSIS.

*Pretest-Posttest Control Group Design. 

FILTER OFF.
USE ALL.
EXECUTE.
_SLINE OFF.

UNIANOVA knowb BY treat WITH knowa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(treat) WITH(knowa=MEAN) 
  /PRINT DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=knowa treat.

UNIANOVA selfeffb BY treat WITH selfeffa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(treat) WITH(selfeffa=MEAN) 
  /PRINT DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=selfeffa treat.

UNIANOVA motivb BY treat WITH motiva
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(treat) WITH(motiva=MEAN) 
  /PRINT DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=motiva treat.

UNIANOVA ldlb BY treat WITH ldla
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(treat) WITH(ldla=MEAN) 
  /PRINT DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=ldla treat.
