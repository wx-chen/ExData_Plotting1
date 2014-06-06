# Plot4.R

library(data.table)
HousePower <- fread("housepower.txt", sep=";",head=TRUE,na.strings = "?",nrow=70000)
HousePower[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#install.packages("dplyr")
library(dplyr)
HPowerJul <- filter(HousePower, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 00:00:00"))

HPowerJul$Global_active_power <- as.numeric(HPowerJul$Global_active_power)

HPowerJul$Sub_metering_1 <- as.numeric(HPowerJul$Sub_metering_1)
HPowerJul$Sub_metering_2 <- as.numeric(HPowerJul$Sub_metering_2)
HPowerJul$Sub_metering_3 <- as.numeric(HPowerJul$Sub_metering_3)

HPowerJul$Voltage <- as.numeric(HPowerJul$Voltage)
HPowerJul$Global_reactive_power <- as.numeric(HPowerJul$Global_reactive_power)

# find Thu->Fri change
MinDay<-1
MaxDay<-length(HPowerJul$Global_active_power)
WKD<-weekdays(HPowerJul$DateTime)
d<-diff(HPowerJul$DateTime)
Thu2Fri<-which(d==1)
xlocs<-c(MinDay,Thu2Fri,MaxDay)
xticklab<-c("Thu","Fri","Sat")
x=1:MaxDay

# Plot
par(mfrow=c(2,2),mar=c(4,4,2,1)) #,pin=c(1.75,1.2) 

#subplot 1,1
plot(x,HPowerJul$Global_active_power,type="n",xlab="",ylab="Global Active Power",xaxt='n') #, ann=FALSE
lines(x,HPowerJul$Global_active_power,type="l")
axis(1,at=xlocs, labels=xticklab, pos=-0.07)

#subplot 1,2
plot(x,HPowerJul$Voltage,type="n",xlab="datetime",ylab="Voltage",xaxt='n') #, ann=FALSE
lines(x,HPowerJul$Voltage,type="l")
axis(1,at=xlocs, labels=xticklab, pos=232.5)

#subplot 2,1
plot(x,HPowerJul$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",xaxt='n') #, ann=FALSE
lines(x,HPowerJul$Sub_metering_1,type="l",col="black")
lines(x,HPowerJul$Sub_metering_2,type="l",col="red")
lines(x,HPowerJul$Sub_metering_3,type="l",col="blue")
legend("topright",pch="", lwd=1,col=c("black","red","blue"),bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),text.font=0.5)

axis(1,at=xlocs, labels=xticklab, pos=-1.5)

#subplot 2,2
plot(x,HPowerJul$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power",xaxt='n') #, ann=FALSE
lines(x,HPowerJul$Global_reactive_power,type="l")
axis(1,at=xlocs, labels=xticklab, pos=-0.02)


## Print to png
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
