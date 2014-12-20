Getting and Cleaning Data
===========================

The values shown are mean calculations on a selected set of variables from the Human Activity Recognition Using Smartphones Dataset Version 1.0.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data are accelerometer and gyroscope data, captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. This data was collected for 30 test subjects during 6 different possible activities.

From the original data a subset of mean and standard deviation values were chosen for all subjects and activities. The mean was subsequently calculated on the subset and grouped by subject and activity.

The run_analysis script outputs a tab delimited text file that transforms the original data into the selected tidy one. It also downloads and unzip data files from the original study.

The below are provided for each observation:
---------------------------------------
1. A 79-feature vector with time and frequency domain variables (mean and standard deviation calculations)
2. Its activity label.
3. An identifier of the subject who carried out the experiment.


The dataset includes the following files:
----------------------------------------
1. README.md
2. codebook.md
3. run_analysis.R

Pleae review the codebook.MD for more details.