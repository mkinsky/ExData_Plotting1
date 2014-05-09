#This script creates the plot4.png file for Coursera's Exploratory Data Analysis course's first
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
plot.file.name.4.4 <- "plot4-4.png"
plot.file.name <- "plot4.png"
date.1 <- "1/2/2007" #DD/MM/YYYY
date.2 <- "2/2/2007" #DD/MM/YYYY

#Load and filter the electric power consumption data.table
hpc <- read.table(file = data.file.name, sep = ";", header = T)
#hpc$Date <- as.character(hpc$Date)
epc <- as.data.table(filter(hpc, Date == date.1 | Date == date.2))
rm(hpc)

#Cast columns to different data types
wDays <- strptime(paste(epc$Date, epc$Time), format='%d/%m/%Y %H:%M:%S')
epc$Voltage <- as.double(as.character(epc$Voltage))
epc$Global_reactive_power <- as.double(as.character(epc$Global_reactive_power))
epc$Global_active_power <- as.double(as.character(epc$Global_active_power))
epc$Sub_metering_1 <- as.double(as.character(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.double(as.character(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.double(as.character(epc$Sub_metering_3))

#Generate plot4
par(mfrow = c(2,2))
#Upper-Left
plot(wDays, epc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)") 
#Upper-Right
plot(wDays, epc$Voltage, type="l", xlab="datetime", ylab="Voltage") 
#Bottom-Left
plot(wDays, epc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col = "Black")
lines(wDays, epc$Sub_metering_2, type="l", col = "Red")
lines(wDays, epc$Sub_metering_3, type="l", col = "Blue")
legend("topright",cex=0.8, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Bottom-Right
plot(wDays, epc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") 

#Push global_reactive_power.png to a png format
dev.copy(png, plot.file.name.4.4, width = 480, height = 480)
dev.off()
