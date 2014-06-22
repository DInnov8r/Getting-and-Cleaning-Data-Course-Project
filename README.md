Getting and Cleaning Data Course Project
----------------------------------------

This project creates a tidy dataset from smartphone sensor data from The Machine Learning Repository at The University of California Irvine (UCI). The Human Activity Recognition database was built from the recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.

This project contains only one RScript file, [run_analysis.R](run_analysis.R).  The code in [run_analysis.R](run_analysis.R) depends upon the following R Packages:

- data.table
- reshape2

#### How to run the script to generate the tidy dataset

- Clone this repository
- Download and extract the [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- Change the current directory to the *"UCI HAR Dataset"* folder
- Run the Rscript: [run_analysis.R](run_analysis.R)
- The tidy dataset will be written to the current directory as *tidy_data.txt*
- Please refer to the [codebook](CodeBook.md) for more information

