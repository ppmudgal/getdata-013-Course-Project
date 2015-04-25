Getting and Cleaning Data Course Project
This repository contains the code for my solution to the assignment of the course "Getting and Cleaning Data".

Description of the assignment

One of the most exciting areas in all of data science right now is wearable computing - see for example this article ( http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/ ). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

My solution: - 

To run the analysis, perform the following steps:

1) Unzip the folder UCI HAR Dataset in your working directory.

2) Place run_analysis.R in your working directory.

3) Ensure you have the packages stringr, plyr and reshape2 installed.

4) Load the source run_analysis.R at your session in R, with source("run_analysis.R")

5) Finally, execute run.analysis() in R.

6) The Tidy data set under the name Tidy_Data.txt


