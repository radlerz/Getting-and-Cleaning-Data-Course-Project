# Getting and Cleaning Data Course Project

The R script "run_analysis.R" in this repository creates a tidy version of the "UCI Human Activity Recognition using Smartphones Dataset Version 1.0 [1]" available at:

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Specifically, this script:

1. Merges the training and the test sets to create one data set.  

  * It does so by first merging the activity, subject and measurement data of the training data set into a R dataframe.
  * As a second step, it merges the equivalent components of the test data set into a second dataframe.  
  * Then it combines the two dataframes to form one single data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

  * It does so by first naming the columns/variables in the dataframe created in Step #1 according to "feature.txt".
  * Then it filters out columns/variables that do not identify an activity, a subject, a mean or a standard deviation.
  * It is worth noting that a special filter is needed to get rid of measures of "meanFreq" which are not "mean" measures but a Weighted average of the frequency components to obtain a mean frequency.

3. Uses descriptive activity names to name the activities in the data set.  

  * It does so by first creating a new column with description activity names whose ID matches the existing activity ID according to the file "activity_labels.txt".
  * Then it removes the old column with the activity numeric ID.

4. Label the data set with descriptive variable names.  Convention used is as follows:

  * Lowercase for the entire first word.
  * Then the first character of each word afterwards is in uppercase.
  * Non-character symbols like -, () are not being used / removed.
  * Duplicated words in e.g. fBodyBody...  where the word Body is duplicated are being removed as well

5. Creates a tidy data set with the average of each variable for each activity and each subject

  * Output file is called "average_by_activity_subject.txt".
  * Row names and quotes are not being used in the text file.
  * Column headers / variable names are being set at row #1.  Please read the codebook.md for their description.

6.  This "run_analysis.R" scripts assumes that:

  * Data files needed are either in or under the current working directory it itself is located.
  * The latest version of R packages dplyr and tidyr had been installed in the running R environment already.

7.  Footnotes:

  * [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
