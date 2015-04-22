library(dplyr)
library(reshape2)
library(data.table)

## Download and unzip the files
get_files <- function() {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
    unzip(temp)
}

## Return descriptive activity names
activity_label <- function(index) {
    if (index == 1)
        "Walking"
    else if (index == 2)
        "Walking Upstairs"
    else if (index == 3)
        "Walking Downstairs"
    else if (index == 4)
        "Sitting"
    else if (index == 5)
        "Standing"
    else if (index == 6)
        "Laying"
}


## Read data into a single data frame
load_data <- function(type) {
    ## read the subject and activity data
    subjects <- read.table(paste("./UCI HAR Dataset/", type, "/subject_", type,".txt", sep=""))
    activities <- read.table(paste("./UCI HAR Dataset/", type, "/Y_", type,".txt", sep=""))
    
    ## read the feature/measurement variables with feature names
    featureNames <- read.table("./UCI HAR Dataset/features.txt")
    features <- read.table(paste("./UCI HAR Dataset/", type, "/X_", type,".txt", sep=""), col.names = featureNames$V2)
    
    ## Name the activities with descriptive activity names
    activityLabels <- sapply(activities$V1, activity_label)
    
    ## combine all the variables into a single data frame
    cbind(Activity=activityLabels, Subject=subjects$V1, features)
}

## select the mean and std features
select_features <- function() {
    ## read feature names
    featureNames <- read.table("./UCI HAR Dataset/features.txt")
    
    ## identify mean and std features
    index <- grep("mean|std", featureNames$V2)
}

## Run analysis
run_analysis <- function() {
    ## merge the training and the test sets to create one data set
    data <- rbind(load_data("train"), load_data("test"))
    
    ## extract the first two columns (activity & subject) and the selected features (mean and standard deviation measurements)
    index <- select_features()
    data <- data[,c(1,2,index+2)]
    
    ## the Activity column already has descriptive activity names from load_data()
    
    ## the feature/measurement names start at 3rd column
    featureNames <- colnames(data)
    featureNames <- featureNames[3:length(featureNames)]
    
    ## label the features/measurements with descriptive variable name
    descNames <- gsub("\\bt", "time", featureNames)
    descNames <- gsub("\\bf", "frequency", descNames)
    descNames <- gsub("Acc", "Accelerometer", descNames)
    descNames <- gsub("Gyro", "Gyroscope", descNames)
    descNames <- gsub("Jerk", "JerkSignal", descNames)
    descNames <- gsub("Mag", "Magnitude", descNames)
    
    data <- setnames(data, old=featureNames, new=descNames)
    
    ## convert to long-format and calculate the averages for each activity and each subject
    datamelt <- melt(data, id.vars=c("Activity", "Subject"))
    result <- dcast(datamelt, Activity + Subject ~ variable,mean)
    
    ## write the resulting data set
    write.csv(result, "./hcrmeanresult.csv")
}