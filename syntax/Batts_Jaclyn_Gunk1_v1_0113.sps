* Encoding: UTF-8.


GET DATA
  /TYPE=XLSX
  /FILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment_1/Gunk1.xlsx'
  /SHEET=name 'Gunk1'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

DATASET ACTIVATE DataSet1.
* Define Variable Properties.
*id.
VARIABLE LABELS  id 'Participant ID'.
EXECUTE.

* Define Variable Properties.
*x1a.
VARIABLE LABELS  x1a 'Which do you think has more cholesterol 1 PRE '.
VALUE LABELS x1a
  1 'Cheeseburger'
  2 'Hamburger'.
EXECUTE.

* Define Variable Properties.
*male.
VARIABLE LABELS  male 'What is your sex?'.
VALUE LABELS male
  0 'Female'
  1 'Male'.
EXECUTE.

* Define Variable Properties.
*race.
VARIABLE LABELS  race 'Which of the following best describes your race?'.
VALUE LABELS race
  1 'Black or African American'
  2 'White'
  3 'Asian'
  4 'Other'.
EXECUTE.

* Define Variable Properties.
*latino.
VARIABLE LABELS  latino 'Are you Hispanic/Latino? '.
VALUE LABELS latino
  0 'No'
  1 'Yes'.
EXECUTE.

* Define Variable Properties.
*x2a.
VARIABLE LABELS  x2a 'Which do you think has more cholesterol 2 PRE'.
VALUE LABELS x2a
  1 'Green salad with 1000 Island Dressing'
  2 'Steamed asparagus (12 spears)'.
EXECUTE.

* Define Variable Properties.
*x3a.
VARIABLE LABELS  x3a 'Which do you think has more cholesterol 3 PRE'.
VALUE LABELS x3a
  1 'English muffin with butter and jelly'
  2 'Blueberry muffin'.
EXECUTE.

* Define Variable Properties.
*x4a.
VARIABLE LABELS  x4a 'Which do you think has more cholesterol 4 PRE'.
VALUE LABELS x4a
  1 'Peanut butter and jelly on wheat'
  2 'Roast beef sandwich on wheat'.
EXECUTE.

* Define Variable Properties.
*x5a.
VARIABLE LABELS  x5a 'Which do you think has more cholesterol 5 PRE'.
VALUE LABELS x5a
  1 'Scrambled eggs (2 eggs)'
  2 'Roasted chicken breast'.
EXECUTE.

* Define Variable Properties.
*x6a.
VARIABLE LABELS  x6a 'Which do you think has more cholesterol 6 PRE'.
VALUE LABELS x6a
  1 'Low fat yogurt with blueberries'
  2 'Cornflakes with 1 cup skim milk'.
EXECUTE.

* Define Variable Properties.
*x6a.
VALUE LABELS x6a
  1 'Low fat yogurt with blueberries'
  2 'Cornflakes with 1 cup skim milk'.
EXECUTE.

* Define Variable Properties.
*x7a.
VARIABLE LABELS  x7a 'Which do you think has more cholesterol 7 PRE'.
VALUE LABELS x7a
  1 'Tuna salad (1 cup)'
  2 'Chicken noodle soup'.
EXECUTE.

* Define Variable Properties.
*x8a.
VARIABLE LABELS  x8a 'Which do you think has more cholesterol 8 PRE'.
VALUE LABELS x8a
  1 'Chocolate chip cookies (4)'
  2 'Vanilla Ice cream (1 cup)'.
EXECUTE.

* Define Variable Properties.
*x9a.
VARIABLE LABELS  x9a 'Which do you think has more cholesterol 9 PRE'.
VALUE LABELS x9a
  1 'Trout with butter and lemon juice'
  2 'Vegetable beef soup '.
EXECUTE.

* Define Variable Properties.
*x10a.
VARIABLE LABELS  x10a 'Which do you think has more cholesterol 10 PRE'.
VALUE LABELS x10a
  1 'French fries'
  2 'Mashed potatoes'.
EXECUTE.

* Define Variable Properties.
*x11a.
VARIABLE LABELS  x11a 'I can eat a LC diet.'.
VALUE LABELS x11a x12a x13a x14a x15a x16a x17a x18a x19a x20a
  1 'Strongly Disagree'
  2 'Disagree'
  3 'Neither Disagree Nor Agree'
  4 'Agree '
  5 'Strongly Agree'.
EXECUTE.

* Define Variable Properties.
*x12a.
VARIABLE LABELS  x12a "I'm not sure I can stick to a LC diet.".
EXECUTE.

* Define Variable Properties.
*x13a.
VARIABLE LABELS  x13a 'A LC diet is no problem for me.'.
EXECUTE.

* Define Variable Properties.
*x14a.
VARIABLE LABELS  x14a 'Sticking to a LC diet could be tough for me.'.
EXECUTE.

* Define Variable Properties.
*x15a.
VARIABLE LABELS  x15a 'I know how to eat an LC diet.'.
EXECUTE.

* Define Variable Properties.
*x16a.
VARIABLE LABELS  x16a 'Maintaining a LC diet is a top priority for me.'.
EXECUTE.

* Define Variable Properties.
*x17a.
VARIABLE LABELS  x17a "I'm not sure an LC diet is important to me.".
EXECUTE.

* Define Variable Properties.
*x18a.
VARIABLE LABELS  x18a 'I am determined to stick to an LC diet.'.
EXECUTE.

* Define Variable Properties.
*x19a.
VARIABLE LABELS  x19a 'I will do whatever it takes to eat a LC diet.'.
EXECUTE.

* Define Variable Properties.
*x20a.
VARIABLE LABELS  x20a "I'm not very motivated to stick to a LC diet. ".
EXECUTE.

* Define Variable Properties.
*ldla.
VARIABLE LABELS  ldla 'What was your LDL level on your recent blood test?'.
EXECUTE.


SAVE OUTFILE='/Users/kissmysoles/Desktop/Practical Data Management /Practice Assignment_1/Batts_Jaclyn_Gunk1.sav'
  /COMPRESSED.
