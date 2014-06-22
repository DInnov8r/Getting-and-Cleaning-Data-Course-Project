CodeBook for The Tidy Dataset
=============================

Data Source
-----------
The data for this project came from The Machine Learning Repository at The University of California Irvine (UCI).  The  Human Activity Recognition database was built from the recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.

Thirty participants within an age bracket of 19-48 years comprised the experimental group. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on their waist. UCI captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz from the gryoscope and accelerometer sensors. The dataset is randomly partitioned into two sets. 70% of the participant data comprise the training data and 30% comprise the test data.

The original dataset from UCI is available here:

- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The complete zip file with the data for this project is available here:

- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Feature Selection 
-----------------
According to the README and features.txt files in the original dataset:

*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.*

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).* 

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).*

The instructions for this project require the extraction of only measurements on the mean and standard deviation for each measurement.  As such, I extracted data having labels that included the words "mean" and "std".  This data was aggregated  for each participant and according to each of the six activities they performed.

The column headings for the resultant "tidy dataset" are:

* Subject
* ActivityID
* ActivityLabel
* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAcc-meanFreq()-X
* fBodyAcc-meanFreq()-Y
* fBodyAcc-meanFreq()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyAccJerk-meanFreq()-X
* fBodyAccJerk-meanFreq()-Y
* fBodyAccJerk-meanFreq()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyGyro-meanFreq()-X
* fBodyGyro-meanFreq()-Y
* fBodyGyro-meanFreq()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyAccMag-meanFreq()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyAccJerkMag-meanFreq()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroMag-meanFreq()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
* fBodyBodyGyroJerkMag-meanFreq()

Data Transformation
-------------------

The algorithms in run_analysis.R perform the following steps to transform and ultimately write the final tidy dataset:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.


First, the mapping between activity labels, such as *WALKING* and *SITTING*, and the activity ids used in the participant datasets us read from the file *./UCI HAR Dataset/activity\_labels.txt* using read.table into an R data frame called *activity\_labels*.

Second, the mapping between feature labels, such as *fBodyBodyAccJerkMag-meanFreq()*, and the ids used in the participant datasets is read from the file *./UCI HAR Dataset/features.txt* using read.table into an R data frame called *features*.

Next, test activity data is read from y\_test.txt into an R data frame called *y\_data*. Each row of this dataset contains a single number that corresponds to the activity performed for the corresponding row of the file *./UCI HAR Dataset/X_test.txt*.

Next, column headings for each feature are added to the data frame *X\_data*.

Then, test data is read from the file *./UCI HAR Dataset/X\_test.txt* into an R data frame.  Each row of this file represents a vector of 561 features.  

Next, subject ids are read from *./UCI HAR Dataset/subject\_test.txt* into an R data frame called *subject\_data*.  Each row of this dataset contains a single number that corresponds to the subject, or participant, from whom the data was collected.

Then, a column containing the textual activity label corresponding to the activity id in each row in the data frame y_data.

Next, column headings *ActivityID* and *ActivityLabel* are added to the data frame *y\_data*.

Next, a column heading *SubjectID* is added to the data frame *subject\_data*.

Then, the data frames *y\_data*, *subject\_data*, and *X\_data*, are combined column-wise using the R function *cbind*.

The resulant data frame is called *test_data*.

Next, a similar data frame called *train_data* is created from the following files by repeating the previous steps.

- X_train.txt
- y_train.txt
- subject_train.txt

The data frames *test_data* and *train_data* are combined row-wise into a data frame called *data* using the R function *rbind*.

Next, the R function *melt* from the *rshape2* package is used to convert the columnar data frame *data* into a row-oriented data frame with each row containing a SubjectID, ActivityID, ActivityLabel, FeatureLabel, and numerical value.

The *mean* operator of the function *dcast* is then used to aggregate the numerical values in the data frame *data*.  This computes the mean of each sensor reading for each participant by activity.

The resultant dataset is written to file using the *write.table* function with the row names omitted.
