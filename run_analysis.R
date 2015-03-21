library(dplyr)
library(reshape2)
#setwd("F://Drive//R//Clean_Data_PROJ")

###
# Load the datasets and labels
Xtrain <- read.table(".//UCI HAR Dataset//train//X_train.txt")
Ytrain <- read.table(".//UCI HAR Dataset//train//Y_train.txt")
Xtest <- read.table(".//UCI HAR Dataset//test//X_test.txt")
Ytest <- read.table(".//UCI HAR Dataset//test//Y_test.txt")

labels <- read.table(".//UCI HAR Dataset//activity_labels.txt")
labels <- tbl_df(labels)


#### Make vector of unique names
names <- read.table(".//UCI HAR Dataset//features.txt")
names <- paste(names[[1]],names[[2]])
####


XTE <- tbl_df(Xtest)
XTR <- tbl_df(Xtrain)
YTR <- tbl_df(Ytrain)
YTE <- tbl_df(Ytest)

### 4 - Appropriately labels the data set with descriptive variable names. 
colnames(XTE) <- names
colnames(XTR) <- names

XTE <- cbind(Dataset = rep("test",nrow(XTE)),XTE)
XTR <- cbind(Dataset = rep("train",nrow(XTR)),XTR)

########### 1 - MERGE ###########
DataS <- rbind(XTE,XTR)
################################

### 2- Extracts only the measurements on the mean and standard deviation for each measurement.
DataS1 <- DataS %>% select( contains("Dataset"),contains("mean(") , contains("std("))
################################


### 3 - Uses descriptive activity names to name the activities in the data set
Ys <- rbind(YTE, YTR)
Ys <- inner_join(Ys,labels, by="V1")
DataS2 <- cbind(Ys=Ys[[2]],DataS1)
################################



### 5 - From the data set in step 4, 
### creates a second, independent tidy data set
### with the average of each variable for each
### activity and each subject.

DataS3 <- DataS2 %>% group_by(Dataset,Ys) %>% summarise_each(funs(mean)) %>% melt(id.vars = c("Dataset", "Ys"))


### Export

write.table(DataS3, "F://Drive//R//Getting_and_Cleaning//", sep=";", row.names=FALSE)
