
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

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
plot(d$dt, d$Global_active_power, ylab="Global Active Power", type='l', xlab='', xaxt='n')
r <- as.POSIXct(round(range(d$dt), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")

plot(d$dt, d$Voltage, ylab="Voltage", type='l', xlab='datetime', xaxt='n')
r <- as.POSIXct(round(range(d$dt), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")

plot(d$dt, d$Sub_metering_1, ylab="Energy sub metering", type='l', xlab='', xaxt='n')
r <- as.POSIXct(round(range(d$dt), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
lines(d$dt, d$Sub_metering_2, col='red')
lines(d$dt, d$Sub_metering_3, col='blue')
legend("topright", pch="-", lty=1, col=c('black', 'red', 'blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.9, bty='n')

plot(d$dt, d$Global_reactive_power, ylab="Global_reactive_power", type='l', xlab='datetime', xaxt='n')
r <- as.POSIXct(round(range(d$dt), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
dev.off()
