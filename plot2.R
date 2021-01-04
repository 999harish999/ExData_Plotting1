## PLOT 2 

## 1. Download data file

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"


if(!file.exists("household_power_consumption.zip")){
  download.file(fileurl,destfile = "household_power_consumption.zip")
}

if(!file.exists("household_power_consumption.txt")){
  unzip(zipfile = "household_power_consumption.zip",files = "household_power_consumption.txt")
}

# 2. Read Data and Format data

columnclass<-c("char","char",rep("numeric",7))
completeData<-read.table("household_power_consumption.txt",sep = ";",header = TRUE)
library(lubridate)
completeData$Date<-dmy(completeData$Date)


## 2.1 subset data for 1st and 2nd Feb 2007
library(dplyr)
data<-filter(completeData,Date=="2007-02-01" | Date=="2007-02-02" )

## 2.2 convert columns to suitable class
#data$Time<-hms(data$Time)
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

#_______________________________________________________________________________

# 3. Plot 2 : Global active Power Vs weekdays

## 3.1 join date and time columns 

dateWithTime<-ymd_hms(paste(data$Date,data$Time))

## 3.2 plot Global active power vs datewithTime

plot(dateWithTime,data$Global_active_power,type = "ln",ylab = "Global Active Power(killowatts)",
     xlab = "")

# 4. Save plot to png file "plot1.png"

dev.copy(png,file="plot2.png")
dev.off()

