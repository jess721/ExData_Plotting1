## Function name: plot4
## Purpose: To generate four plots of the energy data from 
##          2007-02-01 to 2007-02-02.
## Parameters:  None
## Returns: Four plots of the global active power stored in plot4.png in 
##          the working directory
plot4 <- function() {
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
    
    ##change width
    par(mfcol = c(2,2))
    
    ##generate plot 1
    plot(twoDays$Instant,twoDays$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    
    ##generate plot 2
    plot(submeteringData$Instant,submeteringData$Value, type = "n", xlab ="", ylab ="Energy sub metering")
    points(submeteringData$Instant[submeteringData$Submetering == "Sub_metering_1"], submeteringData$Value[submeteringData$Submetering == "Sub_metering_1"], type = "l")
    points(submeteringData$Instant[submeteringData$Submetering == "Sub_metering_2"], submeteringData$Value[submeteringData$Submetering == "Sub_metering_2"], type = "l", col = "red")
    points(submeteringData$Instant[submeteringData$Submetering == "Sub_metering_3"], submeteringData$Value[submeteringData$Submetering == "Sub_metering_3"], type = "l", col = "blue")
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"), cex = 0.75, bty = "n")
    
    ##generate plot 3
    plot(twoDays$Instant,twoDays$Voltage, xlab = "datetime", ylab = "voltage", type = "l")
    
    ##generate plot 4
    plot(twoDays$Instant, twoDays$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
    
    ##save as .png
    dev.copy(png,"plot4.png")
    dev.off()
}