# Load the package
library(dplyr)
# Download the file
path <- getwd()
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, file.path(path,"datafiles.zip"))
unzip(zipfile = "datafiles.zip")
# Access data frame
features <- read.table(file.path(path,"UCI HAR Dataset/features.txt"),col.names = c("index","featureNames"))
activitylabels <- read.table(file.path(path,"UCI HAR Dataset/activity_labels.txt"),col.names = c("n","activities"))
subject_test <- read.table(file.path(path,"UCI HAR Dataset/test/subject_test.txt"),col.names = "subject")
subject_train <- read.table(file.path(path,"UCI HAR Dataset/train/subject_train.txt"),col.names = "subject")
x_test <- read.table(file.path(path,"UCI HAR Dataset/test/X_test.txt"),col.names = features$functions)
y_test <- read.table(file.path(path,"UCI HAR Dataset/test/y_test.txt"),col.names = "n")
x_train <-read.table(file.path(path,"UCI HAR Dataset/train/X_train.txt"),col.names = features$functions)
y_train <- read.table(file.path(path,"UCI HAR Dataset/train/y_train.txt"),col.names = "n")
# Merge all the test and training sets
X <- rbind(x_test,x_train)
Y <- rbind(y_test,y_train)
Subject <- rbind(subject_test,subject_train)
mergedata <- cbind(X,Y,Subject)
# Extract only the mean and the standard deviation
TidyData <- mergedata %>% select(subject,n, contains("mean"),contains("std"))
# Name the activities in the data set
TidyData$n <- activitylabels[TidyData$n,2]
# Label data with descriptive names
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
# Final step
FinalData <- TidyData %>%
  group_by(subject, activities) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)