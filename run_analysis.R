run_analysis <- function() {
  
  ## load the lists of features and activity labels
  features <- read.table("features.txt", col.names = c("featurenumber", "featurename"))
  activity <- read.table("activity_labels.txt", col.names = c("activitynumber", "activityname"))
  
  ## load the training and test signal data and apply feature names
  x_train <- read.table("train/X_train.txt", col.names = features$featurename)
  x_test <- read.table("test/X_test.txt", col.names = features$featurename)
  
  ## create subsets of the training and test data that only include mean and std columns
  meanfeaturenums <- grep("mean", features$featurename) ## does the column name include "mean"?
  stdfeaturenums <- grep("std", features$featurename)   ## does the column name include "std"?
  meanstdfeaturenums <- sort(union(meanfeaturenums, stdfeaturenums)) ## vector of column numbers with "mean" or "std"
  tidy_train <- x_train[meanstdfeaturenums]
  tidy_test <- x_test[meanstdfeaturenums]
  
  ## load the training and test activity data and apply activity names
  y_train <- read.table("train/y_train.txt", col.names = c("activitynumber"))
  y_test <- read.table("test/y_test.txt", col.names = c("activitynumber"))
  y_train$rownum <- c(1:nrow(y_train))  ## adding a sort index
  y_test$rownum <- c(1:nrow(y_test))    ## adding a sort index
  y_train_activity <- merge(y_train, activity, sort = FALSE)
  y_test_activity <- merge(y_test, activity, sort = FALSE)
  y_train_activity <- y_train_activity[with(y_train_activity, order(rownum)), ]
  y_test_activity <- y_test_activity[with(y_test_activity, order(rownum)), ]
  
  ## append activity names to train and test signal data
  tidy_train$activity <- y_train_activity$activityname
  tidy_test$activity <- y_test_activity$activityname
  
  ## load and append subject numbers to train and test signal data
  subject_train <- read.table("train/subject_train.txt", col.names = c("subject"))
  subject_test <- read.table("test/subject_test.txt", col.names = c("subject"))
  tidy_train$subject <- subject_train$subject
  tidy_test$subject <- subject_test$subject
  
  ## combine train and test data into one data frame
  combined <- rbind(tidy_train, tidy_test)
  
  ## remove special characters from column names
  cols <- names(combined)
  cols <- gsub("-","",cols)
  cols <- gsub("\\(","",cols)
  cols <- gsub("\\)","",cols)
  cols <- gsub("\\.","",cols)
  names(combined) <- cols
    
  ## create lists of subjects and activities
  subjects <- levels(factor(combined$subject))
  activities <- levels(factor(combined$activity))
  
  ## build tidy table of measure averages by subject and activity
  averages <- expand.grid(subject = subjects, activity = activities) ## all combinations of subject and activity
  
  ## compute averages by subject and activity
  molten <- melt(combined, id = c("subject", "activity"))
  cast <- dcast(molten, formula = activity + subject ~ variable, mean)
  tidy <- cast[with(cast, order(activity, subject)), ]
  
  write.table(tidy, file="tidy.txt", sep="\t", row.names=FALSE)
    
}
