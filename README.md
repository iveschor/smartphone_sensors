smartphone_sensors
==================

The run_analysis function works with the Human Activity Recognition Using Smartphones Dataset. It loads the files of the dataset (assuming that the files are in the R working directory) and outputs a tidy dataset named 'tidy'. It also writes the dataset as a tab-delimited text file named 'tidy.txt'.

run_analysis performs the following steps in order to produce the tidy dataset:

1. read the names of features from 'features.txt'. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

2. read the names of activities from 'activity.labels.txt', along with their numeric codes. For example, activity #1 is 'WALKING'.

3. read the training and test signal data from 'X_train.txt' and 'X_test.txt'. These datasets do not include activity or subject information.

4. create subsets of the training and test datasets that include only the columns that are mean or standard deviation measures. The way in which this is determined is by looking at the feature names; they must include either the substring 'mean' or 'std'. The resulting subsets are stored as 'tidy_train' and 'tidy_test'.

5. read the activity data from 'y_train.txt' and 'y_test.txt'. These datasets include the numeric activity code that correspond, on a row-by-row basis, with the signal data stored in 'X_train.txt' and 'X_test.txt' -- and by extension, 'tidy_train' and 'tidy_test'.

6. look up each numeric activity code in 'y_train' and 'y_test' and append the corresponding activity name. Append the activity names to 'tidy_train' and 'tidy_test', so that each signal data record is now matched with the activity that produced the signal.

7. read the subject data from 'subject_train.txt' and 'subject_test.txt'. These datasets include the subject number that corresponds, on a row-by-row basis, with the signal data stored in 'X_train.txt' and 'X_test.txt' -- and by extension, 'tidy_train' and 'tidy_test'.

8. append the subject numbers to 'tidy_train' and 'tidy_test', so that each signal data record is now matched with the subject that produced the signal.

9. combine 'tidy_train' and 'tidy_test' into one dataset called 'combined'. This is done by simply stacking one on top of the other using rbind.

10. clean the column names (i.e. feature names) of 'combined' so that they don't cause problems for R. This is done by removing all instances of the following characters: hyphens, parentheses, and periods.

11. for each combination of subject and activity, compute the mean of each signal variable. Write this into a tidy data frame named 'tidy', and a tab-delimited text file named 'tidy.txt'.

The format of 'tidy' is as follows:

'tidy' contains 180 rows (6 activities x 30 subjects), sorted by 'activity' (alphabetically) and then 'subject'. 'activity' is the activity name, and 'subject' is the subject number.

'tidy' contains 81 columns in the following order: activity, subject, and 79 signal features. For each combination of activity and subject, the value listed for each signal feature is the mean of all readings of that signal feature for that combination of activity and subject.

