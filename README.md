# Getting and Cleaning Data Week 3 Project

## Goal

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 

## Requirements

You will be required to submit: 
        1) a tidy data set as described below
        2) a link to a Github repository with your script for performing the analysis, and 
        3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
        4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

## Dataset

The data from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project:
     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## R Script 

You should create one R script called run_analysis.R that does the following. 
1)  Merges the training and the test sets to create one data set.
2)  Extracts only the measurements on the mean and standard deviation for each measurement. 
3)  Uses descriptive activity names to name the activities in the data set
4)  Appropriately labels the data set with descriptive variable names. 
5)  From the dataset in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## run_analysis.R does:

### I - Downloads the zipfile with dataset and puts it in a folder created in the workin directory.

It creates a data folder in the WD where its going to put the zipfile.

### II - Unzip the file UCI_HAR_Dataset.zip in the data folder

For these projects we are not using the files in Inertial Signals folders. So the files requieres are:
* X_train.txt and X_test.txt consisting of training and testing Features variables.
* Y_train.txt and Y_test.txt consisting of training and testing Activity Variables.
* subject_train.txt and subject_test.txt consisting of training and testing subject Variables.
So Features, Activity and Subject will be the descriptive variable names for data in data frame.

### III - Read data from files and save eacha of the 6 files into a variable

path <- getwd()
pathIn <- file.path(path,"data/UCI HAR Dataset")
pathIn

#### Activity files

ActivityTrain <- data.table(read.table(file.path(pathIn, "train", "Y_train.txt"),header = FALSE))
ActivityTest  <- data.table(read.table(file.path(pathIn, "test" , "Y_test.txt" ),header = FALSE))

#### Subject files

SubjectTrain <- data.table(read.table(file.path(pathIn, "train", "subject_train.txt"),header = FALSE))
SubjectTest  <- data.table(read.table(file.path(pathIn, "test" , "subject_test.txt"),header = FALSE))

#### Features files

FeaturesTrain <- data.table(read.table(file.path(pathIn, "train", "X_train.txt"),header = FALSE))
FeaturesTest  <- data.table(read.table(file.path(pathIn, "test" , "X_test.txt" ),header = FALSE))

### IV - Merging Training and Testing into one Dataset

#### row bind concatenates the data tables by rows and set names to variables

Activity<- rbind(ActivityTrain, ActivityTest)
Subject <- rbind(SubjectTrain, SubjectTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

names(Activity) <- c("Activity")
names(Subject)<-c("Subject")
FeaturesNames <- data.table(read.table(file.path(pathIn, "features.txt"),stringsAsFactors=FALSE))
names(Features)<- FeaturesNames$V2

#### Column bind: Features, Subject and Activity. The output is Data which is the complete Dataset with 10299 obs. of 563 variables.

SubjectActivity <- cbind(Subject, Activity)
Data <- cbind(Features, SubjectActivity)

### V - Extracts only the measurements on the mean and standard deviation for each measurement

#### Im going to keep only the mean and std variables. The output is SubsetData with 10299 obs. of 68 variables.

SubsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
SelectedFeatures<-c(SubsetFeaturesNames, "Subject", "Activity" )
SubsetData<-subset(Data,select=SelectedFeatures)

### V - Uses descriptive activity names to name the activities in the data set

#### It reads the activities names. Merge the activities into the SubsetData. The Output is TidyDataSet with 10299 obs. of 68 variables.

ActivityLabels <- read.table(file.path(pathIn, "activity_labels.txt"),header = FALSE)
setnames(ActivityLabels, names(ActivityLabels), c("Activity","ActivityName"))
SubsetData2 <- merge(ActivityLabels, SubsetData , by="Activity", all.x=TRUE)
SubsetData2$ActivityName <- as.character(SubsetData2$ActivityName)
TidyDataSet  <- SubsetData2[-1]

### VI - Appropriately labels the data set with descriptive variable names.

# Im making these replacements in the variables names:

names(TidyDataSet)<-gsub("mean()", "MEAN", names(TidyDataSet))
names(TidyDataSet)<-gsub("std()", "SD", names(TidyDataSet))
names(TidyDataSet)<-gsub("Acc", "Accelerometer", names(TidyDataSet))
names(TidyDataSet)<-gsub("Gyro", "Gyroscope", names(TidyDataSet))
names(TidyDataSet)<-gsub("Mag", "Magnitude", names(TidyDataSet))
names(TidyDataSet)<-gsub("BodyBody", "Body", names(TidyDataSet))
names(TidyDataSet)<-gsub("^t", "Time", names(TidyDataSet))
names(TidyDataSet)<-gsub("^f", "Frequency", names(TidyDataSet))

### VII - Creates a second independent tidy data set with the average of each variable for each activity and each subject. Output is AggrTidyDataSet with 180 obs. of 68 variables.

AggrTidyDataSet<- aggregate(. ~ ActivityName - Subject, data = TidyDataSet, mean) 

### VII - Writes downs the AggrTidyDataset in file "AggrTidyDataSet.txt" in the WD, without the row names.

write.table(AggrTidyDataSet, file = "AggrTidyDataSet.txt",row.name=FALSE)
