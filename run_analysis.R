# 1. Merges the training and the test sets to create one data set.

# 1.1 Reading the train and test data files
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# 1.2 Reading label and features files

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

# 1.3 Labeling the data (step 4)
names(x_train) <- features$V2
names(x_test) <- features$V2
names(y_train) <- "activity"
names(y_test) <- "activity"
names(subject_train) <- "subjectid"
names(subject_test) <- "subjectid"

# 1.4 Merged dataset is column binding of row binding train and test X, Y and Subject
merged_dataset <- cbind(rbind(subject_train, subject_test), rbind(y_train, y_test), rbind(x_train, x_test))

# Cleaning environment
rm(subject_test, subject_train, x_test, x_train, y_test, y_train, features)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
selected_subset <- grepl("(mean|std)[(]", names(merged_dataset))
# Keeping name and subject
selected_subset[1:2] <- TRUE
mean_std_data <- merged_dataset[,selected_subset]
rm(selected_subset, merged_dataset)

# 3. Uses descriptive activity names to name the activities in the data set
mean_std_data$activity <- factor(as.factor(mean_std_data$activity), labels = activity_labels$V2)
rm(activity_labels)
# 4. Appropriately labels the data set with descriptive variable names. 
# (done in step 1.3)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# load resphape2 to use melt to create observations for each subject and activity
# use dcast to calculate the mean for each subject / activity
library(reshape2)
molten_data <- melt(mean_std_data, id.vars = c("subjectid", "activity"))
tidy_data <- dcast(molten_data, subjectid + activity ~ variable, mean)
rm(molten_data)

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)


