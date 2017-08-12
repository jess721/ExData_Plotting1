## Function name: plot2
## Purpose: To generate a plot of the energy data from 
##          2007-02-01 to 2007-02-02.
## Parameters:  None
## Returns: A plot of the global active power stored in plot2.png in 
##          the working directory
plot2 <- function() {
    ##load necessary packages
    library(lubridate)
    library(dplyr)
    
    #load and filter data
    dataset <- read.delim("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))
    head(dataset)
    dataset$Date <- dmy(dataset$Date)
    dateCheck <- as.Date(c("2007-02-01","2007-02-02"))
    twoDays <- dataset[dataset$Date %in% dateCheck,]
    twoDays <- mutate(twoDays, Instant = as_datetime(paste(twoDays$Date,twoDays$Time)))
    
    ##generate plot
    plot(twoDays$Instant,twoDays$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    
    ##save as .png
    dev.copy(png,"plot2.png")
    dev.off()
}