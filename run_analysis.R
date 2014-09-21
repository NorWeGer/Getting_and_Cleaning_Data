# Course Project: Getting-and-Cleaning-Data-Project
# Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Task No. 1:  Merges the training and the test sets to create one data set.

#setwd('E:/Workspace/R/3.Getting and Clearing Data/Course_Project/')
trainX <- read.table("./data/train/X_train.txt")
dim(trainX) # 7352  561
testX <- read.table("./data/test/X_test.txt")
dim(testX) # 2947  561
X <- rbind(trainX , testX)
dim(X) # 10299   561

trainY <- read.table("./data/train/y_train.txt")
dim(trainY) # 7352    1
testY <- read.table("./data/test/y_test.txt")
dim(testY) # 2947    1
Y <- rbind(trainY , testY)
dim(Y) # 10299     1

trainS <- read.table("./data/train/subject_train.txt")
dim(trainS) # 7352    1
testS <- read.table("./data/test/subject_test.txt")
dim(testS) # 2947    1
S <- rbind(trainS , testS)


# Task No. 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./data/features.txt")
meanStdIndices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, meanStdIndices]
dim(X) # 10299    66

names(X) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(X) <- gsub("mean", "Mean", names(X))
names(X) <- gsub("std", "Std", names(X)) 
names(X) <- gsub("-", "", names(X))


# Task No. 3: Uses descriptive activity names to name the activities in the data set

activity <- read.table("./data/activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
Y[,1] = activity[Y[,1], 2]
names(Y) <- "activity"


# Task No.4: Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned <- cbind(S, Y, X)
dim(S) # 10299     1
write.table(cleaned, "merged_clean_data.txt")


# Task No. 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject.

LenSubject <- length(table(S))
LenActivity <- dim(activity)[1]
LenColumn <- dim(cleaned)[2]

result <- matrix(NA, nrow=LenSubject*LenActivity, ncol=LenColumn)
result <- as.data.frame(result)
colnames(result) <- colnames(cleaned)

row = 1
for(i in 1:LenSubject) {
	for(j in 1:LenActivity) {
		result[row, 1] <- sort(unique(S)[, 1])[i]
		result[row, 2] <- activity[j, 2]
		boolean1 <- i == cleaned$subject
		boolean2 <- activity[j, 2] == cleaned$activity
		result[row, 3:LenColumn] <- colMeans(cleaned[boolean1&boolean2, 3:LenColumn])
		row <- row + 1
	}
}
result

write.table(result, "data_with_means.txt", row.name=FALSE) 

