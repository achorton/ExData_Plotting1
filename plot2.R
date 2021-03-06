#install.packages("plotrix",repos="http://cran.wustl.edu")
#library(plotrix)
setwd("~/Desktop/job/JHDS/ExData_Plotting1/")

## preallocate memory to read huge file
t<-data.frame(cbind(character(2075259),character(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259)))

t<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character"))
#subset to desired 2 days for assignment
r<-t[t$Date=="2/2/2007",]
r2<-t[t$Date=="1/2/2007",]
power<-as.data.frame(rbind(r2,r))
#free up memory
rm(t,r,r2)

#convert from class=="character" to class=="POSIXct" "POSIXt"
realDateTime<-strptime(paste(power$Date,power$Time,sep=","), "%d/%m/%Y,%H:%M:%S")
power<-as.data.frame(cbind(power,realDateTime))
names(power)[10]<-"datetime"
#convert from class=="character" to class=="Date"
realDate<-as.Date(power$Date, format="%d/%m/%Y")
power$Date<-realDate

#reassign "?" values to NA and
#convert from class=="character" to class=="numeric" for remaining data

power$Global_active_power[power$Global_active_power=="?"]<-"NA"
power$Global_active_power<-as.numeric(power$Global_active_power)

power$Global_reactive_power[power$Global_reactive_power=="?"]<-"NA"
power$Global_reactive_power<-as.numeric(power$Global_reactive_power)

power$Voltage[power$Voltage=="?"]<-"NA"
power$Voltage<-as.numeric(power$Voltage)

power$Global_intensity[power$Global_intensity=="?"]<-"NA"
power$Global_intensity<-as.numeric(power$Global_intensity)

power$Sub_metering_1[power$Sub_metering_1=="?"]<-"NA"
power$Sub_metering_1<-as.numeric(power$Sub_metering_1)

power$Sub_metering_2[power$Sub_metering_2=="?"]<-"NA"
power$Sub_metering_2<-as.numeric(power$Sub_metering_2)

power$Sub_metering_3[power$Sub_metering_3=="?"]<-"NA"
power$Sub_metering_3<-as.numeric(power$Sub_metering_3)

# Open device, configure and plot histogram, write and close device
png(filename = "plot2.png")

plot(cbind(power$datetime,
     power$Global_active_power),
     xlab="",
     ylab="Global Active Power (kilowatts)",
     xaxt="n",
     yaxp=c(0,6,3),
     type="l")

axis(1, at=c(min(power$datetime[power$Date=="2007-02-01"]),mean(power$datetime),max(power$datetime[power$Date=="2007-02-02"])),labels=c("Thu", "Fri", "Sat"))

dev.off()
