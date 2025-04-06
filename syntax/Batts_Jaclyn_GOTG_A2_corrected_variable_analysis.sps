* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment '+
    '2/FirstQnaires.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.
 

DATASET ACTIVATE DataSet1.
ADD FILES /FILE=*
  /FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment '+
    '2/SecondQnaires.sav'.
EXECUTE.

GET FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 2/LDLfile.sav'.
DATASET NAME DataSet2.
DATASET ACTIVATE DataSet1.
SORT CASES BY id.
DATASET ACTIVATE DataSet2.
SORT CASES BY id.
DATASET ACTIVATE DataSet1.
MATCH FILES /FILE=*
  /FILE='DataSet2'
  /BY id.
EXECUTE.

DESCRIPTIVES VARIABLES=ldla
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=male race latino x1a x2a x3a x4a x5a x6a x7a x8a x9a x10a
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=x11a x12a x13a x14a x15a x16a x17a x18a x19a x20a
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=x11a x12a x13a x14a x15a x16a x17a x18a x19a x20a
  /ORDER=ANALYSIS.


SAVE OUTFILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 2/Batts_Jaclyn_GOTG_0121.sav'
  /COMPRESSED.

*Analysis on corrected variables*

DESCRIPTIVES VARIABLES=ldla
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=male race latino x1a x2a x3a x4a x5a x6a x7a x8a x9a x10a
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=x11a x12a x13a x14a x15a x16a x17a x18a x19a x20a
  /STATISTICS=MEAN STDDEV MIN MAX.
