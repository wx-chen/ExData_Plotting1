## Plot2.R

library(data.table)
HousePower <- fread("housepower.txt", sep=";",head=TRUE,na.strings = "?",nrow=70000)
HousePower[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#install.packages("dplyr")
library(dplyr)
HPowerJul <- filter(HousePower, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 00:00:00"))

HPowerJul$Global_active_power <- as.numeric(HPowerJul$Global_active_power)

# find Thu->Fri change
MinDay<-1
MaxDay<-length(HPowerJul$Global_active_power)
WKD<-weekdays(HPowerJul$DateTime)
d<-diff(HPowerJul$DateTime)
Thu2Fri<-which(d==1)
xlocs<-c(MinDay,Thu2Fri,MaxDay)
xticklab<-c("Thu","Fri","Sat")
x=1:MaxDay


par(mar=c(3,5,3,1))
plot(x,HPowerJul$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)",xaxt='n') #, ann=FALSE
lines(x,HPowerJul$Global_active_power,type="l")
axis(1,at=xlocs, labels=xticklab, pos=-0.07)

# print to png
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

