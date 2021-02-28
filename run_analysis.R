require(dplyr)

#read the test and train data
filenames = list.files("./UCI HAR Dataset/test",pattern = ".txt", full.names = TRUE)
test = sapply(filenames,read.table)
filenames = list.files("./UCI HAR Dataset/train",pattern = ".txt", full.names = TRUE)
train = sapply(filenames,read.table)

#combine the test and train into full
full = mapply(rbind, test, train, SIMPLIFY = FALSE)
sapply(full, nrow) #check that we combined correctly

#give names to the columns
names(full[[1]]) = "Subject"
xnames = read.table("./UCI HAR Dataset/features.txt")
names(full[[2]]) = xnames[,2]
names(full[[3]]) = "activity"

#select the relavant columns
cols = grep("mean[^F]|std", xnames[,2]) #we don't want meanFreq
names(full[[2]][,cols]) #check that we selected columns correctly
x = full[[2]][,cols]

#combine the lists into one data frame
df = cbind(full[[1]],full[[3]],x)

#replace activity numbers with descriptive names
activitynames = read.table("./UCI HAR Dataset/activity_labels.txt")
df = merge(activitynames, df, by.x = "V1", by.y = "activity")
df = df[,-1] #remove the activity numbers
names(df)[1] = "Activity" #rename V2 to Activity

#give descriptive names to variables
names(df) = gsub("^t","Time.",names(df))
names(df) = gsub("^f","Frequency.",names(df))
names(df) = gsub("Acc","Accelerometer.",names(df))
names(df) = gsub("Gyro","Gyrometer.",names(df))
names(df) = gsub("mean\\(\\)","Mean.",names(df))
names(df) = gsub("std\\(\\)","Std.Dev.",names(df))
names(df) = gsub("Mag","Magnitude.",names(df))
names(df) = gsub("-","",names(df))
names(df) = gsub("BodyBody","Body",names(df))
names(df)

#get mean by subject and activity
df_bysub_act = df %>% group_by(Subject,Activity) %>% summarise_all(mean)

#write to file
write.csv(df_bysub_act, "tidydata.txt", row.names = FALSE)

