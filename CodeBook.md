## Code Book
### Coursera Getting and Cleaning Data Course Project

### 1. Experiment Background
This tidy data set has been prepared for the Course Project assignment. 

This tidy data set was prepared from the raw data provided by www.smartlab.ws. The data is the result of a series of experiments [1] carried out with a group of **30 subjects** within an age bracket of 19-48 years. Each subject performed **six activities** (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. Using its embedded accelerometer and gyroscope, samples of 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the **training data** and 30% the **test data**. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion **components**, was separated using a Butterworth low-pass filter into **body acceleration** and **gravity acceleration**. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain **Jerk signals**. Finally a Fast Fourier Transform (FFT) was applied to some of these signals in order to obtain **frequency domain** values. From each window, a vector of features was obtained by calculating estimation variables (mean, std deviation, median, max, min, interquartile, etc.) from the time and frequency domain.

More information on the experiment can be obtained from http://www.smartlab.ws

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

### 2. Raw Data Description

Raw data is presented in two files, one per data set (x\_train.txt, x\_test.txt). Each data set has identical columns. Additional columns for subject and activity are provided in separate files (subject\_test.txt,y\_test.txt, etc.). 

Activity labels and raw data column names are provided as common files, valid for both raw data sets (activity\_labels.txt, features.txt).

Raw data contains 561 numeric columns with the measurement values. All the values are normalized to [-1,+1]. Training data contains 7352 rows and test data contains 2947 rows. Total number of observations is 10299. Not all subjects and activities have the same number of observations. As an illustration we include here the distribution for the training data:
```
    LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
  1      50      47       53      95                 49               53
  3      62      52       61      58                 49               59
  5      52      44       56      56                 47               47
  6      57      55       57      57                 48               51
  7      52      48       53      57                 47               51
  8      54      46       54      48                 38               41
  11     57      53       47      59                 46               54
  14     51      54       60      59                 45               54
  15     72      59       53      54                 42               48
  16     70      69       78      51                 47               51
  17     71      64       78      61                 46               48
  19     83      73       73      52                 39               40
  21     90      85       89      52                 45               47
  22     72      62       63      46                 36               42
  23     72      68       68      59                 54               51
  25     73      65       74      74                 58               65
  26     76      78       74      59                 50               55
  27     74      70       80      57                 44               51
  28     80      72       79      54                 46               51
  29     69      60       65      53                 48               49
  30     70      62       59      65                 62               65
```

More information on the raw data can be obtained from http://www.smartlab.ws


### 3. Data Process Description

All the necessary raw data are read into data frames

Both data sets are processed using exactly the same procedure. Columns containing "mean()" or "std()"" in their names are selected. After selection, the column names are further processed in order to remove brackets and replace dashes "-" by underscores "\_" and therefore comply with some recommendations. The columns are subsequently sorted alphabetically in order to provide a logical order when listed. Columns for activity\_id and subject\_id are added at the end. The table of activity labels is then joined by activity\_id. The activity id column is dropped after the join. Activity labels are not renamed as they are considered self-explanatory.

Once processed, both data sets contain the same number of columns (68) and therfore can be binded by row in order to obtain a single data set of 10299 observations.

In order to obtain the tidy data requested in the assignment, we use a split-apply-combine approach. The data is splitted by subject and activity and the mean of the values is computed for each subject-activity group. Then the data is combined again in a data frame. 

Finally the result is further processed and all the relevant columns are separated to produce a tidy data set. We have used a fine grain decomposition of the columns: activity, subject, domain, component, measurement, axis, estimation variable, and average value. Although this total decomposition is not necessarily optimal, it certainly facilitates the analysis (e.g. exploratory analysis of correlations between axes, etc. ).

According to this model the processed data set contains 6 x 30 x 2 x 2 x 2 x 3 x 2 = 8640 observations and 8 columns

The processed data set complies with the following requirements:

1. There is only one observation per row
2. There is only one variable per column
3. The data belongs to a single observation model: The only included observations are those that can be modelled as having non missing values of Activity, Subject, Domain, Component, Measurement, Axis, Variable and Average
4. According to the Course Project requirement, only two statistical estimation variables included: mean and standard deviation
5. According to the Course Project requirement, this data set merges the observations of the training and test sets

The processed data set is provided as a data frame in a file called "TidyData.txt"

### 4. Data Dictionary

__Activity__

Activity performed by the subject when the measurement was taken.

Format: 

* Character

Values: (self explanatory)

* LAYING     
* SITTING
* STANDING
* WALKING
* WALING_DOWNSTAIRS
* WALKING_UPSTAIRS

__Subject__

Subject being measured

Format: 

* Integer

Values: 

* 1..30

__Domain__

Domain in which the measurement has been estimated

Format: 

* Character (1)

Values:

* t : Time Domain
* f : Frequency Domain (Fast Fourier Transform)

__Component__

MOtion component to which the measurement corresponds (see Introduction)

Format:

* Character

Values:

* Gravity: The component extracted from the measurement by a low pass filter
* Body: The component of the motion left after filtering out Gravity


__Measurement__

Name of the physical variable being measured.  

Format:

* Character

Values:

* Acc : Acceleration
* AccJerk : Acceleration Jerk
* Gyro : Angular velocity
* GyroJerk : Angular velocity Jerk

__Axis__

The spatial axis of the measurement

Format:

* Character (1)

Values:

* X: The x-axis of the sensor
* Y: The y_axis of the sensor
* Z: The z-axis of the sensor


__Variable__

The statistical estimation variable

Format:

* Character

Values:

* mean: The mean
* std: The standard deviation


__Average__

Average of the normalized value of the variables. All the measurements in the original data source are normalized

Format:

* Numeric

Values:

* -1..+1