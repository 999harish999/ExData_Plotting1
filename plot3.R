## PLOT 3

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

# 3. Plot 2 : sub_Meetering (1,2,3) Vs weekdays

## 3.1 join date and time columns 

dateWithTime<-ymd_hms(paste(data$Date,data$Time))

## 3.2 plot sub_meetering 

plot(dateWithTime,data$Sub_metering_1,ylab = "Energy sub metering",xlab="",type = "ln")
points(dateWithTime,data$Sub_metering_2,type = "ln",col="red")
points(dateWithTime,data$Sub_metering_3,type = "ln",col="blue")

colors<-c("black","red","blue")
legendnames<-c("sub_metering_1","sub_metering_2","sub_metering_3")
legend("topright",col = colors,legend = legendnames,lty = c(1,1,1),cex=0.6)

# 4. Save plot to png file "plot1.png"

dev.copy(png,file="plot3.png")
dev.off()
