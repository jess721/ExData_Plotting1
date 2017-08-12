## Function name: plot3
## Purpose: To generate a plot of the energy data from 
##          2007-02-01 to 2007-02-02.
## Parameters:  None
## Returns: A plot of the energy submetering overtime stored in plot3.png in 
##          the working directory
plot3 <- function() {
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
    submeteringData <- twoDays[,7:10]
    submeteringData <- gather(submeteringData, Submetering, Value, -Instant)
    
    ##generate plot
    plot(submeteringData$Instant,submeteringData$Value, type = "n", xlab ="", ylab ="Energy sub metering")
    points(submeteringData$Instant[submeteringData$Submetering == "Sub_metering_1"], submeteringData$Value[submeteringData$Submetering == "Sub_metering_1"], type = "l")
    points(submeteringData$Instant[submeteringData$Submetering == "Sub_metering_2"], submeteringData$Value[submeteringData$Submetering == "Sub_metering_2"], type = "l", col = "red")
    points(submeteringData$Instant[submeteringData$Submetering == "Sub_metering_3"], submeteringData$Value[submeteringData$Submetering == "Sub_metering_3"], type = "l", col = "blue")
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"), cex = 0.75)
    
    ##save as .png
    dev.copy(png,"plot3.png")
    dev.off()
}
 