The summary.txt file contains average values of for features calculated from accelerometer and gyrometer data for test 
persons doing certain activities.

Each row in the file contains results for given person and activity.

## Columns

1 - subject: Numeric ID of the person executing the activities

2 - activity: String describing the activity. Cam be one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

3-68 Feature values 

Each of the columns contains average of all measurements of the feature for the given person and activity. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration (tBodyAcc and tGravityAcc) and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

From these signals, mean and standard deviation were calculated, and mean of these for each subject and activity is reported.

Naming of the feature columns is like this

    <feature name>_mean|std{_<axis>}

Feature name is one of  (see above for explanation) _tBodyAcc_, _tGravityAcc_, _tBodyAccJerk_, _tBodyGyro_, _tBodyGyroJerk_, _tBodyAccMag_, _tGravityAccMag_, _tBodyAccJerkMag_, _tBodyGyroMag_, _tBodyGyroJerkMag_, _fBodyAcc_, _fBodyAccJerk_. _fBodyGyro_, _fBodyAccMag_, _fBodyAccJerkMag_, _fBodyGyroMag_ or _fBodyGyroJerkMag_.

_Mean_ or _std_ inidicate the function applied to the signals. If the resulting value is a vector, axis inidcates the component stored in the column.

If the feature is a vector, _axis_ inidicates the component stored in this column.
