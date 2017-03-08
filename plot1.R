library(lubridate)
epc<-read.csv2("./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE)
epc$datetime <- paste(epc$Date, epc$Time)
epc$datetime <- dmy_hms(epc$datetime)
epc_fin <- epc[(epc$datetime >= ymd("2007-02-01") & epc$datetime < ymd("2007-02-03")),]
epc_fin[,3:9] <- sapply(epc_fin[,3:9], as.numeric)

png(file = "plot1.png", width = 480, height = 480, units = "px")
with(epc_fin, hist(Global_active_power, col = "red", xlab = "Global active power (kilowatts)",  main = "Global Active Power"))
dev.off()