Getting and Cleaning Data Project
=================================

Description
-----------

Information about the variables data and transformations used in the course project

Source Data
-----------
A full description of the data used in this project can be found at The UCI Machine Learning Repository
[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Data Set Information
--------------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Attribute Information
---------------------

For each record in the dataset it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.

Preprocessing
-------------
Install required packages and load them. 
Download the zip file and load the files into data frames.

* YTest 
* XTest 
* SubjectTest 
* YTrain 
* XTrain 
* SubjectTrain 
* Features 
* Activitylabels


Merge the training and the test sets to create one data set
-----------------------------------------------------------
Row bind the XTrain and XTest data frames to combine into a TrainAndTest data frame.
Remove duplicated columns.

Extracts only the measurements on the mean and standard deviation for each measurement
-------------------------------------------------------------------------------------
Extracts only the measurements on the mean and standard deviation for each measurement (keep the subject id and activity as well).

Use grep function to match the pattern "mean|std|subjectid|activity" in column names of TrainAndTest data frame.

Use descriptive activity names to name the activities in the data set
---------------------------------------------------------------------
Use the descriptive names for activities.

  * (1 - "Walking")
  * (2 - "Walking Upstairs")
  * (3 - "Walking Downstairs")
  * (4 - "Sitting")
  * (5 - "Standing")
  * (6 - "Laying")


Appropriately label the data set with descriptive variable names.
------------------------------------------------------------------

  * Observe the data frame current names [ names(TrainAndTest) ]
  * Clean the characters like '('  ')'   ','   '-' using the gsub
  * Make it all column names lower case
  * Change acronyms in colnames
  
      *. "Acc"   - "Accelerator"
      *. "Mag"   - "Magnitude"
      *. "Gyro"  - "Gyroscope"
      *. "^t"    -  "time"
      *."^f"    -  "frequency"
      
  * change participant names in all rows.

Summarize
---------------------------------------------------------------------------------------------------------
_**From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject(/participant)**_

Using dplyr's *group_by* and *summarize_each* verbs, prepare the tidydata data frmame and write it to the output file
called tidy.txt.
