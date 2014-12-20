#Getting and Cleaning Data Course Project
# Merges the training and the test sets to create one data set.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Preprocessing
rm(list = ls(all=TRUE))
library(plyr)
library(dplyr)
library(data.table)

#Download the zip file
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(temp, list = TRUE)
YTest <- read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt"))
XTest <- read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt"))
SubjectTest <- read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt"))
YTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"))
XTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"))
SubjectTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"))
Features <- read.table(unzip(temp, "UCI HAR Dataset/features.txt"))
Activitylabels <- read.table(unzip(temp, "UCI HAR Dataset/activity_labels.txt"))
unlink(temp)

#get transpose of Features[2],and assign it to colnames for XTrain , XTest
colnames(XTrain) <- t(Features[2])
colnames(XTest) <- t(Features[2])

#establish common id
XTrain$activities <- YTrain[, 1]
XTrain$participants <- SubjectTrain[, 1]
XTest$activities <- YTest[, 1]
XTest$participants <- SubjectTest[, 1]


#1.Merge the training and the test sets to create one data set.
TrainAndTest <- rbind(XTrain, XTest)
duplicated(colnames(TrainAndTest))
TrainAndTest <- TrainAndTest[, !duplicated(colnames(TrainAndTest))]
head(TrainAndTest)
names(TrainAndTest)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#  Keep the subject id and activity as well.
pattern <- "mean|std|subjectid|activity"
meanAndStdData <- TrainAndTest[, grep(pattern, names(TrainAndTest), value=TRUE)]
head(meanAndStdData)

#3.Use descriptive activity names to name the activities in the data set
TrainAndTest$activities <- as.character(TrainAndTest$activities)
TrainAndTest$activities[TrainAndTest$activities == 1] <- "Walking"
TrainAndTest$activities[TrainAndTest$activities == 2] <- "Walking Upstairs"
TrainAndTest$activities[TrainAndTest$activities == 3] <- "Walking Downstairs"
TrainAndTest$activities[TrainAndTest$activities == 4] <- "Sitting"
TrainAndTest$activities[TrainAndTest$activities == 5] <- "Standing"
TrainAndTest$activities[TrainAndTest$activities == 6] <- "Laying"


#4.Appropriately label the data set with descriptive variable names.

#observe
names(TrainAndTest)

#clean the characters like '('  ')'   ','   '-'
cleanNames = gsub("\\(|\\)|-|,", "", names(TrainAndTest))
names(TrainAndTest) <- tolower(cleanNames)

#Change acronyms in colnames
names(TrainAndTest) <- gsub("Acc", "Accelerator", names(TrainAndTest))
names(TrainAndTest) <- gsub("Mag", "Magnitude", names(TrainAndTest))
names(TrainAndTest) <- gsub("Gyro", "Gyroscope", names(TrainAndTest))
names(TrainAndTest) <- gsub("^t", "time", names(TrainAndTest))
names(TrainAndTest) <- gsub("^f", "frequency", names(TrainAndTest))

#change participant names in all rows
TrainAndTest$participants <- as.character(TrainAndTest$participants)
TrainAndTest$participants[TrainAndTest$participants == 1] <- "Participant 1"
TrainAndTest$participants[TrainAndTest$participants == 2] <- "Participant 2"
TrainAndTest$participants[TrainAndTest$participants == 3] <- "Participant 3"
TrainAndTest$participants[TrainAndTest$participants == 4] <- "Participant 4"
TrainAndTest$participants[TrainAndTest$participants == 5] <- "Participant 5"
TrainAndTest$participants[TrainAndTest$participants == 6] <- "Participant 6"
TrainAndTest$participants[TrainAndTest$participants == 7] <- "Participant 7"
TrainAndTest$participants[TrainAndTest$participants == 8] <- "Participant 8"
TrainAndTest$participants[TrainAndTest$participants == 9] <- "Participant 9"
TrainAndTest$participants[TrainAndTest$participants == 10] <- "Participant 10"
TrainAndTest$participants[TrainAndTest$participants == 11] <- "Participant 11"
TrainAndTest$participants[TrainAndTest$participants == 12] <- "Participant 12"
TrainAndTest$participants[TrainAndTest$participants == 13] <- "Participant 13"
TrainAndTest$participants[TrainAndTest$participants == 14] <- "Participant 14"
TrainAndTest$participants[TrainAndTest$participants == 15] <- "Participant 15"
TrainAndTest$participants[TrainAndTest$participants == 16] <- "Participant 16"
TrainAndTest$participants[TrainAndTest$participants == 17] <- "Participant 17"
TrainAndTest$participants[TrainAndTest$participants == 18] <- "Participant 18"
TrainAndTest$participants[TrainAndTest$participants == 19] <- "Participant 19"
TrainAndTest$participants[TrainAndTest$participants == 20] <- "Participant 20"
TrainAndTest$participants[TrainAndTest$participants == 21] <- "Participant 21"
TrainAndTest$participants[TrainAndTest$participants == 22] <- "Participant 22"
TrainAndTest$participants[TrainAndTest$participants == 23] <- "Participant 23"
TrainAndTest$participants[TrainAndTest$participants == 24] <- "Participant 24"
TrainAndTest$participants[TrainAndTest$participants == 25] <- "Participant 25"
TrainAndTest$participants[TrainAndTest$participants == 26] <- "Participant 26"
TrainAndTest$participants[TrainAndTest$participants == 27] <- "Participant 27"
TrainAndTest$participants[TrainAndTest$participants == 28] <- "Participant 28"
TrainAndTest$participants[TrainAndTest$participants == 29] <- "Participant 29"
TrainAndTest$participants[TrainAndTest$participants == 30] <- "Participant 30"

colnames(TrainAndTest)

#5.From the data set in step 4, create a second, independent tidy data set with the average of each variable
#  for each activity and each subject(/participant).

tidydata <- TrainAndTest %>% 
                  group_by(participants, activities) %>% 
                            summarise_each(funs(mean(. , na.rm=TRUE)))

#write file to output
write.table(tidydata, file="tidy.txt", sep="\t", append=F)

