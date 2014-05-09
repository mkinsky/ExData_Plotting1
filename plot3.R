#This script creates the plot3.png file for Coursera's Exploratory Data Analysis course's first
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
plot.file.name <- "plot3.png"
date.1 <- "1/2/2007" #DD/MM/YYYY
date.2 <- "2/2/2007" #DD/MM/YYYY

#Load and filter the electric power consumption data.table
hpc <- read.table(file = data.file.name, sep = ";", header = T)
#hpc$Date <- as.character(hpc$Date)
epc <- as.data.table(filter(hpc, Date == date.1 | Date == date.2))
rm(hpc)

#Cast columns to different data types
wDays <- strptime(paste(epc$Date, epc$Time), format='%d/%m/%Y %H:%M:%S')
epc$Sub_metering_1 <- as.double(as.character(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.double(as.character(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.double(as.character(epc$Sub_metering_3))

#Generate plot3
png(file = plot.file.name, width = 480, height = 480)
par(mfrow = c(1,1))
with(epc, plot(wDays, epc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col = "Black"))
lines(wDays, epc$Sub_metering_2, type="l", col = "Red")
lines(wDays, epc$Sub_metering_3, type="l", col = "Blue")
legend("topright",cex=0.8, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
