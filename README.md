# Getting and Cleaning Data - Course Project
This repository contains R code and documentation for the course project

# Steps for the course project
You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# What the script does
Once the dataset is unzipped on the same directory as the `run_analysis.R` file, the script will load the train and test data, merge both and set the appropriate labels. It will then filter the mean and standard deviation columns. Finally, it will load the `reshape2` library and use `melt` to create observations for each subject and activity and `dcast` to calculate the means for them.

At the end it will have a `mean_std_data` dataset, results from steps 1 through 4 and a `tidy_data` dataset with the result from step 5.
