##Loading library
library(dplyr)
library(reshape2)
library(plyr)


##Setting the downloading the zip file
filename <- "get_dataset"

## Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename, method="curl")
    unzip(filename) 
}  

##Getting the train and test data set for x,y and subject   
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")


##### Step 1: Merges the training and the test sets to create one data set.
###########################################################################

# create 'x' data set using train and test
x_data <- rbind(x_train, x_test)

# create 'y' data set using train and test
y_data <- rbind(y_train, y_test)

# create 'subject' data set usign train and test
subject_data <- rbind(subject_train, subject_test)


##### Step 2: Extracts only the measurements on the mean and SD for each measurement
###########################################################################

# read features file
features <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]



##### Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

##Read activity labels data
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name for the Y data set
names(y_data) <- "Activity"

##### Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name for subject data set
names(subject_data) <- "Subject"


# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# change name of
names(all_data) <- gsub("-mean\\(\\)", "Mean", names(all_data))
names(all_data) <- gsub("-std\\(\\)", "STD", names(all_data))

##### Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

## Getting mean of subject and activity for each subject and each activity
avg_data <- ddply(all_data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(avg_data, "UCI HAR Dataset/avg.txt", row.name=FALSE)
