##
## run_analysis.R
## 
## This R script creates a tidy version of the UCI Human Activity Recognition
## using Smartphones Dataset Version 1.0 available at:
## 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## 
## Specifically, this script:
## 
## 1. Merges the training and the test sets to create one data set.
##
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement. 
##
## 3. Uses descriptive activity names to name the activities in the data set.
##
## 4. Label the data set with descriptive variable names. 
##
## 5. Creates a tidy data set with the average of each variable for each 
##    activity and each subject
## 

run_analysis <- function () {
  
  library(dplyr)
  library(tidyr)
  
  # train data set
  x_train <- read.table(file="./train/X_train.txt")       # feature measurements
  y_train <- read.table(file="./train/y_train.txt")       # activity ID
  s_train <- read.table(file="./train/subject_train.txt") # subject ID
  train <- bind_cols(s_train, y_train, x_train)
  remove(x_train, y_train, s_train)
  
  # test data set
  x_test <- read.table(file="./test/X_test.txt")       # feature measurements
  y_test <- read.table(file="./test/y_test.txt")       # activity ID
  s_test <- read.table(file="./test/subject_test.txt") # subject ID
  test <- bind_cols(s_test, y_test, x_test)
  remove(x_test, y_test, s_test)
  
  # merges training and test data sets to create 1 single data set
  ds <- tbl_df(rbind(train, test))
  remove(train, test)
  
  # read column/variable names
  v <- read.table(file="./features.txt")
  v <- as.character(v$V2)

  # add column/variable names to data set
  colnames(ds) <- c("subject", "activity_id", v)
  
  # extract measurements on mean and standard deviation
  ds2 <- ds[, c(grep("subject|activity_id|mean|std", names(ds)))]
  
  # exclude measurements on meanFreq() and they are different from mean()
  ds3 <- ds2[, -c(grep("meanFreq", names(ds2)))]
  remove(v, ds, ds2)
  
  # replace activity id with descriptive labels
  al <- read.table(file="./activity_labels.txt")
  colnames(al) <- c("activity_id", "activity")  
  ds4 <- merge(ds3, al, by="activity_id")
  ds5 <- select(ds4, -activity_id)
  remove(al, ds3, ds4)
  
  # label the data set with descriptive variable names
  # convention: lowercase for the first word, 
  #             then first letter of next word uppercase,
  #             NO non-character symbols like -, ()
  v <- gsub("fBodyBody", "fBody", colnames(ds5))
  v <- gsub("\\()" , "",     v)
  v <- gsub("\\()-", "",     v)
  v <- gsub("\\-"  , "",     v)
  v <- gsub("mean" , "Mean", v)
  v <- gsub("std"  , "Std",  v)
  colnames(ds5) <- v
  
  # average of each variable by activity and subject
  ds6 <- ds5 %>% 
    group_by(activity, subject) %>% 
    summarise_each(funs(mean))
  remove(ds5)
  
  # write the tidy dataset to a file
  write.table(ds6, 
              file="average_by_activity_subject.txt", 
              quote = FALSE,
              row.names = FALSE)
  
}