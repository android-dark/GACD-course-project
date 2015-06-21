




run_analysis <- function() {
  
  #Check if the "/data" directory exists in the working dir, and if not create it
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  
  #Check if the data has been downloaded and if not download and uncompress it
  if (!file.exists("./data/UCI HAR Dataset")) {
    #save the data address to a variable
    fileLoc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
    #download the data into /data
    download.file(fileLoc,destfile="./data/data.zip")
  
    #uncompress the data file
    unzip(zipfile="./data/data.zip",exdir="./data")
  }
  
  #Create a vairiable to store the path of the files
  fpath <- file.path("./data", "UCI Har Dataset")
  
  #Create a list of the files in the data set
  files <- list.files(fpath, recursive=TRUE)
  
  #set the test data
  yTestData <- read.table(file.path(fpath, "test", "y_test.txt"))
  xTestData <- read.table(file.path(fpath, "test", "X_test.txt"))
  sTestData <- read.table(file.path(fpath, "test", "subject_test.txt"))
    
  #set the train data
  yTrainData <- read.table(file.path(fpath, "train", "y_train.txt"))
  xTrainData <- read.table(file.path(fpath, "train", "X_train.txt"))
  sTrainData <- read.table(file.path(fpath, "train", "subject_train.txt"))
  
  #merge data by type into respective sets: activity, features, and subject
  yData <- rbind(yTestData,yTrainData)
  xData <- rbind(xTestData,xTrainData)
  sData <- rbind(sTestData,sTrainData)
  
  #label the data sets by type
  names(yData) <- "Activity"
  fnames <- read.table(file.path(fpath, "features.txt"))[,2]
  names(xData) <- fnames
  names(sData) <- "Subject"
  
  #merge all data into a single set by column: activity, subject, features
  allData <- cbind(cbind(yData, sData), xData)
  
  #extract data and subset for only mean and standard deviation measurements
  fnamesSubset <- factor((fnames[grep("mean\\(\\)|std\\(\\)", fnames)]),exclude = NA)
 
  dataMeanSTDNames <- c(as.character(fnamesSubset), "Activity", "Subject")
  
  meanStdData <- subset(allData, select=dataMeanSTDNames)
  
  #assign descriptive activity names
  activityNames <- read.table(file.path(fpath, "activity_labels.txt"))  #get the activity names
  
  meanStdData$'Activity' <- as.factor(meanStdData$'Activity')  #convert the activity column to a factor
  levels(meanStdData$'Activity')<-activityNames$V2  #set the levels to the activity name
  
  #assign descriptive feature names
  names(meanStdData) <- gsub("BodyBody", "Body", names(meanStdData))
  names(meanStdData) <- gsub("^t", "Time", names(meanStdData))
  names(meanStdData) <- gsub("^f", "Frequency", names(meanStdData))
  names(meanStdData) <- gsub("Acc", "Accelerometer", names(meanStdData))
  names(meanStdData) <- gsub("Gyro", "Gyroscope", names(meanStdData))
  names(meanStdData) <- gsub("Mag", "Magnitude", names(meanStdData))
  names(meanStdData) <- gsub("mean\\(\\)", "Mean", names(meanStdData))
  names(meanStdData) <- gsub("std\\(\\)", "StandardDeviation", names(meanStdData))
  
  #organize the data into a tidy data set with the average of each feature for each activity for each subject
  library(plyr)
  meanData <- ddply(meanStdData, .(Subject,Activity), numcolwise(mean))
  #write the data to a text file
  write.table(meanData, file="tidy_data.txt",row.name=FALSE)
  
}