ProjectCourse3
==============

Project assignment for course "Getting and Cleaning data"

This file describes how the file "run_analysis.R" works to complete the assignment.

The code assumes that the file downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
has been unzipped and is  sitting in the working directory where R is running in a directory called UCI HAR Dataset.
This code performs several tasks:

* Load the metadata from the source files in the UCI HAR Dataset.

The code first reads in the activity_labels.txt and features.txt files that contain the names of the activities performed by people and the names of the variables measured by the smartphones respectively. This creates two objects: actLabels and varLabels. 

* Load the test data

The next section loads the test data (test561), the id's of the subjects that were wearing the devices (subject__test), and the activity codes that these subjects were performing at the time of the measurements (act_test). The activity codes are transformed into the activity names by refering to the actLabels object created in part 1. The mean and standard deviation of each variable are extracted by identifying their position along the varLabels object and subsetting the object that contains all of the variables (test561) to create a new variable object (test_subset). The names of these variables is also extracted and stored into a new object (varNames). Once this is done a new data frame is created with the following columns: type (test or train), subject (id of the subject), activity (name of the activity) and the extracted variables (from object test_subset). The names for the variables are added to this data frame from the varNames object. This new data frame is stored in object named newtest.

* Load the train data

The next section loads the train data (train561), the id's of the subjects that were wearing the devices (subject_train), and the activity codes that these subjects were performing at the time of the measurements (act_train). The activity codes are transformed into the activity names by refering to the actLabels object created before. The mean and standard deviation of each variable are extracted by as described in the section above to create a new variable object (train_subset). The names of these variables is also extracted and stored into a new object (varNames). Once this is done a new data frame is created with the following columns: type (test or train), subject (id of the subject), activity (name of the activity) and the extracted variables (from object trains_subset). The names for the variables are added to this data frame from the varNames object. This new data frame is stored in object named newtrain.

* Merging train and test datasets

These two data sets are merged in line 46 by using the rbind() command creating a new object called _mergeData_.

* Creating a new tidy dataset showing means of all variables by Activity and Subject

The object _mergeData_ is transformed using the _melt()_ function from the _reshape2_ package. After this, the data are recasted as a function of activity and subject grouping by mean of each variable using the _dcast()_ function. The resulting data frame is stored in the _tidyData_ object.

* Writing the file to disk

Finally, the _tidyData_ object is written to the file *SmartPhoneData_mean_of_vars_by_act_subject.txt* to the R working directoru









