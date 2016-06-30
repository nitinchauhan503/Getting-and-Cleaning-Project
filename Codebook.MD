#Introduction
The script run_analysis.R performs the 5 steps described in the course project's definition.

First, we merged all the similar using the rbind() function on x_train, x_test and y_train, y_test, and subject_train and subject_test etc. 
Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, using data from features.txt.
Then we merged all the data using cbind() to create a new data set "all_data" using x_data, y_data and subject_data 
As activity data is addressed with values 1:6, we took the activity names and IDs from activity_labels.txt and then substituted it in the dataset.
Finally, we generated a new dataset using ddply() with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called avg_data.txt, and uploaded to this repository.

#Variables
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in meanstd_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans().
