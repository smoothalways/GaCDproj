
Coursera - Getting and Cleaning Data Project, March 2015.


Raw Data

The data are from experiments that were conducted with a group of 30 volunteers who performed the 6 activities while wearing a device to record movements via an accelerometer and gyroscope.  3 axis linear acceleration and angular velocity data were collected.  Signals from the devices were processed with the use of filters and passed thru formulas to provide the raw data.  The data was partitioned randomly into two sets, test and train.

A complete description of the data can be found at: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data can be obtained from the the following zip: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The raw data includes the following files which are used in this processing:

subject_test.txt - the listing of id's for the subjects selected to the test set.
X_test.txt - collected and processed data points for the test subject set.
y_test.txt - labels for the rows of data points for the test subject set.
subject_train.txt - the listing of id's for the subjects selected to the train set.
X_train.txt - collected and processed data points for the train subject set.
y_train.txt - labels for the rows of data points for the train subject set.
activity_labels.txt - lookup table of the 6 activities.
features.txt - column names for the X datasets.


The goal of the project is to produce a tidy dataset from the raw data, combining it into a single data.frame and including descriptive activity names and column names.

The data are processed with the following script which is in the run_analysis.R file:


#assuming the appropriate .txt files are in the working directory


# read in the test and train subject dataset into a single dataframe "subject"

	subject <- rbind(read.table("subject_test.txt"),read.table("subject_train.txt"))


# read in the test and train y data set into a single dataframe "y"

	y <- rbind(read.table("y_test.txt"),read.table("y_train.txt"))


# read in the test and train x data set into a single dataframe "x"

	x <- rbind(read.table("x_test.txt"),read.table("x_train.txt"))


# read in the test features data set "features"

	features <- read.table("features.txt")


# read in the labels for the activities "activity_labels"

	activity_labels <- read.table("activity_labels.txt")


# merge the activity lables onto the y data set matching the label name to the appropriate value
# (uses join from the plyr package to maintain the order of the data)

	library(plyr)

	y <- join(y,activity_labels, by = "V1")


# extract the column names column from features as a vector "features_v"

	features_v <- as.vector(features$V2)


#rename the columns in x_test data.frame to the vector values

	colnames(x) <- features_v


# extract only the mean() and std() columns to data.frame "data"

	data <- x[,c(colnames(x)[grep("mean\\(",colnames(x))],colnames(x)[grep("std\\(",colnames(x))])]


# add and rename the activity column

	data <- cbind(y$V2,data)
	names(data)[names(data)=="y$V2"] <- "activity"


# add and rename subject column

	data <- cbind(subject,data)
	names(data)[names(data)=="V1"] <- "subject"


# make separate data frame "data_agg" with averages of all variables grouped by activity and subject

	data_agg <- aggregate(data[,3:ncol(data)],by=list(subject = data$subject, activity = data$activity),mean)


# clean up the environment leaving only the tidy aggregated data frame

	rm(list = c("activity_labels", "features", "subject", "x", "y", "features_v","data"))

If you would like to examine any of the various working data frames, comment out the rm() instruction and rerun.






License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 - as modified for a project within the Coursera Getting and Cleaning Data course, Ron Burton 2015.

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
Ron Burton. March 2015