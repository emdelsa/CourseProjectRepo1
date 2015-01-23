## Code Book
### Coursera Getting and Cleaning Data Course Project

### 1. Introduction
This tidy data set has been prepared for the Course Project assignment. 

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

### 2. Data Dictionary

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