# Getting and Cleaning Data Course Project
## README


This file describe how run_analysis.R functions.

* First run: source("run_analysis.R")
* Then simply run: run_analysis()
* The script will check if the "data" folder exists, and if not will create it
* It will then check and see if the data has been downloaded, and if not, will download it to the "data" folder
    + The data is from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    + Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The function will output a tidy data table called "tidy_data.txt" (this can be read using read.table())