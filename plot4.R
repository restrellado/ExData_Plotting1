setwd("~/Documents/github/ExData_Plotting1")
url.name <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url.name, destfile = "hpc.zip", method = "curl")
unzip("hpc.zip")
hpc <- read.csv2("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE)
# Filter dates
# Convert to date
library(dplyr)
hpc <- tbl_df(hpc)
hpc.2 <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
hpc.2$Date <- paste(hpc.2$Date, hpc.2$Time, sep = " ")
library(lubridate)
hpc.2$Date <- dmy_hms(hpc.2$Date)
hpc.2$Global_active_power <- as.numeric(hpc.2$Global_active_power)
hpc.2$Sub_metering_1 <- as.numeric(hpc.2$Sub_metering_1)
hpc.2$Sub_metering_2 <- as.numeric(hpc.2$Sub_metering_2)
hpc.2$Sub_metering_3 <- as.numeric(hpc.2$Sub_metering_3)
hpc.2$Voltage <- as.numeric(hpc.2$Voltage)
hpc.2$Global_reactive_power <- as.numeric(hpc.2$Global_reactive_power)
# Plot 3
png(filename = "plot4.png")
par(mfrow = c(2, 2))
# Global active power and date
with(hpc.2, plot(Date, Global_active_power,
                 type = "l",
                 ylab = "Global Active Power"))
# Voltage and date
with(hpc.2, plot(Date, Voltage,
                 type = "l",
                 xlab = "datetime"))
# Energy submetering and date
with(hpc.2, plot(Date, Sub_metering_1,
                 type = "l",
                 ylab = "Energy sub metering"))
lines(hpc.2$Date, hpc.2$Sub_metering_2, col = "red")
lines(hpc.2$Date, hpc.2$Sub_metering_3, col = "blue")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Global reactive power and date
with(hpc.2, plot(Date, Global_reactive_power,
                 type = "l",
                 xlab = "datetime"))
dev.off()