
run.analysis<-function(){
      
      #----------------------------------------------------------------------
      #>>>>>>>>>>>>>>>>>>>>>>>>>>>Course Project<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      #----------------------------------------------------------------------
      #PULLING DATA >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            #Hope working directory has been set at proper location. 
            Test_Data <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
            Train_Data <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
            test_id <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
            train_id <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
            features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
            activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")
            activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
            activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
      library(reshape2)
      library(stringr)
      library(plyr)
      #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      
      #combining test and train data
      CombinedData<-rbind(Test_Data, Train_Data)
      rm(Test_Data, Train_Data)
      
      #combinind the test and train data subject ids
      subject_ids<-rbind(test_id, train_id)
      
      #Combining the Test and train activity ids
      activity_ids<-rbind(activity_test,activity_train);activity_ids<-activity_ids$V1
      
      #adding subject ids to the combined data 
      CombinedData<-cbind(subject_ids,activity_ids, CombinedData)
      #head(CombinedData[,1:5])      #checking if subject_ids have been appended as first column
      
      #adding activity description to the model
      colnames(activity_labels)<-c("ID", "Activity_Desc")
      CombinedData<-merge(CombinedData, activity_labels, by.x="activity_ids", by.y="ID", all=T)
      CombinedData<-CombinedData[,c(2,1,ncol(CombinedData),3:(ncol(CombinedData)-1))]
      #ncol(CombinedData)
      
      #adding colnames to the combined data
      lab_data<-as.vector(features$V2)
      lab_data<-c("Subject_ID","Activity_ID","Activity_Desc",lab_data)
      colnames(CombinedData)<-lab_data          #setting column names
      
      #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      
      #Extracts only the measurements on the mean and standard deviation for each measurement
      casemean<-str_detect(lab_data, ignore.case(("mean")))
      casestd<-str_detect(lab_data, ignore.case(("std")))
      cases<-as.logical(c(1,1,1,rep(0,561))+casemean+casestd) #cases is a logical vector which identifies the useful columns
      CombinedData<-CombinedData[,cases]
      #colnames(CombinedData)
      
      #Getting the average of each variable by Subject_ID and Activity_ID
      CombinedData<-aggregate(.~Subject_ID+Activity_ID+Activity_Desc,CombinedData,mean)
      #colnames(CombinedData)
      
      #creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      CombinedTidy<-melt(CombinedData, id=c("Subject_ID", "Activity_ID", "Activity_Desc"), 
                         measure.vars =colnames(CombinedData[4:ncol(CombinedData)]))
      
      
      #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      
      #writing the tidy dataset into Tidy_Data.txt
      write.table(CombinedTidy, "./UCI HAR Dataset/Tidy_Data.txt", sep="\t",row.names = F)
}
