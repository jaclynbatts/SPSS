* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 3/Gunk3.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

DATASET ACTIVATE DataSet1.

*Question 1*.
RECODE x1a x2a x5a x6a x7a x9a (1=1) (2=0) INTO x1rw x2rw x5rw x6rw x7rw x9rw.
VARIABLE LABELS  x1rw 'Right-wrong recode x1a'.
VARIABLE LABELS  x2rw 'Right-wrong recode x2a'.
VARIABLE LABELS  x5rw 'Right-wrong recode x5a'.
VARIABLE LABELS  x6rw 'Right-wrong recode x6a'.
VARIABLE LABELS  x7rw 'Right-wrong recode x7a'.
VARIABLE LABELS  x9rw 'Right-wrong recode x9a'.
EXECUTE.

RECODE x3a (1=0) (2=1) INTO x3rw.
RECODE x4a (1=0) (2=1) INTO x4rw.
RECODE x8a (1=0) (2=1) INTO x8rw.
RECODE x10a (1=0) (2=1) INTO x10rw.
VARIABLE LABELS  x3rw 'Right-wrong recode of x3a'.
VARIABLE LABELS  x4rw 'Right-wrong recode of x4a'.
VARIABLE LABELS  x8rw 'Right-wrong recode of x8a'.
VARIABLE LABELS  x10rw 'Right-wrong recode of x10a'.
EXECUTE.

* Define Variable Properties.
*x1rw.
VALUE LABELS x1rw x2rw x3rw x4rw x5rw x6rw x7rw x8rw x9rw x10rw
  .00 'Incorrect'
  1.00 'Correct'.
EXECUTE.
*Question 2) Reverse-coded versions*.
COMPUTE x12rev=6-x12a.
COMPUTE x14rev=6-x14a.
COMPUTE x17rev=6-x17a.
COMPUTE x20rev=6-x20a.
EXECUTE.

* Define Variable Properties.
*x12rev.
VARIABLE LABELS  x12rev 'Reverse code of x12a'.
VARIABLE LABELS  x14rev 'Reverse code of x14a'.
VARIABLE LABELS  x17rev 'Reverse code of x17a'.
VARIABLE LABELS  x20rev 'Reverse code of x20a'.
VALUE LABELS x12rev X14rev x17rev x20rev
  1.00 'Lowest SE'
  2.00 'Low SE'
  3.00 'Medium SE'
  4.00 'High SE'
  5.00 'Highest SE'.
EXECUTE.

*Question 3) A knowledge scale score drawing upon items X1 through x10*.
COMPUTE KnowledgeScale=MEAN(x1rw,x2rw,x3rw,x4rw,x5rw,x6rw,x7rw,x8rw,x9rw,x10rw).
EXECUTE.
VARIABLE LABELS KnowledgeScale 'Knowledge-Scale'.
EXECUTE.
*Question 4) low cholesterol diet self-efficacy scale*. 
COMPUTE DietSelfEffa=MEAN(x11a,x12rev,x13a,x14rev,x15a).
EXECUTE.
VARIABLE LABELS DietSelfEffa 'Diet-Self-Efficacy'.
EXECUTE.

*Question5) Low-cholesterol diet motivation scale*.
COMPUTE DietMotivation=MEAN(x16a, x17rev, x18a, x19a, x20rev).
EXECUTE. 
VARIABLE LABELS DietMotivation 'Diet-Motivation'.
EXECUTE.

*Question 6*.
RECODE ldla (Lowest thru 100=1) (100 thru 130=2) (130 thru 160=3) (160 thru 190=4) (190 thru 
    Highest=5) INTO LDLCAT1.
VARIABLE LABELS  LDLCAT1 'Five-level-ordinal LDL category at pretest'.
EXECUTE.

VARIABLE LABELS LDLCAT1 'LDL Cholesterol Categories'.
VALUE LABELS LDLCAT1
    1 'Optimal (<100 mg/dL)'
    2 'Near Optimal (100-130 mg/dL)'
    3 'Borderline High (130-160 mg/dL)'
    4 'High (160-190 mg/dL)'
    5 'Very High (>=190 mg/dL)'.
EXECUTE.

*Question 7*.
IF  (ldla<=160) LDLCAT2=1.
IF  (ldla>=160) LDLCAT2=2.
EXECUTE.
VARIABLE LABELS LDLCAT2 'LDL Cholesterol Dichotomized'.
VALUE LABELS LDLCAT2
    1 'Not High (<160 mg/dL)'
    2 'High (>160 mg/dL)'.
EXECUTE. 
*Question 8*.
IF (latino=0 & race=1) RACEETH=1.
IF (latino=0 & race=2) RACEETH=2.
IF (latino=0 & race=3) RACEETH=3.
IF (latino=1) RACEETH=4.
IF (latino=0 & race=4) RACEETH=5.
EXECUTE.
*Question 9*.
VARIABLE LABELS RACEETH 'Combined Race and Ethnicity Variable'.
VALUE LABELS RACEETH
    1 'Non-Hispanic Black'
    2 'Non-Hispanic White'
    3 'Non-Hispanic Asian'
    4 'Hispanic/Latino'
    5 'Non-Hispanic Other'.
EXECUTE.

*Question 10*.
RELIABILITY
  /VARIABLES=x1rw x2rw x5rw x6rw x7rw x9rw x3rw x4rw x8rw x10rw
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.

RELIABILITY
/VARIABLES=x11a x12rev x13a x14rev x15a
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.

RELIABILITY
/VARIABLES=x16a x17rev x18a x19a x20rev
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.


DESCRIPTIVES VARIABLES=KnowledgeScale DietMotivation DietSelfEffa
  /STATISTICS=MEAN STDDEV MIN MAX.



FREQUENCIES VARIABLES=LDLCAT1 LDLCAT2 RACEETH
  /ORDER=ANALYSIS.


SAVE OUTFILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 3/Batts_Gunk3_REV.sav'
  /COMPRESSED.
