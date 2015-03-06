setwd("C:/Documents and Settings/peg/Coursera/Explore_Data_Anal/Project_1")
setwd("M:/School/Coursera/Explore_Data_Anal_Project_1")

##Download dataset from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##Unzip data and save to local directory

##load in data, remember that this is ';' delineated, and NAs indicated by '?'
house_power_all<-read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

##convert Date from factor to date
house_power_all$Date<-as.Date(house_power_all$Date,"%d/%m/%Y")

##subset data for only the 2 days of interest
house_power<-house_power_all[(house_power_all$Date=="2007-02-01" | house_power_all$Date=="2007-02-02"),]

##convert data and time to character - common format for strptime()
house_power$Date<-as.character(house_power$Date)
house_power$Time<-as.character(house_power$Time)

##paste together date and time
date_time<-paste(house_power$Date,house_power$Time)

##create new DateTime variable
house_power$DateTime<-strptime(date_time,"%Y-%m-%d %H:%M:%S")

##open device and set up file, default is 480 x 480 pixels, 12 pt size
png(filename = "plot2.png",bg = "transparent")
##set up plot
plot(house_power$DateTime,house_power$Global_active_power,type="l",xlab="", 
     ylab="Global Active Power (kilowatts)")
##Close device
dev.off()

