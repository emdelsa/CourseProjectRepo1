## Coursera Getting and Cleaning Data Course Project
## Script: run_analysis.R
## Author: Emilio Delgado
## Date: 21/01/2015
##
## This script performs the following operations on the Course Project dataset:
## 1. Extracts only the measurements with mean() and std() suffixes for each measurement. 
## 2. Uses descriptive activity names to name the activities in the data set
## 3. Correct variable names so they do not contain "()" or "-". 
## 4. Merges the training and the test sets to create one data set.
## 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## Instructions:
## Download the data set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Unzip the data set into a folder named "Dataset" placed in the working directory
## Run the script


## This function prepares the data set df according to the Course Project Requirements 1..4
## Arguments:
## df: The data frame containing the data
## sbj: table of subject ids
## act: table of activity labels
## f: vector of raw column names
## f1: vector of column names to be selected (must be a subset of f)
## f2: vector of new column names (must have the same length as f1)

cleanData <- function (df, sbj, act, f, f1, f2){
  names(df)<- f$feature                        # rename df columns as in f
  df <- df[,f1$feature]                        # select df columns as in f1
  names(df) <- f2$feature                      # rename df columns as in f2
  df <- df[,sort(names(df))]                   # sort resulting columns
  
  names(sbj) <- "subject"
  names(act) <- "activity.id"
  df$subject <- sbj$subject                    # add subject id column
  df$activity.id <- act$activity.id            # add activity id column in order to do a join
  df <- merge(df,activityLabels,sort=F)        # "join" df with the table activity labels
  df <- df[,-1]                                # remove activity id column (not needed anymore)   
  return(df)
}

## Read and prepare data common to both sets: activity labels and variable names
print("Preparing activity labels and variable names")                                             
activityLabels <- read.table("./Dataset/activity_labels.txt")                            # read activity labels
names(activityLabels) <- c("activity.id","activity")
features <- read.table("./Dataset/features.txt")                                         # read variable names
names(features) <- c("id","feature")
features1 <- features[grep("std\\(\\)|mean\\(\\)",features$feature),]                    # select desired variables
features2 <- features1
features2$feature <- gsub("(.+)-(std|mean)\\(\\)-*(.*)","\\1_\\3_\\2",features2$feature) # rename variables
features2$feature <- gsub("__","_",features2$feature)

## Process Training data
print("Processing training data")
trainData <- read.table("./Dataset/train/x_train.txt")               # read training data
subject <- read.table("./Dataset/train/subject_train.txt")           # read subjects table
activity <- read.table("./Dataset/train/y_train.txt")                # read activities table
trainData <- cleanData(trainData,subject,activity,features,features1,features2)
print(sprintf("* Rows: %d, Cols: %d",nrow(trainData),ncol(trainData)))

## Process Test data
print("Processing test data")
testData <- read.table("./Dataset/test/x_test.txt")
subject <- read.table("./Dataset/test/subject_test.txt")
activity <- read.table("./Dataset/test/y_test.txt")
testData <- cleanData(testData,subject,activity,features,features1,features2)
print(sprintf("* Rows: %d, Cols: %d",nrow(testData),ncol(testData)))

## Bind training and and test sets
print("Merging test and training data")
data1 <- rbind(trainData,testData)
print(sprintf("* Rows: %d, Cols: %d",nrow(data1),ncol(data1)))

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(tidyr)
print("Producing result")
data2 <- split(data1[,1:66],list(data1$activity,data1$subject))                     # split by activity and subject
data2<- t((sapply(data2,colMeans)))                                                 # compute the average of each column, per splitted group
data2 <- as.data.frame(as.table(data2))                                             # combine result in a data frame
data2$Var1 <- as.character(data2$Var1)                          
data2 <- separate(data2,Var1,into=c("Activity","Subject"),sep="\\.")                # split first column in two
names(data2) <- c("Activity","Subject","Variable","Average")                        # put adequate column names

data2 <- data2[grep(".+_.+_.+",data2$Variable),]                                    # select observations
data2 <- separate(data2,Variable,into=c("Measurement","Axis","Variable"),sep="_")   # separate further into Axis and Variable
data2$Measurement <- gsub("(f|t)(Body|Gravity)","\\1_\\2_",data2$Measurement)       # separate further into Domain,Component and Measurement
data2 <- separate(data2,Measurement,into=c("Domain","Component","Measurement"),sep="_")
print(sprintf("* Rows: %d, Cols: %d",nrow(data2),ncol(data2)))

write.table(data2,"TidyData.txt",row.names=F)                                         # write result
print("Done")