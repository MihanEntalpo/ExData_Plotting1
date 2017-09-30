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
    if (!file.exists(filename))
    {
        print("Downloading data file...")
        zipfile = paste(filename, ".zip", sep="")
        url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, destfile=zipfile, method="curl")
        print("Unpacking file...")
        unzip(zipfile)
    }
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

png(filename = "plot2.png", width = 480, height = 480, units="px", bg="white")

plot(
    info$DateTime, info$Global_active_power, col = "black", type="l",
    main = "Global Active Power", xlab = "Global Active Power (kilowatts)"
)

dev.off()
