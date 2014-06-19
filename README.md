run_analysis.R
======================

This is the solution for the Course Project of the coursera Getting And Cleaning Data course.

### What is the goal of the script:
* to download data files which contain accelerometer data for Samsung Galaxy smartphone
* based on the data create tidy data set with average values of the observed mean()/std() columns from both 
test and training set

### How the script works

Below are brief explanation how the script works:
* On the first step folder existence is checked. If folder does not exist it's created.
* Second step checks whether file have been already downloaded and download it if it wasn't.
* The same approach is used for unzipping the archive.
* Then both training and test data are merged into single dataset
* Column names are assigned to the columns of the full dataset and corresponding activity values (Y* data) replaced with their names
* Dataset is extended with Subject column
* Then tidy dataset containing mean value of all mean()/std() columns is created and written to the file named `tidy_data.txt`