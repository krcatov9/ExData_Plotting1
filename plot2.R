# Make sure you're in the working directory that includes your files!
# First part downloads the portion of the data we need to look at,
# namely the first two days of 2007
one<-read.table("household_power_consumption 3.txt",skip=grep("1/2/2007", readLines("household_power_consumption 3.txt")),nrows=2880,sep=";",na.strings = "?")
names(one)<-c("Date","Time","Global Active Power","Global Reactive Power","Voltage","Global Intensity","Sub Metering 1","Sub Metering 2", "Sub Metering 3")
Date<-as.Date(one$Date,"%d/%m/%Y")
one$Date=Date
trydate<-as.character(one$Date)
trytime<-as.character(one$Time)
i<-1:2880
DateTime<-paste(trydate[i],trytime[i],sep=" ")
DateTime<-as.POSIXct(DateTime,format="%Y-%m-%d %H:%M:%S")
one$Time=DateTime
one<-one[,2:9]
names(one)<-c("DateTime","Global Active Power","Global Reactive Power","Voltage","Global Intensity","Sub Metering 1","Sub Metering 2", "Sub Metering 3")

# Second part is specific to the graph
png2<-plot(one$DateTime,one$"Global Active Power",pch=NA,ylab="Global Active Power (kilowatts)",xlab=NA)
lines(one$DateTime,one$`Global Active Power`)

dev.print(png,"plot2.png",width=480,height=480)
dev.off()

