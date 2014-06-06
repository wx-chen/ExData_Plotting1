## Plot3.R

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

# find Thu->Fri change
MinDay<-1
MaxDay<-length(HPowerJul$Global_active_power)
WKD<-weekdays(HPowerJul$DateTime)
d<-diff(HPowerJul$DateTime)
Thu2Fri<-which(d==1)
xlocs<-c(MinDay,Thu2Fri,MaxDay)
xticklab<-c("Thu","Fri","Sat")
x=1:MaxDay

## Plot
par(mar=c(3,4,2,1))
plot(x,HPowerJul$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",xaxt='n') #, ann=FALSE
lines(x,HPowerJul$Sub_metering_1,type="l",col="black")
lines(x,HPowerJul$Sub_metering_2,type="l",col="red")
lines(x,HPowerJul$Sub_metering_3,type="l",col="blue")
legend("topright",pch="", lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

axis(1,at=xlocs, labels=xticklab, pos=-1.5)


## Print to png
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()

