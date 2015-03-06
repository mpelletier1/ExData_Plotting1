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
png(filename = "plot4.png",bg = "transparent")


##set up for tile plotting
par(mfrow = c(2, 2), mar=c(5.1,4.1,3.1,2.1), oma=c(1.5,2,1,1))

##Set up tile 1
plot(house_power$DateTime,house_power$Global_active_power,type="l", yaxt="n",
     xlab="", ylab="Global Active Power")
axis(2,cex.axis=0.9)

##set up tile 2
plot(house_power$DateTime,house_power$Voltage,type="l", yaxt="n", cex.lab=0.90,
     xlab="datetime", ylab="Voltage")
axis(2,cex.axis=0.9)

##Set up tile 3
plot(house_power$DateTime,house_power$Sub_metering_1,type="n", yaxt="n", xlab="", 
     ylab="Energy sub metering")
##btn="n" removed the box around the legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", 
       col=c("black","red","blue"), lty=1)
points(house_power$DateTime,house_power$Sub_metering_1,type="l",col="black")
points(house_power$DateTime,house_power$Sub_metering_2,type="l",col="red")
points(house_power$DateTime,house_power$Sub_metering_3,type="l",col="blue")
axis(2,cex.axis=0.9)

##set up tile 4
##Note that las orients labels relative to axis 
##This allowed the x-axis tick labels to 'fit'
plot(house_power$DateTime,house_power$Global_reactive_power, type="l", yaxt="n", 
     cex.lab=0.90, xlab="datetime", ylab="Global_reactive_power")
axis(2,cex.axis=0.85)


##Close device
dev.off()