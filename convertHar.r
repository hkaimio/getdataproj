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
  #summaryFileName = paste( dir, "summary.txt", sep = "/")
  #write.table( summary, summaryFileName, row.name = FALSE )
}
