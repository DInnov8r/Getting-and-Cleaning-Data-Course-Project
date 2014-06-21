###
##
###

####
##
## The follwing R script loads data from a directory named "UCI HAR Dataset" downloaded from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## The script then:
##
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## Original data obtained from
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## @author Dan Murray (dan@murray5.net)
## @version 0.1 06/20/2014

## Check for required packages
if(!require("data.table")) {
  install.packages("data.table")
}

if(!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

####
## This function loads and combines data from three different file types given a base
## directory, dataset type, and mapping tables for human activities and both gyroscope
## and accelerometer features.
##
## @param: base directory path
## @param: base dataset type: "train" or "test"
## @param: data frame containing a mapping between activity ids and activity labels
## @param: data frame containing a mapping between feature ids and feature labels
## @return: a data frame that combines raw accelerometer and gyoscope data with
##          feature ids, feature labels, activity ids, and activity labels for a given
##          base directory path and dataset type
##
get_data <- function(path, type, activity_labels, features) {
  X_data <- read.table(paste(path, type, "/X_", type, ".txt", sep=""))
  y_data <- read.table(paste(path, type, "/y_", type, ".txt", sep=""))
  subject_data <- read.table(paste(path, type, "/subject_", type, ".txt", sep=""))
  
  names(X_data) <- features
  
  X_data <- X_data[,grepl("mean|std", features)]
  y_data[,2] <- activity_labels[y_data[,1],2]
  
  names(y_data) <- c("ActivityID", "ActivityLabel")
  names(subject_data) <- "Subject"
  
  data <- cbind(as.data.table(subject_data), y_data, X_data)
  
  data
}

####
## This function writes a tidy data set for a dataset containing acclerometer
## and gyroscope data.
##
## @param: The output file name.
##
write_tidy_data_file <- function(filename) {
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  features <- read.table("./UCI HAR Dataset/features.txt")[,2]
  
  test_data <- get_data("./UCI HAR Dataset/", "test", activity_labels, features)
  train_data <- get_data("./UCI HAR Dataset/", "train", activity_labels, features)
  
  data <- rbind(test_data, train_data)
  
  id_labels <- c("Subject", "ActivityID", "ActivityLabel")
  data_labels <- setdiff(colnames(data), id_labels)
  melt_data <- melt(data, id=id_labels, measure.vars=data_labels)
  
  tidy_data <- dcast(melt_data, Subject + ActivityID + ActivityLabel ~ variable, mean)
  
  write.table(tidy_data, file=filename, row.names = FALSE)
}

print(paste("Reading data from ", getwd(), "/UCI HAR Dataset",sep=""))
write_tidy_data_file("./tidy_data.txt")
print("Done.")
print(paste("Tidy data file written to ", getwd(), "/tidy_data.txt", sep=""))



