###### Getting and cleaning data - Coursera Project #####
setwd("C:/Users/Aleksander/Desktop/UCI HAR Dataset")

### 1. Merging the training and the test sets to create one data set

# Loading training set and labels
x_train_set <- read.table("./train/X_train.txt")
y_train_labels <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Loading test set and labels
x_test_set <- read.table("./test/X_test.txt")
y_test_labels <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# Loading features vector
features <- read.table('./features.txt')

# Merging the data sets
x_all_Set <- rbind(x_train_set, x_test_set)
y_all_labels <- rbind(y_test_labels, y_train_labels)
subject_all <- rbind(subject_train, subject_test)

names(subject_all)<-c("subject")
names(y_all_labels)<- c("activity")
names(x_all_Set)<- features$V2

data_merged <- cbind(subject_all, y_all_labels)
data_final <- cbind(x_all_Set, data_merged)

### 2. Extracting only the measurements on the mean and standard deviation for each measurement

exctracted_features <-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

selected_names <- c("subject", "activity",as.character(exctracted_features) )
data_final <- subset(data_final,select=selected_names)

### 3. Using descriptive activity names to name the activities in the data set

# Loading activity labels
activity_labels = read.table('./activity_labels.txt')
View(activity_labels)

# Adding column with activity name
data_final_with_names <- merge(data_final, activity_labels, by.x = "activity", by.y= "V1", all.x = TRUE)
colnames(data_final_with_names)[69]
colnames(data_final_with_names)[69] <- "activity_label"

# Reorganizing: putting activity label at the beggining
data_final_with_names <- data_final_with_names[c(1,69, 2:68)]
colnames(data_final_with_names)

### 4. Appropriately labeling the data set with descriptive variable names
names(data_final_with_names) <- gsub('Acc',"Acceleration",names(data_final_with_names))
names(data_final_with_names) <- gsub('Gyro',"Gyroscope",names(data_final_with_names))
names(data_final_with_names) <- gsub('Mag',"Magnitude",names(data_final_with_names))
names(data_final_with_names) <- gsub('^t',"Time-",names(data_final_with_names))
names(data_final_with_names) <- gsub('^f',"Frequency-",names(data_final_with_names))
names(data_final_with_names) <- gsub('\\.mean',"-Mean",names(data_final_with_names))
names(data_final_with_names) <- gsub('\\.std',"-StandardDeviation",names(data_final_with_names))
colnames(data_final_with_names)


### 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject

data_tidy<- aggregate(. ~subject + activity, data_final_with_names, mean)
data_tidy<- data_tidy[order(data_tidy$subject, data_tidy$activity),]
write.table(data_tidy, file = "data_tidy.txt",row.name=FALSE)
