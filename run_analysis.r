# Getting & Cleaing Data course project work
# copyright (c) 2015 Harri Kaimio

# This script merges the feature vectors from both training and test part of  UCI human 
# activity recognition data set, extracts mean and standard deviation of each measured 
# parameter for each sample and summarizes these by calculating mean for those for each 
# subject and activity.

# usage: Execute the run_analysis.r script in the top directory of the data set. Results 
# will be stored in file summary.txt and also in R variable summary.


library(dplyr)
library(tidyr)

# Reads the raw HAR data from a certain directory and its subdirectories
# The feature names are read from the dir, after that the actual observations
# for dataset specified are read from corresponding directory

readHARDataset <- function( dir, dataset )
{
  featureNameFile = paste( dir, "features.txt", sep = "/" )
  featureNames = read.table( featureNameFile )
  activityNamesFile = paste( dir, "activity_labels.txt", sep="/")
  activityLabels = read.table( activityNamesFile, col.names = c("activity_id", "activity_name") )


  featureFile = paste( dir, "/", dataset, "/X_", dataset, ".txt", sep="" )
  subjectFile = paste( dir, "/", dataset, "/subject_", dataset, ".txt", sep="" )
  activityFile = paste( dir, "/", dataset, "/Y_", dataset, ".txt", sep="" )
  features = read.table( featureFile, col.names = featureNames$V2 )
  subjects = read.table( subjectFile, col.names  = c("subject") )
  activities = read.table( activityFile, col.names = c("activity_id") )
  activities$activity = factor(activities$activity_id, labels = activityLabels$activity_name)
  data = bind_cols( list( subjects, activities, features ) )
  
  # Tidy up the measurement column names
  names(data)<-sapply(strsplit(names(data), "\\.+"), paste, collapse = "_" )
  data
}

readHARData <- function(dir)
{
  testData <- readHARDataset( dir, "test")
  trainData <- readHARDataset( dir, "train")
  tbl_df( bind_rows( testData, trainData ) )
}

summarizeHARData <- function(dir)
{
  data <- readHARData(dir)
  # Create summary of the data
  summary <- data %>%
    select(subject, activity, matches("_(mean|std)(_|$)")) %>%
    gather(feature, value, -c(subject,activity)) %>% 
    group_by( subject, activity, feature) %>%
    summarize( avg=mean(value)) %>%
    spread(feature, avg)
  
  summary
}

summary <- summarizeHARData( "." )
write.table( summary, "summary.txt", row.name = FALSE )

