##run_analysis.R
library(plyr)

## load data
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", colClasses="character", col.names=c("no","activity_name"))
features <- readLines("./data/UCI HAR Dataset/features.txt")
subject_test <-read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names="subject")
subject_train <-read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names="subject")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", colClasses="numeric")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names="activity")

## appropriately labels data set with desciptive variable names
names(x_test) <- features

test <- cbind(subject_test, y_test, x_test)

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", colClasses="numeric")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names="activity")

## appropriately labels data set with desciptive variable names
names(x_train) <- features

train <- cbind(subject_train, y_train, x_train)

##merge data
dt <- rbind(test,train)

##extract 
dt_extr <- dt[,grep("*mean*|*std*|subject|activity",names(dt))]

##name activity descriptive
dt_ext <- merge(dt_extr,activity_labels,by.x="activity",by.y="no")

