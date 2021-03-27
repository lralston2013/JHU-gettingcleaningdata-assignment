# JHU-gettingcleaningdata-assignment

**Files in this repo**

- README.md : overview of files and data
- CodeBook.md : describes variables, the data and transformations
- run_analysis.R : compiles the tidydata dataset

**Description of raw data**

Raw input data - Human Activity Recognition Using Smartphones Dataset - was provided by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory www.smartlab.ws  

Data was collected through an experiment with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The raw dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For more details on the raw data visit: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**Description of tidydata**

This dataset is the output from running the run_analysis.R code. This code:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set (tidydata) with the average of each variable for each activity and each subject.
