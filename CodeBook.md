# Data, Variables and Transformations
        
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
        '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
        
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
        
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete data set has 561 Features Variables and the Activity variable and the Subject Variable.

As Explained in the README.md file Data has been transformed, resulting 2 tidy datasets:

* TidyDataSet has  10299 obs. 

* AggrTidyDataSet has 180 obs. which each row corresponds to one activity and one subject. Mean was the function used for agreggation.  

Each data set has the following 68 variables:

* ActivityName
* Subject
* FrequencyBodyAccelerometerJerkMagnitude-MEAN()
* FrequencyBodyAccelerometerJerkMagnitude-SD()
* FrequencyBodyAccelerometerJerk-MEAN()-X
* FrequencyBodyAccelerometerJerk-MEAN()-Y
* FrequencyBodyAccelerometerJerk-MEAN()-Z
* FrequencyBodyAccelerometerJerk-SD()-X
* FrequencyBodyAccelerometerJerk-SD()-Y
* FrequencyBodyAccelerometerJerk-SD()-Z
* FrequencyBodyAccelerometerMagnitude-MEAN()
* FrequencyBodyAccelerometerMagnitude-SD()
* FrequencyBodyAccelerometer-MEAN()-X
* FrequencyBodyAccelerometer-MEAN()-Y
* FrequencyBodyAccelerometer-MEAN()-Z
* FrequencyBodyAccelerometer-SD()-X
* FrequencyBodyAccelerometer-SD()-Y
* FrequencyBodyAccelerometer-SD()-Z
* FrequencyBodyGyroscopeJerkMagnitude-MEAN()
* FrequencyBodyGyroscopeJerkMagnitude-SD()
* FrequencyBodyGyroscopeMagnitude-MEAN()
* FrequencyBodyGyroscopeMagnitude-SD()
* FrequencyBodyGyroscope-MEAN()-X
* FrequencyBodyGyroscope-MEAN()-Y
* FrequencyBodyGyroscope-MEAN()-Z
* FrequencyBodyGyroscope-SD()-X
* FrequencyBodyGyroscope-SD()-Y
* FrequencyBodyGyroscope-SD()-Z
* TimeBodyAccelerometerJerkMagnitude-MEAN()
* TimeBodyAccelerometerJerkMagnitude-SD()
* TimeBodyAccelerometerJerk-MEAN()-X
* TimeBodyAccelerometerJerk-MEAN()-Y
* TimeBodyAccelerometerJerk-MEAN()-Z
* TimeBodyAccelerometerJerk-SD()-X
* TimeBodyAccelerometerJerk-SD()-Y
* TimeBodyAccelerometerJerk-SD()-Z
* TimeBodyAccelerometerMagnitude-MEAN()
* TimeBodyAccelerometerMagnitude-SD()
* TimeBodyAccelerometer-MEAN()-X
* TimeBodyAccelerometer-MEAN()-Y
* TimeBodyAccelerometer-MEAN()-Z
* TimeBodyAccelerometer-SD()-X
* TimeBodyAccelerometer-SD()-Y
* TimeBodyAccelerometer-SD()-Z
* TimeBodyGyroscopeJerkMagnitude-MEAN()
* TimeBodyGyroscopeJerkMagnitude-SD()
* TimeBodyGyroscopeJerk-MEAN()-X
* TimeBodyGyroscopeJerk-MEAN()-Y
* TimeBodyGyroscopeJerk-MEAN()-Z
* TimeBodyGyroscopeJerk-SD()-X
* TimeBodyGyroscopeJerk-SD()-Y
* TimeBodyGyroscopeJerk-SD()-Z
* TimeBodyGyroscopeMagnitude-MEAN()
* TimeBodyGyroscopeMagnitude-SD()
* TimeBodyGyroscope-MEAN()-X
* TimeBodyGyroscope-MEAN()-Y
* TimeBodyGyroscope-MEAN()-Z
* TimeBodyGyroscope-SD()-X
* TimeBodyGyroscope-SD()-Y
* TimeBodyGyroscope-SD()-Z
* TimeGravityAccelerometerMagnitude-MEAN()
* TimeGravityAccelerometerMagnitude-SD()
* TimeGravityAccelerometer-MEAN()-X
* TimeGravityAccelerometer-MEAN()-Y
* TimeGravityAccelerometer-MEAN()-Z
* TimeGravityAccelerometer-SD()-X
* TimeGravityAccelerometer-SD()-Y
* TimeGravityAccelerometer-SD()-Z


