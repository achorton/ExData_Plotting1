setwd("~/Desktop/job/JHDS/ExData_Plotting1/")

## preallocate memory to read huge file
t<-data.frame(cbind(character(2075259),character(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259),numeric(2075259)))

t<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character"))
#subset to desired 2 days for assignment
r<-t[t$Date=="2/2/2007",]
r2<-t[t$Date=="1/2/2007",]
power<-as.data.frame(rbind(r,r2))
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

png(filename = "plot1.png")
hist(power$Global_active_power,
     breaks=c(0,0.5,
              1,1.5,
              2,2.5,
              3,3.5,
              4,4.5,
              5,5.5,
              6,6.5,
              7,7.5),
     right = FALSE,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
#     xlim=c(0,7.5),
#     ylim=c(0,1234),
     xaxp=c(0,6,3),
     yaxp=c(0,1200,6)
#     ,
#     asp=2
     )

    
pin(c(w,h))
xpd=TRUE    
     axes = TRUE, plot = TRUE, labels = FALSE,
     nclass = NULL, warn.unused = TRUE, ...)


png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
     bg = "white",  res = NA, ...,
    type = c("cairo", "cairo-png", "Xlib", "quartz"), antialias)

dev.off()
