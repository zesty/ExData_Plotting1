
data = read.table("household_power_consumption.txt", sep=";", header=T, as.is=T)

data$Date = as.Date(data$Date, format="%d/%m/%Y")

d1 = as.Date("1/2/2007", format="%d/%m/%Y")
d2 = as.Date("2/2/2007", format="%d/%m/%Y")
d = subset(data, data$Date %in% c(d1,d2))

d$dt <- strptime(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")

d$Global_active_power <- as.numeric( d$Global_active_power )
d$Global_reactive_power <- as.numeric( d$Global_reactive_power )
d$Voltage <- as.numeric( d$Voltage )
d$Global_intensity <- as.numeric( d$Global_intensity )
d$Sub_metering_1 <- as.numeric( d$Sub_metering_1 )
d$Sub_metering_2 <- as.numeric( d$Sub_metering_2 )
d$Sub_metering_3 <- as.numeric( d$Sub_metering_3 )

################################

png(filename = "plot2.png", width = 480, height = 480)
plot(d$dt, d$Global_active_power, ylab="Global Active Power (kilowatts)", type='l', xlab='', xaxt='n')
# now label every day on the time axis
r <- as.POSIXct(round(range(d$dt), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
dev.off()
