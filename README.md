# Getting and Cleaning Data assignment

## run_analysis.R

An R script that contains the method `analyze` which takes a path of the
directory containing the samsung dataset available here
`http://archive.ics.uci.edu/ml/machine-learning-databases/00240/` and analyze it
and does the following

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each
measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with
the average of each variable for each activity and each subject.

## How to use

Source the file into RStudio, or R command line. then execute the following
`analyze(<data set dir>)` where <data set dir> is the directory for the data
set.

if you provide another argument for a resulting file, the return value ( the
resulting data set ) shall be saved into that file path you pass.
eg. `analyze(<data set dir>, <file path to save dataset into>)`
