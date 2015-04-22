# datacleaning
This is code book for the course project for "Getting and Cleaning Data".


## Data File
hcrmeanresult.csv

## Data Origin
[Human Activity Recognition Using Smartphones Data Set] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

## Data Variables
There are 81 data columns in this data set:
* Subject: An identifier of the subject who carried out the experiment
* Activity: the activity performed by the subject
* Averages of 79 mean and standdard deviation measurements.  The measurement names consist of the following words:
  * time: time domain signal
  * frequency: frequency domain signal
  * BodyAcceleration: Body acceleration signal from accelerometer
  * GravityAcceleration: Gravity acceleration signal from accelerometer 
  * BodyGyroscope: Body angular velocity signal from gyroscope
  * GravityGyroscope: Gravity angular velocity signal from gyroscope
  * JerkSignal: Jerk signal obtained from from acceleration and angular velocity 
  * ...X/Y/Z: the three-dimensional signals
  * Magnitue: magnitude of three-dimensional signals calculated using the Euclidean norm
  * mean: mean value
  * std: standard deviation


## Data Transformation
* Combine subjects, activities and measurements in the training data set. Use descriptive activity names.
* Combine subjects, activities and measurements in the test data set. Use descriptive activity names.
* Merge the training and the test data sets into one data set.
* Extract subjects, activities, and only the mean and standard deviation measurements
* Label the measurements with descriptive variable names.
  * t -> time
  * f -> frequency
  * Acc -> Acceleration
  * Gyro -> Gyroscope
  * Jerk -> JerkSignal
  * Mag -> Magnitude
* Calculate the averages of the measurements for each activity and each subject
* Save the averages in hcrmeanresult.csv