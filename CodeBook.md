# Getting and Cleaning Data Course Project
## CodeBook


* The data used in this script is sourced from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* run_analyis() is a script that cleans the data in the following manner:

      1. read the following files into the respective variables:
        + "y_test.txt" to yTestData
        + "x_test.txt" to xTestData
        + "subject_test.txt" to sTestData
        + "y_train.txt" to yTrainData
        + "x_train.txt" to xTrainData
        + "subject_train.txt" to sTrainData
      2. merge the x, y, and subject data into respective data sets:
        + yTestData and yTrainData merged into yData
        + xTestData and xTrainData merged into xData
        + sTestData and sTrainData merged into sData
      3. set the names for each data set:
        + yData named "Activity"
        + xData named after corresponding features (from "features.txt")
        + sData named "Subject"
      4. cbind() all the data into a single data set: allData
      5. extract the mean and standard deviation data into a subset: meanStdData
      6. get the names of each activity type, convert the "Activity" column into a factor, and rename each factor level to the corresponding activity name
      7. using gsub() clean the column names by making the names more descriptive
      8. using ddply(), organize the data according to mean
      9. using write.table() save the data to "tidy_data.txt"