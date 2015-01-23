# CourseProjectRepo1
Repo for the Coursera "Getting and Cleaning Data" Course Project

This repository contains the following files:

* README.md, this document
* run_analysis.R, an R script to produce the tidy data set required by the assignment
* CodeBook.md, a code book for the tidy data set

The tidy data set has been uploaded directly to the course Project

## 1. The Tidy Data Set

This tidy data set was prepared from the raw data provided by www.smartlab.ws. The data is the result of a series of experiments carried out with a group of **30 subjects** within an age bracket of 19-48 years. Each subject performed **six activities** (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, samples of 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the **training data** and 30% the **test data**. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion **components**, was separated using a Butterworth low-pass filter into **body acceleration** and **gravity acceleration**. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain **Jerk signals**. Finally a Fast Fourier Transform (FFT) was applied to some of these signals in order to obtain **frequency domain** values. From each window, a vector of features was obtained by calculating estimation variables (mean, std deviation, median, max, min, interquartile, etc.) from the time and frequency domain.

More information on the raw data can be obtained from http://www.smartlab.ws

This data set complies with the following requirements:

1. There is only one observation per row
2. There is only one variable per column
3. The data belongs to a single observation model: The only included observations are those that can be modelled as having non missing values of Activity, Subject, Domain, Component, Measurement, Axis, Variable and Average
4. According to the Course Project requirement, only two statistical estimation variables included: mean and standard deviation
5. According to the Course Project requirement, this data set merges the observations of the training and test sets

According to this model this data set contains 6 x 30 x 2 x 2 x 2 x 3 x 2 = 8640 observations and 8 columns

This data set is provided as a data frame in a file called "TidyData.txt"

The Code Book for this data set is provided in a file called "CodeBook.md"

## 2. The Script

This script performs the following operations on the Course Project dataset:

1. Extracts only the measurements with mean() and std() suffixes for each measurement. 
2. Uses descriptive activity names to name the activities in the data set
3. Correct variable names so they do not contain "()" or "-". 
4. Merges the training and the test sets to create one data set.
5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A function called cleanData() has been created in order to process the test and training data sets in exactly the same manner, thus allowing us to bind the two data sets by row.

The script processes the raw data in several steps:

1. Read and prepare data common to both sets: activity labels and variable names
2. Process training data
3. Process test data
4. Bind training and and test sets
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. To do this the following operations are performed:
    1. Split the data by activity and subject
    2. Compute the average on the splitted groups
    3. Select observations matching the desired model, that is, observations that can be decomposed in Acticity, Subject, Domain, Component, Axis, Statistical Variable and Average. This step trims out some observations but we end up with a clean and common model for all the observations
    4. Separate and rename columns with meaningfull names

6. Finally save the data using write.table, without row names, as required in the assignment

The script produces the following output messages:
```
[1] "Preparing activity labels and variable names"
[1] "Processing training data"
[1] "* Rows: 7352, Cols: 68"
[1] "Processing test data"
[1] "* Rows: 2947, Cols: 68"
[1] "Merging test and training data"
[1] "* Rows: 10299, Cols: 68"
[1] "Producing result"
[1] "* Rows: 8640, Cols: 8"
[1] "Done"
```