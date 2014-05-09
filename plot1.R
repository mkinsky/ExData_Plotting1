#This script creates the plot1.png file for Coursera's Exploratory Data Analysis course's first
#programming assignment.
#
# 8 May 2014
#
# Mark Kinsky

rm(list=ls()) #Clear all objects

#Load required packages
require(dplyr)
require(data.table)

#Set working directory
working.dir <- "C://Education//Exploratory Data Analysis//Homework"
setwd(working.dir)

#Initialize character vectors
data.file.name <- "household_power_consumption.txt"
plot.file.name <- "plot1.png"
date.1 <- "1/2/2007" #DD/MM/YYYY
date.2 <- "2/2/2007" #DD/MM/YYYY

#Load and filter the electric power consumption data.table
hpc <- read.table(file = data.file.name, sep = ";", header = T)
hpc$Date <- as.character(hpc$Date)
epc <- as.data.table(filter(hpc, Date == date.1 | Date == date.2))
rm(hpc)

#Cast columns to different data types
epc$Global_active_power <- as.double(as.character(epc$Global_active_power))

#Generate plot1
hist(epc$Global_active_power, main = "Global Active Power", col = "Red", xlab = "Global Active Power (kilowatts)")

#Push plot1 to a png format
dev.copy(png, plot.file.name, width = 480, height = 480)
dev.off()
