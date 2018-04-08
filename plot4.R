# plot4.R
# by Mark Smith
#
# Please ensure "household_power_consumption.txt" as extracted from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# is available in the working directory of the script
#
# I have chosen to leave the background as white as the transparent
# background the demonstration files was causing me problems in multiple
# viewing programs that default to black as the background.
#
# Comments are in line.
#
# To run:
# source("plot4.R")

library(ggplot2)
library(data.table)
library(dplyr)
library(lubridate)

# Read in the raw data, specifying ? as a NA value
rawdata <- fread("household_power_consumption.txt", na.strings=c("NA", "?"))
# Filter the data by strings initially (much much faster than converting to 
# a datetime first) and then combine the Date and Time values into one value
filteredData <- filter(rawdata, Date %in% c("1/2/2007","2/2/2007")) %>%
     mutate(Date = as.POSIXct(dmy(Date) + hms(Time)))

# Open up "plot4.png" as the graphics device
png(filename = "plot4.png",  width = 480, height = 480, units = "px")

# Set up the output for 4 plots
# the margins can be shrunk with mar=c(4, 4, 1, 1)) but leaving the defaults
# looks more like the example
par(mfrow=c(2,2))

# 1 (top right): Global Active Power
with(filteredData, 
     plot(Date, 
          Global_active_power, 
          type="l", 
          ylab="Global Active Power", 
          xlab="")
     )

# 2 (top left): Voltage
with(filteredData, 
     plot(Date, 
          Voltage, 
          type="l", 
          ylab="Voltage", 
          xlab="datetime")
     )

# 3 (bottom left): Energy sub metering
# Complex plot so we add to it after the inital generation
# Base with Sub_metering_1
with(filteredData, 
     plot(Date, 
          Sub_metering_1, 
          type="l", 
          ylab="Energy sub metering", 
          xlab="",
          col="black")
     )
# Add Sub_metering_2
with(filteredData,
     lines(Date, 
           Sub_metering_2, 
           col="red")
     )
# Add Sub_metering_3
with(filteredData,
     lines(Date, 
           Sub_metering_3, 
           col="blue")
     )
# Add the legend
legend("topright", 
       col=c("black", "red", "blue"), 
       lwd=c(1),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")

# 4 (bottom right): Global_reactive_power
with(filteredData, 
     plot(Date, 
          Global_reactive_power, 
          type="l", 
          ylab="Global_reactive_power", 
          xlab="datetime")
     )

# Close the output file plot4.png
dev.off()

# Let the user know it's complete
print("Output generated successfully.")
