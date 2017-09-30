# Import libraries
library(stringr)
library(dplyr)
library(lubridate)
library(lattice)

# Set current working dir to dir, there this script is located
scriptPath <- function() {
    getSrcDirectory(scriptPath);
}
setwd(scriptPath())

# function, that loading data
load_data = function() {
    filename = paste(getwd(), "household_power_consumption.txt", sep="/")
    print("Reading data...")
    data = read.table(filename, header=TRUE, sep=";", na.strings = "?")
    data$Date = as.Date(data$Date, "%d/%m/%Y")
    data$DateTime = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
    print("Filtering by date...")
    dates = as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
    data = subset(data, Date %in% dates)
    print("Done")
    return (data)
}

if (!exists("info"))
{
    info = load_data()
}

png(filename = "plot3.png", width = 480, height = 480, units="px", bg="white")

plot(
    info$DateTime, info$Sub_metering_1, col = "black", type="l",
    main = "", xlab = "", ylab = "Energy sub metering"
)
lines(
    info$DateTime, info$Sub_metering_2, col = "red" 
)
lines(
    info$DateTime, info$Sub_metering_3, col = "blue"
)
legend(
    "topright", legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
    col=c("black", "red", "blue"), lty=1, lwd=1
)

dev.off()
