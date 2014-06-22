ProjectCourse3
==============

Project assignment for course "Getting and Cleaning data"

This file describes how the file "run_analysis.R" works to complete the assignment.

The code assumes that the file downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
has been unzipped and is  sitting in the working directory where R is running in a directory called UCI HAR Dataset. The code can be run by sourcing the file using the _source()_ function.

This code performs several tasks:

* Load the metadata from the source files in the UCI HAR Dataset.

The code first reads in the *activity_labels.txt* and *features.txt* files that contain the names of the activities performed by people and the names of the variables measured by the smartphones respectively. This creates two objects: _actLabels_ and _varLabels_. 

* Load the test data

The next section loads the test data (_test561_), the id's of the subjects that were wearing the devices (_subject_test_), and the activity codes that these subjects were performing at the time of the measurements (_act_test_). The activity codes are transformed into the activity names by refering to the _actLabels_ object created in part 1. The mean and standard deviation of each variable are extracted by identifying their position along the _varLabels_ object and subsetting the object that contains all of the variables (_test561_) to create a new variable object (_test_subset_). The names of these variables is also extracted and stored into a new object (_varNames_). Once this is done a new data frame is created with the following columns: type (test or train), subject (id of the subject), activity (name of the activity) and the extracted variables (from object _test_subset_). The names for the variables are added to this data frame from the varNames object. This new data frame is stored in object named _newtest_.

* Load the train data

The next section loads the train data (_train561_), the id's of the subjects that were wearing the devices (_subject_train_), and the activity codes that these subjects were performing at the time of the measurements (_act_train_). The activity codes are transformed into the activity names by refering to the _actLabels_ object created before. The mean and standard deviation of each variable are extracted by as described in the section above to create a new variable object (_train_subset_). Once this is done, a new data frame is created with the following columns: type (test or train), subject (id of the subject), activity (name of the activity) and the extracted variables (from object _trains_subset_). The names for the variables are added to this data frame from the _varNames_ object. This new data frame is stored in object named _newtrain_.

* Merging train and test datasets

These two data sets are merged in line 46 by using the _rbind()_ command creating a new object called _mergeData_.

* Creating a new tidy dataset showing means of all variables by Activity and Subject

The object _mergeData_ is transformed using the _melt()_ function from the _reshape2_ package. After this, the data are recasted as a function of activity and subject grouping by mean of each variable using the _dcast()_ function. The resulting data frame is stored in the _tidyData_ object.

* Writing the file to disk

Finally, the _tidyData_ object is written to the file *SmartPhoneData_mean_of_vars_by_act_subject.txt* to the R working directoru.









