## Analysis for R project

source("supportingFunctions.R")

# Installing packages
library(ggplot2)
library(cowplot)

# Compile all data into a .csv file
countryXdf=read.csv("~/Desktop/practicedirectory/countryX/csvCombine",header=TRUE)
countryYdf=read.csv("~/Desktop/practicedirectory/countryY/csvCombine",header=TRUE)
merge(countryXdf,countryYdf)

# Process data to answer questions and provide graphical evidence

## In which country (X or Y) did the outbreak likely begin?
# Cases over time in country X
countryXcases=data.frame(matrix(nrow=,ncol=2))
colnames(countryXcases)=c("dayofYear","dailyCases")

for (d in 120:175){
  dailyCases=sum(rowSums(countryXdf[countryXdf$dayofYear %in% d, 3:12]))
  dailyCases=data.frame(d,dailyCases)
  colnames(dailyCases)=c("dayofYear","dailyCases")
  countryXcases=rbind(countryXcases,dailyCases)
}

countryXcases=na.omit(countryXcases)

# Cases over time in country Y
countryYcases=data.frame(matrix(nrow=,ncol=2))
colnames(countryYcases)=c("dayofYear","dailyCases")

for (d in 120:175){
  dailyCases=sum(rowSums(countryYdf[countryYdf$dayofYear %in% d, 3:12]))
  dailyCases=data.frame(d,dailyCases)
  colnames(dailyCases)=c("dayofYear","dailyCases")
  countryYcases=rbind(countryYcases,dailyCases)
}

countryYcases=na.omit(countryXcases)

# Plot infections over time in each country (compare on a plot)
ggplot()+
  geom_line(data=countryXcases, aes(x=dayofYear,y=dailyCases), color="red")+
  geom_line(data=countryYcases, aes(x=dayofYear,y=dailyCases), color="blue")+
  xlab("Day of Year")+
  ylab("Number of Cases")

## If Country Y develops a vaccine for the disease, is it likely to work for Country X?
# Focused on the end of data (types and strains of bacteria in countries now)
