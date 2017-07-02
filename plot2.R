library(data.table)

#get working directory and append subdirectory
hse_engy_file <- file.path(getwd(),"Exploratory Data Analysis/week1/household_power_consumption/household_power_consumption.txt")
hse.engy <- data.table(read.table(hse_engy_file,
                                  stringsAsFactors = FALSE,
                                  sep=";",
                                  na.strings = "?",
                                  header = TRUE))  ##missing values are indicated as "?"

#check some summary stats
head(hse.engy)
summary(hse.engy)


hse.engy$Date <- as.Date(hse.engy$Date, "%d/%m/%Y") # convert to variable to date format

library(lubridate)
#create a datetime variable from Date and Time columns
hse.engy$datetime <- ymd_hms(apply(hse.engy[,1:2], 1, paste, collapse=" "))


#subset based on the dates we are interested in  2007-02-01 and 2007-02-02.
hse_data_range <- hse.engy[Date>="2007-02-01" & Date<="2007-02-02"]


#check how many dates are in the range being looked at
table(hse_data_range$Date)


#summary
summary(hse_data_range)
str(hse_data_range)
names(hse_data_range)


#CREATE PLOTS
#Plot 2
with(hse_data_range, plot(datetime, Global_active_power, type="n",  xlab = "",
                          ylab="Global Active Power (kilowatts)"),
     xaxt = "n")
lines(hse_data_range$datetime, hse_data_range$Global_active_power )
title(xaxt = "n")

#copy to file PNG
dev.copy(png, file = file.path(getwd(),"Exploratory Data Analysis/ExData_Plotting1/plot2.png"), 
         width = 480, height = 480, units="px")
dev.off()