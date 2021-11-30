## Functions for R project

# Installing packages
library(dplyr)
library(plyr)
library(readr)

# Combining all data from the .csv files in each country's directory to one .csv file. Add country and dayofYear columns.
# Offer options for how to handle the entries with NAs.
csvCombine = function(dir,country){
  fileNames=list.files(path=dir, pattern="*.csv", full.names=TRUE)
  allFiles=fileNames %>% 
    lapply(read_csv) %>% 
    bind_rows
  A=as.character(readline(prompt="Be warned about NAs (yes or no): "))
  for (i in 1:length(fileNames)){
    if (A=="yes"){
      addFile=read_csv(fileNames[i])
      #addFile$dayofYear still trying to figure out this part
      if(TRUE %in% is.na(addFile)){
        print(paste0((fileNames[i])," contains NA"))
        filesList=list()
        filesList=list(append(filesList,fileNames[i]))
        B=as.character(readline(prompt="Remove rows with NAs (yes or no): "))
        if (B=="yes"){
          addFile=na.omit(addFile)
        }else{
          addFile=read_csv(fileNames[i])
          #addFile$dayofYear 
          allFiles=rbind(allFiles,addFile)
        }
      }else{
        addFile=read_csv(fileNames[i])
        #addFile$day
        allFiles=rbind(allFiles,addFile)
      }
    }else{
      print(paste0("These days contained NAs and were removed",filesList))
    }
  }
  # allFiles$country still trying to figure out this part
  write.csv(allFiles,file="csvCombine",row.names=FALSE)
}