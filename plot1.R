## Function name: plot1
## Purpose: To generate a histogram of the energy data from 
##          2007-02-01 to 2007-02-02.
## Parameters:  None
## Returns: A histgram of the global active powerstored in plot1.png in 
##          the working directory
plot1 <- function() {
    ##load necessary packages
    library(lubridate)
    
    #load and filter data
    dataset <- read.delim("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))
    head(dataset)
    dataset$Date <- dmy(dataset$Date)
    dateCheck <- as.Date(c("2007-02-01","2007-02-02"))
    twoDays <- dataset[dataset$Date %in% dateCheck,]
    
    ##generate histogram
    hist(twoDays$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
    
    ##save as .png
    dev.copy(png,"plot1.png")
    dev.off()
}