## Functions for R project

# Installing packages
library(dplyr)
library(plyr)
library(readr)

# Combining all data from the .csv files in each country's directory to one .csv file. Add country and dayofYear columns.
# Offer options for how to handle the entries with NAs.
csvCombine = function(dir){
  setwd(dir)
  # NOTE: directory must be the country's directory
  fileNames=list.files(path=dir, pattern="*.csv", full.names=TRUE)
  directories=dirname(path=fileNames)
  allFiles=fileNames %>% 
    lapply(read_csv) %>% 
    bind_rows
  allFiles=data.frame(matrix(ncol = 12, nrow = 0))
  # Asks whether the user wants to be warned about NAs in the data
  A=as.character(readline(prompt="Be warned about NAs (Y or N): "))
  for (i in 1:length(fileNames)){
    if (A=="Y"){
      addFile=read_csv(fileNames[i])
      addFile$country=sub(".+([A-Z])", "\\1", directories[i])
      addFile$dayofYear=sub(".+([0-9]{3}).*","\\1",fileNames[i])
      allFiles=rbind(allFiles,addFile)
      if(TRUE %in% is.na(addFile)){
        # Warns user of an NA in the data
        print(paste0((fileNames[i])," contains NA"))
        # Asks whether the user wants to remove rows with NAs in the data
        B=as.character(readline(prompt="Remove rows with NAs (Y or N): "))
        if (B=="Y"){
          addFile=na.omit(addFile)
        }else{
          addFile=read_csv(fileNames[i])
          addFile$country=sub(".+([A-Z])", "\\1", directories[i])
          addFile$dayofYear=sub(".+([0-9]{3}).*","\\1",fileNames[i])
          allFiles=rbind(allFiles,addFile)
        }
      }else{
        addFile=read_csv(fileNames[i])
        addFile$country=sub(".+([A-Z])", "\\1", directories[i])
        addFile$dayofYear=sub(".+([0-9]{3}).*","\\1",fileNames[i])
        allFiles=rbind(allFiles,addFile)
      }
    }else{
      addFile=read_csv(fileNames[i])
      addFile$country=sub(".+([A-Z])", "\\1", directories[i])
      addFile$dayofYear=sub(".+([0-9]{3}).*","\\1",fileNames[i])
      allFiles=rbind(allFiles,addFile)
    }
  }
  write.csv(allFiles,file="csvCombine",row.names=FALSE)
}