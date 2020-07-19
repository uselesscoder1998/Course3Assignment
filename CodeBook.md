# Course3Assignment
First the dataset is downloaded and stored to datafiles.zip
The data is then unzipped
Then each and every data frame is accessed by attaching an appropriate column name
Testing and Training data sets are merged using rbind for X , Y and Subject and then completely merged using cbind for X, Y and Subject and stored in mergedata
TidyData is extracted from mergedata as per the mean and standard deviation conditions
Each activity in TidyData is named using the activitylabes file from the unzipped file
Descriptive names are added using the gsub function by replacing every shortened name with a longer version
FinalData is created as per the instructions summarized by mean
FinalData is made into a Final Tidy Data as a text file.
