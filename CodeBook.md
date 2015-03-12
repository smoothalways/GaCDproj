Code Book - Coursera - Getting and Cleaning Data Project, March 2015.

The run_analysis.R script produces a number of data_frames from the raw data while processing.  They are working data frames and are deleted at the last step, if you are interested in viewing those data frames, comment out the final rm() instruction and rerun.

The primary working data frame in this process is the "data" one which is assembled thru successive building, cleaning and forming.  It contains 68 columns.  The first two are descriptive and the rest of them are mean or stddev of several measurements.

activity is a description of the measured activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

subject is the id of the subject having been measured.

The balance of the columns are measurements with column names in the following format

(t or f) representing time or frequency domain
(description of the measurement taken) 
dash
(mean() or std()) representing mean or standard deviation of the measurements
dash
(X, Y or Z) representing the X, y or Z axis measurement

Example - tBodyAcc-mean()-X

	t = time domain
	BodyAcc = measurement, acceleration of the body
	dash
	mean() = mean of all of the raw measurements
	dash
	X = X axis measurement


The final data frame, "data_agg", is a summary of the "data" data frame giving  the mean of each variable in columns 3:68 grouped by subject (col 1) and activity (col2).
