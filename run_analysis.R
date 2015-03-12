#assuming the appropriate files are in the working directory

# read in the test and train subject dataset into a single dataframe
subject <- rbind(read.table("subject_test.txt"),read.table("subject_train.txt"))
# read in the test and train y data set into a single dataframe
y <- rbind(read.table("y_test.txt"),read.table("y_train.txt"))
# read in the test and train x data set into a single dataframe
x <- rbind(read.table("x_test.txt"),read.table("x_train.txt"))
# read in the test features data set
features <- read.table("features.txt")
# read in the labels for the activities
activity_labels <- read.table("activity_labels.txt")
# merge the activity lables onto the y data set matching the label name to the appropriate value
# (uses join from the plyr package)
library(plyr)
y <- join(y,activity_labels, by = "V1")
# extract the column names column from features as a vector
features_v <- as.vector(features$V2)
#rename the columns in x_test data.fram to the vector
colnames(x) <- features_v
# extract only the mean() and std() columns
data <- x[,c(colnames(x)[grep("mean\\(",colnames(x))],colnames(x)[grep("std\\(",colnames(x))])]
# add the activity column
data <- cbind(y$V2,data)
# rename the activity column
names(data)[names(data)=="y$V2"] <- "activity"
# add the subject column
data <- cbind(subject,data)
# rename the subject column
names(data)[names(data)=="V1"] <- "subject"
# make separate data frame with averages of all variables grouped by activity and subject
data_agg <- aggregate(data[,3:ncol(data)],by=list(subject = data$subject, activity = data$activity),mean)
# clean up the environment leaving only the tidy data and aggregated data
rm(list = c("activity_labels", "features", "subject", "x", "y", "features_v","data"))

