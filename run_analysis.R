# Analysis file

library('plyr')


## Creates a tidy dataset representing the average for each activity with each
## subject
##
## Args: 
##      - datasetDir : The relative directory path holding the dataset
##      - resultFile : A file to write the resulting tidy dataset to.
##
## Returns:
##      A tidy dataset with the average of each variable for each activity and each subject.
##
analyze <- function(datasetDir, resultFile=NULL) {
    #datasetDir <- "dataset"
    # Setting files variables
    columnsFile <- file.path(getwd(), datasetDir, 'features.txt')
    testDataFile <- file.path(getwd(), datasetDir, 'test', 'X_test.txt')
    testSubjectsFile <- file.path(getwd(), datasetDir, 'test', 'subject_test.txt')
    testActivityFile <- file.path(getwd(), datasetDir, 'test', 'y_test.txt')
    trainDataFile <- file.path(getwd(), datasetDir, 'train', 'X_train.txt')
    trainSubjectsFile <- file.path(getwd(), datasetDir, 'train', 'subject_train.txt')
    trainActivityFile <- file.path(getwd(), datasetDir, 'train', 'y_train.txt')

    # Reading data from files

    # Getting Column Names
    columnsNames <- read.table(columnsFile, col.names=c("id", "name"))
    columnsNames <- make.names(unlist(data.frame(columnsNames[2])$name))

    # Getting test data and adding subjects and activity to it
    testData <- read.table(testDataFile, col.names=columnsNames, row.names=NULL)
    testSubjects <- read.table(testSubjectsFile, col.names="subject")
    testActivities <- read.table(testActivityFile, col.names="activity")
    testData$subject <- unlist(data.frame(testSubjects)$subject)
    testData$activity <- unlist(data.frame(testActivities)$activity)

    # Getting train data and adding subjects and activity to it
    trainData <- read.table(trainDataFile, col.names=columnsNames, row.names=NULL)
    trainSubjects <- read.table(trainSubjectsFile, col.names="subject")
    trainActivities <- read.table(trainActivityFile, col.names="activity")
    trainData$subject <- unlist(data.frame(trainSubjects)$subject)
    trainData$activity <- unlist(data.frame(trainActivities)$activity)

    # Merging both data sets
    mergedData <- rbind(testData, trainData)

    # Removing all columns but mean and standard deviation columns
    subcolumns <- grep(".*(std|mean)\\..*", columnsNames, value=TRUE)
    # Adding subject and activity to subcolumns to match the data
    subcolumns <- c(subcolumns, 'subject', 'activity')
    # subsetting data to contain only requested columns
    subData <- mergedData[, subcolumns]

    # Set descriptive activity names to name the activities in the data set
    activities <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
    subData$activity <- factor(subData$activity, levels=c(1,2,3,4,5,6), labels=activities)

    # Creating tidy data set with average of each column and grouping by
    # activity and subject
    end <- length(subcolumns) - 2
    tidyData <- aggregate(subData[,1:end], by=list(subData$activity, subData$subject),FUN=mean)
    tidyData <- rename(tidyData, c("Group.1"="Activity", "Group.2"="Subject"))

    # Saving result to a the passed file, if requested
    if (!is.null(resultFile)) {
        write.table(tidyData, resultFile, row.names=FALSE)
    }
    # Returning the tidy data set
    tidyData
}
