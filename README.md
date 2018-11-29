# Getting_and_Cleaning_Data_Project

1. Merging the training and the test sets to create one data set
  a) we load the data using the command read.table
  b) we add some names with the function names
  b) we put the data sets together with cbind

2. Extracting only the measurements on the mean and standard deviation for each measurement
  a) we exctract with the command grep that search for matches to argument pattern within each element of a character vector

3. Using descriptive activity names to name the activities in the data set
  a) we load activity labels
  b) we add the column that has the activity names
  c) we put activity label at the beggining of the data set 

4. Appropriately labeling the data set with descriptive variable names
  a) we use function names and gsub. gsub performs a replacement of the first and all matches respectively.

5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject
  a) with the function aggregate we splits the data into subsets and computee summary statistics
  b) wrtie.table is a function that save the data set
