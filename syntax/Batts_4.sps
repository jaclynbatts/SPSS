* Encoding: UTF-8.

GET
  FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment 4/Gunk4.sav'.
DATASET NAME DataSet3 WINDOW=FRONT.

*Box plots for knowledge, self-efficacy, motivation, and LDL by sex.*
   
DATASET ACTIVATE DataSet3.
EXAMINE VARIABLES=knowa selfeffa motiva ldla BY male
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

*Cross-tabulation of sex hy high vs.not high LDL.*
 
CROSSTABS
  /TABLES=male BY hildla
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT 
  /COUNT ROUND CELL.

*Box plots for knowledge, self-efficacy, motivation, and LDL by race/ethnicity.*
DATASET ACTIVATE DataSet3.
EXAMINE VARIABLES=knowa selfeffa motiva ldla BY raceeth
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

*Cross-tabulation of race/ethnicity by high vs. not high DL.*
  
  CROSSTABS
  /TABLES=raceeth BY hildla
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT 
  /COUNT ROUND CELL. 

*Correlations between knowledge, self-efficacy, motivation, and LDL.*
    
CORRELATIONS
  /VARIABLES=knowa selfeffa motiva ldla
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

*Correlation matrix for knowledge, self-efficacy, and motivation.*
  
CORRELATIONS
  /VARIABLES=knowa selfeffa motiva 
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.
*Cross-tabulation of race/ethnicity with experimental group.*
    
CROSSTABS
  /TABLES=raceeth BY treat
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT 
  /COUNT ROUND CELL.

*Bar chart for proportion of treatment and control groups by sex.*

GRAPH
  /BAR(GROUPED)=PCT BY male BY treat.

*Descriptive statistics and box plots of LDL by experimental group.*

MEANS ldla BY treat
    /CELLS MEAN STDDEV MIN MAX.

EXAMINE VARIABLES=ldla BY treat
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

*Cross-tabulation of high LDL by experimental group.*
    
CROSSTABS
  /TABLES=treat BY hildla
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT 
  /COUNT ROUND CELL.

*Box plots for knowledge, self-efficacy, and motivation by experimental group*.

EXAMINE VARIABLES=knowa selfeffa motiva BY treat
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.


