# Code to complete project course assignment for Getting and Cleaning Data
# submitted by Jorge Ahumada

# For this to work all data is assumed to be sitting in a directory called "UCI Har Dataset"
# in the R working directory

#First load files with names of activities and names of variables

actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
varLabels <- read.table("UCI HAR Dataset/features.txt")

# LOAD TEST DATA
#Load test data set, subject and activity code data for test

test561 <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
actCodes_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# transform the codes into the actual names of the variables found in object actLabels
actLabels_test<-actLabels[actCodes_test[,1],2]

# Extract mean and standard deviation of each variable
# Create vector with position of these variables
indx <-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,
516:517,529:530,542:543)

#extract them from the original variable list
test_subset <- test561[,indx]

#get their names
varNames <- varLabels[indx,2]

#add additional columns with type (test or train), subject id, activity name and variables

newtest <- cbind(type="test",subject=subject_test,activity=actLabels_test,test_subset)

# add names from varNames object
names(newtest)[4:69] <- as.character(varNames)

#LOAD TRAIN DATA
#Load training data sets, subject and activity code data for train

train561 <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"
actCodes_train <- read.table("UCI HAR Dataset/train//y_train.txt")

# transform the codes into the actual names of the variables found in object actLabels
actLabels_train<-actLabels[actCodes_train[,1],2]

#extract them from the original variable list
train_subset <- train561[,indx]

#add additional columns with type (test or train), subject id, activity name and variables

newtrain <- cbind(type="train",subject=subject_train,activity=actLabels_train,train_subset)

#add names from varNames object
names(newtrain)[4:69] <- as.character(varNames)

#MERGE TRAIN AND TEST DATA TOGETHER IN ONE DATA FRAME

mergeData <- rbind(newtest,newtrain)

# CREATE A NEW TIDY DATA SET WITH THE MEAN OF EACH OF THESE VARIABLES BY INDIVIDUAL AND ACTIVITY
library(reshape2)

# First melt the data, so that all variables are collapsed in two columns: variable (with the variable name) 
# and value (the value of that variable - mean or sd)

meltData <- melt(mergeData,id.vars=1:3)

# Use dcast function to calculate the mean of each variable by subject and activity
tidyData <- dcast(meltData,subject+activity~variable,mean)

#write these data to a file
write.table(tidyData,"SmartPhoneData_mean_of_vars_by_act_subject.txt")
