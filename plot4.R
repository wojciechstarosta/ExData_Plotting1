library(lubridate)
epc<-read.csv2("./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE)
epc$datetime <- paste(epc$Date, epc$Time)
epc$datetime <- dmy_hms(epc$datetime)
epc_fin <- epc[(epc$datetime >= ymd("2007-02-01") & epc$datetime < ymd("2007-02-03")),]
epc_fin[,3:9] <- sapply(epc_fin[,3:9], as.numeric)

png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
par(mar = c(4, 4.5, 2, 1))
with(epc_fin, plot(Global_active_power ~ datetime, type = "l",ylab = "Global active power (kilowatts)", xlab = NA))

with(epc_fin, plot(Voltage ~ datetime, type = "l",ylab = "Voltage", xlab = "datetime"))

with(epc_fin, plot(Sub_metering_1 ~ datetime, type = "n",ylab = "Energy sub metering", xlab = NA))
lines(epc_fin$datetime, epc_fin$Sub_metering_1, col = "black")
lines(epc_fin$datetime, epc_fin$Sub_metering_2, col = "red")
lines(epc_fin$datetime, epc_fin$Sub_metering_3, col = "blue")
legend("topright", bty = "n",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

with(epc_fin, plot(Global_reactive_power ~ datetime, type = "l",ylab = "Global reactive power (kilowatts)", xlab = "datetime"))

dev.off()