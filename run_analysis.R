library("data.table")
library("reshape2")

labs <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
feats <- read.table("./UCI HAR Dataset/features.txt")[,2]

#grab mean and stdev
regextext <- grepl("mean|std", feats)

xt <- read.table("./UCI HAR Dataset/test/X_test.txt")
yt <- read.table("./UCI HAR Dataset/test/y_test.txt")
st <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(xt) = feats
xt = xt[,regextext]
yt[,2] = labs[yt[,1]]
names(yt) = c("Activity_ID", "Activity_Label")
names(st) = "subject"
#mash together final test
testfinal <- cbind(as.data.table(st), yt, xt)

#copy/paste above for training set above process for train...
xt2 <- read.table("./UCI HAR Dataset/train/X_train.txt")
yt2 <- read.table("./UCI HAR Dataset/train/y_train.txt")
st2 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(xt2) = feats
xt2 = xt2[,regextext]
yt2[,2] = labs[yt2[,1]]
names(yt2) = c("Activity_ID", "Activity_Label")
names(st2) = "subject"
#mash together final test
trainfinal <- cbind(as.data.table(st2), yt2, xt2)

#final data
datafinal = rbind(testfinal, trainfinal)

ids = c("subject", "Activity_ID", "Activity_Label")
datalabs = setdiff(colnames(datafinal), ids)
meltdat = melt(datafinal, id = ids, measure.vars = datalabs)
#dcast for useful crosstable
datasummary = dcast(meltdat, subject + Activity_Label ~ variable, mean)

write.table(datasummary, file = "./tidy_data.txt")