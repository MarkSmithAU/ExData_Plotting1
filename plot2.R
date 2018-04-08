# plot2.R
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
# source("plot2.R")

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

# Open up "plot2.png" as the graphics device
png(filename = "plot2.png",  
    width = 480, 
    height = 480, 
    units = "px")

#Generate the plot
with(filteredData, 
     plot(Date, 
          Global_active_power, 
          type="l", 
          ylab="Global Active Power (kilowatts)", 
          xlab="")
     )

# Close the output file plot2.png
dev.off()

# Let the user know it's complete
print("Output generated successfully.")
