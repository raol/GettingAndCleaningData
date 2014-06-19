if(!file.exists("./data")) {
    dir.create("data")
}

if(!file.exists("./data/activity.zip")) {

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL, destfile="./data/activity.zip")

}

if(!file.exists("./data/UCI HAR Dataset")) {
    unzip(zipfile="./data/activity.zip", exdir="data")
}

# read data
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
Subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
Subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#merge X, Y and subject test/train datasets
# to corresponging full datasets
X_full <- rbind(X_test, X_train)
Y_full <- rbind(Y_test, Y_train)
Subject_full <- rbind(Subject_test, Subject_train)

#assign column names to X dataset
colnames(X_full) <- features[, 2]

# find columns that match mean/std criteria
mean_std_columns <- c(grep("mean()", colnames(X_full)), grep("std()", colnames(X_full)))

#extract them to the new dataset
X_mean_std <- X_full[, mean_std_columns]

full_data <- cbind(Y_full, X_mean_std)

#assign corresponding activity name
full_data <- merge(activity_labels, full_data, by.x = 1, by.y = 1)

#add subject column to resulting data table
full_data <- cbind(Subject_full, full_data)

# drop redundand activity id column from full_data
# since we already have activity title column
full_data <- full_data[, -c(2)]

#and assign subject/activity column names
colnames(full_data)[1:2] <- c("SubjectId", "Activity")

# now let's create tidy dataset by applying melt function
# to treat all columns but SubjectId and Activity as variables

library(reshape2)

tidy_data <- melt(full_data, id=c("SubjectId", "Activity"))

# and get average values across all variables
tidy_data <- dcast(tidy_data, SubjectId + Activity ~ variable, mean)

