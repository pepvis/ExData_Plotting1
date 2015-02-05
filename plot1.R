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
png(file = "plot1.png", width = 480, height = 480, units = "px",
    bg = "white")

#create graph
with(hpc2, hist(Global_active_power, col = "red", main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)"))

dev.off()

#restore language
Sys.setlocale("LC_TIME", user_lang)
