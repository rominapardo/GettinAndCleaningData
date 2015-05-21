######################################## Goal and Purpose ########################################
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 

######################################### Requirements ###########################################
# You will be required to submit: 
#         1) a tidy data set as described below
#         2) a link to a Github repository with your script for performing the analysis, and 
#         3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
#         4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 


##################################### Dataset ##################################################
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article.
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
# 
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
# A full description is available at the site where the data was obtained:
#      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

################################## R Script ##################################################
# You should create one R script called run_analysis.R that does the following. 
# 1)  Merges the training and the test sets to create one data set.
# 2)  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3)  Uses descriptive activity names to name the activities in the data set
# 4)  Appropriately labels the data set with descriptive variable names. 
# 5)  From the dataset in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



# I - Download the zipfile with dataset and put it in the project folder 
setwd("E:\\03_GettingAndCleaningData\\project")
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/UCI_HAR_Dataset.zip")

# II - Unzip the file UCI_HAR_Dataset.zip in the data folder
unzip(zipfile="./data/UCI_HAR_Dataset.zip",exdir="./data")

# check the content of the folder data
list.files("./data")
#[1] "UCI HAR Dataset"     "UCI_HAR_Dataset.zip"

# check the unzipped files
list.files("./data/UCI HAR Dataset")
# [1] "activity_labels.txt" "features.txt"        "features_info.txt"   "README.txt"          "test"                "train" 

# Inside UCI HAR Dataset there are 4 txt files and 2 folders: test and train. Lets make the list files recursive so we can see the content od these folders:
list.files("./data/UCI HAR Dataset", recursive=TRUE)
# [1] "activity_labels.txt"                          "features.txt"                                 "features_info.txt"                           
# [4] "README.txt"                                   "test/Inertial Signals/body_acc_x_test.txt"    "test/Inertial Signals/body_acc_y_test.txt"   
# [7] "test/Inertial Signals/body_acc_z_test.txt"    "test/Inertial Signals/body_gyro_x_test.txt"   "test/Inertial Signals/body_gyro_y_test.txt"  
# [10] "test/Inertial Signals/body_gyro_z_test.txt"   "test/Inertial Signals/total_acc_x_test.txt"   "test/Inertial Signals/total_acc_y_test.txt"  
# [13] "test/Inertial Signals/total_acc_z_test.txt"   "test/subject_test.txt"                        "test/X_test.txt"                             
# [16] "test/y_test.txt"                              "train/Inertial Signals/body_acc_x_train.txt"  "train/Inertial Signals/body_acc_y_train.txt" 
# [19] "train/Inertial Signals/body_acc_z_train.txt"  "train/Inertial Signals/body_gyro_x_train.txt" "train/Inertial Signals/body_gyro_y_train.txt"
# [22] "train/Inertial Signals/body_gyro_z_train.txt" "train/Inertial Signals/total_acc_x_train.txt" "train/Inertial Signals/total_acc_y_train.txt"
# [25] "train/Inertial Signals/total_acc_z_train.txt" "train/subject_train.txt"                      "train/X_train.txt"                           
# [28] "train/y_train.txt"    

# Full description of the dataset in README.txt and features.txt

# For these projects we are not using the files in Inertial Signals folders. So the files requieres are:
# * X_train.txt and X_test.txt consisting of training and testing Features variables .
# * Y_train.txt and Y_test.txt consisting of training and testing Activity Variables.
# * subject_train.txt and subject_test.txt consisting of training and testing subject Variables.
# So Features, Activity and Subject will be the descriptive variable names for data in data frame.


# III - Read data from files and save into the variables

path <- getwd()
pathIn <- file.path(path,"data/UCI HAR Dataset")
pathIn

library(data.table)

# Activity files

ActivityTrain <- data.table(read.table(file.path(pathIn, "train", "Y_train.txt"),header = FALSE))
ActivityTest  <- data.table(read.table(file.path(pathIn, "test" , "Y_test.txt" ),header = FALSE))

# Subject files

SubjectTrain <- data.table(read.table(file.path(pathIn, "train", "subject_train.txt"),header = FALSE))
SubjectTest  <- data.table(read.table(file.path(pathIn, "test" , "subject_test.txt"),header = FALSE))

# Features files

FeaturesTrain <- data.table(read.table(file.path(pathIn, "train", "X_train.txt"),header = FALSE))
FeaturesTest  <- data.table(read.table(file.path(pathIn, "test" , "X_test.txt" ),header = FALSE))

# view structure

# str(ActivityTrain)
# str(ActivityTest)
# str(SubjectTrain)
# str(SubjectTest)
# str(FeaturesTrain)
# str(FeaturesTest)

# IV - Merging Training and Testing into one dataset

# row bind concatenates the data tables by rows

Activity<- rbind(ActivityTrain, ActivityTest)
Subject <- rbind(SubjectTrain, SubjectTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

# set names to variables

# names() shows a warning but works!

names(Activity) <- c("Activity")
names(Subject)<-c("Subject")

FeaturesNames <- data.table(read.table(file.path(pathIn, "features.txt"),stringsAsFactors=FALSE))

names(Features)<- FeaturesNames$V2

# view structure

# str(Features)

# Column bind: Features, Subject and Activity. 

SubjectActivity <- cbind(Subject, Activity)
Data <- cbind(Features, SubjectActivity)
# Data has all variables Featrures, Subject, Activity with all rows from training and testing. Its the complete dataset.

# View structure
# head(str(Data),10)
## Classes 'data.table' and 'data.frame':        10299 obs. of  563 variables:


# V - Extracts only the measurements on the mean and standard deviation for each measurement

# Im going to keep only the mean and std variables
# Im going to subset the name of the variables required. From FeaturesNames I need all rows that has either mean or std in V2

SubsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
class(SubsetFeaturesNames)
# Once Ive defined the selected names if Features, Im going to subset the complete dataset named Data.

SelectedFeatures<-c(SubsetFeaturesNames, "Subject", "Activity" )
SubsetData<-subset(Data,select=SelectedFeatures)

# View Data structure
#str(SubsetData)
#10299 obs. of 68 variables

# V - Uses descriptive activity names to name the activities in the data set

##enter name of activity into dataTable

ActivityLabels <- read.table(file.path(pathIn, "activity_labels.txt"),header = FALSE)
setnames(ActivityLabels, names(ActivityLabels), c("Activity","ActivityName"))

SubsetData2 <- merge(ActivityLabels, SubsetData , by="Activity", all.x=TRUE)

# View Data structure
# str(SubsetData2)
SubsetData2$ActivityName <- as.character(SubsetData2$ActivityName)
TidyDataSet  <- SubsetData2[-1]



# VI - Appropriately labels the data set with descriptive variable names.

# According to features_info.txt:
# prefix 't' to denote time       
# accelerometer
# gyroscope 
# -XYZ 3-axial raw signals 
# acceleration signal was separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
# Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
# Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
# A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. domain signals). 
# The 'f' to indicate frequency

# Im making these replacements in the variables names:

names(TidyDataSet)<-gsub("mean()", "MEAN", names(TidyDataSet))
names(TidyDataSet)<-gsub("std()", "SD", names(TidyDataSet))
names(TidyDataSet)<-gsub("Acc", "Accelerometer", names(TidyDataSet))
names(TidyDataSet)<-gsub("Gyro", "Gyroscope", names(TidyDataSet))
names(TidyDataSet)<-gsub("Mag", "Magnitude", names(TidyDataSet))
names(TidyDataSet)<-gsub("BodyBody", "Body", names(TidyDataSet))
names(TidyDataSet)<-gsub("^t", "Time", names(TidyDataSet))
names(TidyDataSet)<-gsub("^f", "Frequency", names(TidyDataSet))

# head(str(TidyDataSet),10)

## VII - Creates a second independent tidy data set with the average of each variable for each activity and each subject.

AggrTidyDataSet<- aggregate(. ~ ActivityName - Subject, data = TidyDataSet, mean) 

# head(str(AggrTidyDataSet),10)

# 'data.frame':        180 obs. of  68 variables:
# $ ActivityName                                  : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
# $ Subject                                       : int  1 1 1 1 1 1 2 2 2 2 ...
# $ TimeBodyAccelerometer-MEAN()-X                : num  0.222 0.261 0.279 0.277 0.289 ...
# $ TimeBodyAccelerometer-MEAN()-Y                : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
# $ TimeBodyAccelerometer-MEAN()-Z                : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
# $ TimeBodyAccelerometer-SD()-X                  : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
# $ TimeBodyAccelerometer-SD()-Y                  : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
# $ TimeBodyAccelerometer-SD()-Z                  : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
# $ TimeGravityAccelerometer-MEAN()-X             : num  -0.249 0.832 0.943 0.935 0.932 ...
# $ TimeGravityAccelerometer-MEAN()-Y             : num  0.706 0.204 -0.273 -0.282 -0.267 ...
# $ TimeGravityAccelerometer-MEAN()-Z             : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
# $ TimeGravityAccelerometer-SD()-X               : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
# $ TimeGravityAccelerometer-SD()-Y               : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
# $ TimeGravityAccelerometer-SD()-Z               : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
# $ TimeBodyAccelerometerJerk-MEAN()-X            : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
# $ TimeBodyAccelerometerJerk-MEAN()-Y            : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
# $ TimeBodyAccelerometerJerk-MEAN()-Z            : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
# $ TimeBodyAccelerometerJerk-SD()-X              : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
# $ TimeBodyAccelerometerJerk-SD()-Y              : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
# $ TimeBodyAccelerometerJerk-SD()-Z              : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
# $ TimeBodyGyroscope-MEAN()-X                    : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
# $ TimeBodyGyroscope-MEAN()-Y                    : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
# $ TimeBodyGyroscope-MEAN()-Z                    : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
# $ TimeBodyGyroscope-SD()-X                      : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
# $ TimeBodyGyroscope-SD()-Y                      : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
# $ TimeBodyGyroscope-SD()-Z                      : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
# $ TimeBodyGyroscopeJerk-MEAN()-X                : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
# $ TimeBodyGyroscopeJerk-MEAN()-Y                : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
# $ TimeBodyGyroscopeJerk-MEAN()-Z                : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
# $ TimeBodyGyroscopeJerk-SD()-X                  : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
# $ TimeBodyGyroscopeJerk-SD()-Y                  : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
# $ TimeBodyGyroscopeJerk-SD()-Z                  : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
# $ TimeBodyAccelerometerMagnitude-MEAN()         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
# $ TimeBodyAccelerometerMagnitude-SD()           : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
# $ TimeGravityAccelerometerMagnitude-MEAN()      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
# $ TimeGravityAccelerometerMagnitude-SD()        : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
# $ TimeBodyAccelerometerJerkMagnitude-MEAN()     : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
# $ TimeBodyAccelerometerJerkMagnitude-SD()       : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
# $ TimeBodyGyroscopeMagnitude-MEAN()             : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
# $ TimeBodyGyroscopeMagnitude-SD()               : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
# $ TimeBodyGyroscopeJerkMagnitude-MEAN()         : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
# $ TimeBodyGyroscopeJerkMagnitude-SD()           : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
# $ FrequencyBodyAccelerometer-MEAN()-X           : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
# $ FrequencyBodyAccelerometer-MEAN()-Y           : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
# $ FrequencyBodyAccelerometer-MEAN()-Z           : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
# $ FrequencyBodyAccelerometer-SD()-X             : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
# $ FrequencyBodyAccelerometer-SD()-Y             : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
# $ FrequencyBodyAccelerometer-SD()-Z             : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
# $ FrequencyBodyAccelerometerJerk-MEAN()-X       : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
# $ FrequencyBodyAccelerometerJerk-MEAN()-Y       : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
# $ FrequencyBodyAccelerometerJerk-MEAN()-Z       : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
# $ FrequencyBodyAccelerometerJerk-SD()-X         : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
# $ FrequencyBodyAccelerometerJerk-SD()-Y         : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
# $ FrequencyBodyAccelerometerJerk-SD()-Z         : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
# $ FrequencyBodyGyroscope-MEAN()-X               : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
# $ FrequencyBodyGyroscope-MEAN()-Y               : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
# $ FrequencyBodyGyroscope-MEAN()-Z               : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
# $ FrequencyBodyGyroscope-SD()-X                 : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
# $ FrequencyBodyGyroscope-SD()-Y                 : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
# $ FrequencyBodyGyroscope-SD()-Z                 : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
# $ FrequencyBodyAccelerometerMagnitude-MEAN()    : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
# $ FrequencyBodyAccelerometerMagnitude-SD()      : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
# $ FrequencyBodyAccelerometerJerkMagnitude-MEAN(): num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
# $ FrequencyBodyAccelerometerJerkMagnitude-SD()  : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
# $ FrequencyBodyGyroscopeMagnitude-MEAN()        : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
# $ FrequencyBodyGyroscopeMagnitude-SD()          : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
# $ FrequencyBodyGyroscopeJerkMagnitude-MEAN()    : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
# $ FrequencyBodyGyroscopeJerkMagnitude-SD()      : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...

write.table(AggrTidyDataSet, file = "AggrTidyDataSet.txt",row.name=FALSE)

