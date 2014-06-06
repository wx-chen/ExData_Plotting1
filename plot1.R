library(data.table)
HousePower <- fread("housepower.txt", sep=";",head=TRUE,na.strings = "?",nrow=70000)
HousePower[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


#install.packages("dplyr")
library(dplyr)
HPowerJul <- filter(HousePower, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 00:00:00"))

HPowerJul$Global_active_power <- as.numeric(HPowerJul$Global_active_power)
hist(HPowerJul$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")


dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()



