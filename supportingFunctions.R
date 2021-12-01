## Functions for R project

# Installing packages
library(dplyr)
library(plyr)
library(readr)

# Combining all data from the .csv files in each country's directory to one .csv file. Add country and dayofYear columns.
# Offer options for how to handle the entries with NAs.
csvCombine = function(dir){
  # dir = "~/Desktop/Rproject2021/countryX"
  # NOTE: directory must be the country's directory
  # need to make not as specific
  fileNames=list.files(path=dir, pattern="*.csv", full.names=TRUE)
  allFiles=fileNames %>% 
    lapply(read_csv) %>% 
    bind_rows
  allFiles=data.frame(matrix(ncol = 12, nrow = 0))
  A=as.character(readline(prompt="Be warned about NAs (Y or N): "))
  for (i in 1:length(fileNames)){
    # i (example) = "/Users/helenlaboe/Desktop/Rproject2021/countryX/screen_175.csv"
    # need to make not as specific
    if (A=="Y"){
      addFile=read_csv(fileNames[i])
      addFile$country=substr(dir,start=31,stop=31)
      addFile$dayofYear=substr(fileNames[i],start=56,stop=58)
      allFiles=rbind(allFiles,addFile)
      if(TRUE %in% is.na(addFile)){
        print(paste0((fileNames[i])," contains NA"))
        filesList=list()
        filesList=list(append(filesList,fileNames[i]))
        B=as.character(readline(prompt="Remove rows with NAs (Y or N): "))
        if (B=="Y"){
          addFile=na.omit(addFile)
        }else{
          addFile=read_csv(fileNames[i])
          addFile$country=substr(dir,start=36,stop=36)
          addFile$dayofYear=substr(fileNames[i],start=61,stop=63)
          allFiles=rbind(allFiles,addFile)
        }
      }else{
        addFile=read_csv(fileNames[i])
        addFile$country=substr(dir,start=36,stop=36)
        addFile$dayofYear=substr(fileNames[i],start=61,stop=63)
        allFiles=rbind(allFiles,addFile)
      }
    }else{
      addFile=read_csv(fileNames[i])
      addFile$country=substr(dir,start=36,stop=36)
      addFile$dayofYear=substr(fileNames[i],start=61,stop=63)
      allFiles=rbind(allFiles,addFile)
      print(paste0("These days contained NAs and were removed",filesList))
    }
  }
  write.csv(allFiles,file="csvCombine",row.names=FALSE)
}