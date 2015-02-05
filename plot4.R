require(dplyr)
require(lubridate)

#store langugage settings
user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

#read in data
hpc <- read.csv("./household_power_consumption.txt",
                sep=";", na.strings="?",
                stringsAsFactors=FALSE)

#clean up Date and select only the right dates
hpc2 <- hpc %>%
    mutate(Date = dmy_hms(paste(Date, Time, sep = "-"))) %>%
    select(-Time) %>%
    filter(Date >= ymd("2007-02-01") & Date < ymd("2007-02-03"))

#open png device for storing the graph
png(file = "plot4.png", width = 480, height = 480, units = "px",
    bg = "white")

par(mfrow = c(2, 2))

#create graphs

with(hpc2, plot(Date, Global_active_power, type = "l", xlab = "",
                ylab = "Global Active Power"))


with(hpc2, plot(Date, Voltage, type = "l", xlab = "datetime"))

with(hpc2, {
    plot(Date, Sub_metering_1, type = "n", xlab = "",
         ylab = "Energy sub metering")
    lines(Date, Sub_metering_1, col = "black")
    lines(Date, Sub_metering_2, col = "red")
    lines(Date, Sub_metering_3, col = "blue")
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"),
           lwd = 1,
           bty = "n",
           cex = 0.9
           )
})

with(hpc2, plot(Date, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()

#restore language
Sys.setlocale("LC_TIME", user_lang)
