Getting_and_Cleaning_Data
=========================

* Download and unzip the data from the source:
  ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
  into a folder on your local drive into a folder e.g.: C:/myFolder/data

* Save the file 'run_analysis.R' under C:/myfolder

* in  R shell or RStudio: copy working path and paste it into the setwd command at the begining of the 'run_analysis.R' Skript
 e.g.: setwd('C:/myFolder/')

  then: run('run_analysis.R')

* The latter will run the R script, it will read the dataset and write these files:

  merged_clean_data.txt  -- 8.35 Mb, a 10299x68 data frame

  data_set_with_the_averages.txt  -- 0.225 Mb, a 180x68 data frame
