library(reshape2)
library(data.table)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data/UCIDataset.zip")){download.file (fileUrl, destfile = "./data/UCIDataset.zip", method="curl")}
if(!file.exists("./UCI HAR Dataset")){unzip(zipfile = "./data/UCIDataset.zip")}
subtrain <- read.delim("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
xtrain <- read.delim("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
ytrain <- read.delim("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
feat <- read.delim("./UCI HAR Dataset/features.txt", header=FALSE, sep="")
names(xtrain) <- feat$V2
aclabel <- read.delim("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")
ytrain$V1 <- factor(ytrain$V1, levels= aclabel$V1, labels = aclabel$V2)
tidytrain <- cbind(subtrain, ytrain)
names(tidytrain)<- c("subject","activity")
tidytrain <- cbind(tidytrain, xtrain)

subtest <- read.delim("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
xtest <- read.delim("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
ytest <- read.delim("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
names(xtest) <- feat$V2
ytest$V1 <- factor(ytest$V1, levels= aclabel$V1, labels = aclabel$V2)
tidytest <- cbind(subtest, ytest)
names(tidytest)<- c("subject","activity")
tidytest <- cbind(tidytest, xtest)

rbind(tidytrain, tidytest) -> result
resmeanstd <- select(result,  "subject", "activity", c(grep("mean", names(result))), c(grep("std", names(result))))
meltres <- melt(resmeanstd, id= c("subject", "activity"))
res <- dcast(meltres, subject + activity ~ variable, mean)
str(res)
if(!file.exists("./tidydata.txt")){write.table(res, "tidydata.txt", quote=FALSE, row.names = FALSE)}