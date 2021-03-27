library(dplyr)
library(data.table)

# set wd
setwd("~/prof-dev/JHU-Rprogramming/Getting-Cleaning-data/week4")

# read in feature labels
featureLabels <- read.table("./data/features.txt", 
                            header = FALSE)

# read in training data 
trainDataX <- read.table("./data/train/X_train.txt", 
                        header = FALSE)
trainDataY <- read.table("./data/train/y_train.txt", 
                         header = FALSE)
trainDataID <- read.table("./data/train/subject_train.txt", 
                          header = FALSE)

# review Y and ID data to understand label/subject information better
table(trainDataY$V1)
  #    1    2    3    4    5    6 
  # 1226 1073  986 1286 1374 1407 
  # this shows there are 6 labels 1 - 6, aligning with activity_labels.txt

table(trainDataID$V1)
  #   1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25 
  # 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 
  # 26  27  28  29  30 
  # 392 376 382 344 383
  # this shows the random 70% subject draw assigned to training data

# label data
names(trainDataX) <- featureLabels$V2  
trainDataY <- rename(trainDataY, Activity = V1)
trainDataID <- rename(trainDataID, Subject = V1)

# combine train data into subject x activity x measurement dataset
trainData <- cbind(trainDataID, trainDataY, trainDataX)

# read in test data
testDataX <- read.table("./data/test/X_test.txt", 
                         header = FALSE)
testDataY <- read.table("./data/test/y_test.txt", 
                         header = FALSE)
testDataID <- read.table("./data/test/subject_test.txt", 
                          header = FALSE)

# label data
names(testDataX) <- featureLabels$V2  
testDataY <- rename(testDataY, Activity = V1)
testDataID <- rename(testDataID, Subject = V1)

# combine test data into subject x activity x measurement dataset
testData <- cbind(testDataID, testDataY, testDataX)

# (Q1) merge training and test data
allData <- rbind(trainData, testData)

# (Q2) keep only -mean() and -std() feature data
meanMeasures <- allData[grep("-mean()", names(allData))]
stdMeasures <- allData[grep("-std()", names(allData))]
allDatalite <- cbind(select(allData, Subject, Activity), 
                     meanMeasures,
                     stdMeasures)

# allDatalite2 <- allData %>%
#  select(matches('mean|std'))

# (Q3) apply the activity labels
activityLabels <- read.table("./data/activity_labels.txt", 
                            header = FALSE)
  # 1 - walking, 2 - walking_upstairs, 3 - walking_downstairs
  # 4 - sitting, 5 - standing, 6 - laying
allDatalite <- allDatalite %>%
  arrange(Activity) %>%
  mutate(Activity = as.character(factor(Activity, levels=1:6, 
                                         labels= activityLabels$V2)))

# (Q4) provide data set with descriptive variable names.
names(allDatalite)<-gsub("tBodyAcc-","Body acceleration signal in time domain (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("tBodyAccMag-","Body acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("tBodyAccJerk-","Body acceleration jerk signal in time domain (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("tBodyAccJerkMag-","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("tGravityAcc-","Gravity acceleration signal in time domain (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("tGravityAccMag-","Gravity acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("tBodyGyro-","Body acceleration signal in time domain (from the gyroscope)",names(allDatalite))
names(allDatalite)<-gsub("tBodyGyroMag-","Body acceleration signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(allDatalite))
names(allDatalite)<-gsub("tBodyGyroJerk-","Body acceleration jerk signal in time domain (from the gyroscope)",names(allDatalite))
names(allDatalite)<-gsub("tBodyGyroJerkMag-","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(allDatalite))
names(allDatalite)<-gsub("fBodyAcc-","Body acceleration signal in frequence domain (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("fBodyAccMag-","Body acceleration signal in frequence domain applied to Fast Fourier Transform(from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("fBodyAccJerk-","Body acceleration jerk signal in frequence domain (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("fBodyGyro-","Body acceleration signal in frequence domain (from the gyroscope)",names(allDatalite))
names(allDatalite)<-gsub("fBodyAccJerkMag-","Body acceleration jerk signal in frequence domain applied to Fast Fourrier Transform (from the accelerometer)",names(allDatalite))
names(allDatalite)<-gsub("fBodyGyroMag-","Body acceleration signal in frequence domain applied to Fast Fourier Transform (from the gyroscope)",names(allDatalite))
names(allDatalite)<-gsub("mean()", "MEAN", names(allDatalite))
names(allDatalite)<-gsub("std()", "SD", names(allDatalite))

# (Q5) :tidy data set with the average of each variable for each activity and each subject
tidydata <- allDatalite %>%
  group_by(Subject, Activity) %>%
  summarize_all(mean)

write.table(tidydata, "TidyData.txt", row.name=FALSE)
