getCleanDS<-function() {
trainDS<-read.table("train/X_train.txt")
trainActivities<-read.table("train/y_train.txt")
testDS<-read.table("test/X_test.txt")
testActivities<-read.table("test/y_test.txt")
activities<-read.table("activity_labels.txt")
combinedDS<-rbind(trainDS,testDS)
combinedActivities<-rbind(trainActivities,testActivities)

features<-read.table("features.txt")
onlyDS<-grepl("mean\\(\\)|std\\(\\)",features[,2])

requiredDS<-combinedDS[,onlyDS]

featuresNames<-features[onlyDS,2]
colnames(requiredDS)<-featuresNames

activitiesNames<-merge(combinedActivities,activities,by.x = "V1",by.y = "V1")
fullDS<-cbind(activitiesNames[,2],requiredDS)
colnames(fullDS)[1]<-"ACTIVITIES"

cleanDS<-fullDS %>% group_by(ACTIVITIES) %>% summarise_each(funs(mean))
write.table(cleanDS,file="cleanDS.txt",row.names = FALSE)
}