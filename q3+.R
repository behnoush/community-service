# #The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# 
# https://dl.dropbox.com/u/7710864/data/csv_hid/ss06hid.csv or here 
# 
# https://spark-public.s3.amazonaws.com/dataanalysis/ss06hid.csv 
# 
# and load the data into R. You will use this data for the next several questions. The code book, describing the variable names is here: 
#   
#   https://dl.dropbox.com/u/7710864/data/PUMSDataDict06.pdf or here: 
#   
#   https://spark-public.s3.amazonaws.com/dataanalysis/PUMSDataDict06.pdf 
# 
# How many housing units in this survey were worth more than $1,000,000?


fileName <-"https://dl.dropbox.com/u/7710864/data/csv_hid/ss06hid.csv"
download.file(fileName, destfile="./ComSer.csv", method="curl")
data<-read.csv("ComSer.csv")
dim(data)
names(data)
class(data)
sapply(data[1,],class)
table(data$VAL)


# Use the data you loaded from Question 3. Consider the variable FES. Which of the "tidy data" principles does this variable violate?
table(data$FES)
sapply(data$FES, class)

# Use the data you loaded from Question 3. How many households have 3 bedrooms and and 4 total rooms? How many households have 2 bedrooms and 5 total rooms? How many households have 2 bedrooms and 7 total rooms?
table(data$RMS==4 & data$BDS == 3)
table(data$RMS==5 & data$BDS == 2)
table(data$RMS==7 & data$BDS == 2)

#or
subdata <- data[data$RMS==4 & data$BDS == 3, c("RMS","BDS")]
table(subdata)

# Use the data from Question 3. Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
# 
# which(agricultureLogical) 
# What are the first 3 values that result?
agricultureLogical<-data$ACR==3 & data$AGS == 6
#table(agricultureLogical)
which(agricultureLogical)

# Use the data from Question 3. Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE and assign it to the variable indexes. 
# 
# indexes =  which(agricultureLogical) 
# If your data frame for the complete data is called dataFrame you can create a data frame with only the above subset with the command: 
#   
#   subsetDataFrame  = dataFrame[indexes,] 
# Note that we are subsetting this way because the NA values in the variables will cause problems if you subset directly with the logical statement. How many households in the subsetDataFrame have a missing value for the mortgage status (MRGX) variable?

agricultureLogical<-data$ACR==3 & data$AGS == 6
indexes <- which(agricultureLogical)
subsetDataFrame  = data[indexes,] 
sum(is.na(subsetDataFrame$MRGX))


#Use the data from Question 3. Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?
strnames = strsplit(names(data),"wgtp")

#What are the 0% and 100% quantiles of the variable YBL? Is there anything wrong with these values? Hint: you may need to use the na.rm parameter.
quantile(data$YBL, na.rm = T)