## Analysis for R project

source("supportingFunctions.R")

# Compile all data into a .csv file
countryXdf=read.csv("~/Desktop/practicedirectory/countryX/csvCombine",header=TRUE)
countryYdf=read.csv("~/Desktop/practicedirectory/countryY/csvCombine",header=TRUE)
merge(countryXdf,countryYdf)

# Process data to answer questions and provide graphical evidence
## In which country (X or Y) did the outbreak likely begin?
# Count number of each marker in each country
# Plot each infection over time in each country (compare on a plot)
# Number of cases occurring when and where
## If Country Y develops a vaccine for the disease, is it likely to work for Country X?
# Focused on the end of data (types and strains of bacteria in countries now)
