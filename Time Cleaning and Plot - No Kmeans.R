# @author   Caleb Notheis
# @version  11.26.2018

# Group Project for CMDA 3654, Fall 2018
# Cleaning date/time and plotting as PDT vs MSK
# ========================
# Import data (ads only) and install relevant packages
ads <- read.csv("C:/Users/Caleb/Documents/VT/2018 - 2019/CMDA3654/Project/CMDA3654PoliticalPropaganda-master/FacebookAds.csv") 

# install.packages("ISLR")
# install.packages("lubridate")
library("ISLR")
library("ggplot2")
library("lubridate")

# ========================
# Clean time data
ads2 <- ads     # Copy data set for modification (out of personal preference)
# Isolate posting times and put them in their own column
ads2$pdtTime <- mdy_hms(as.character(ads2$CreationDate), tz = "America/New_York")
# Moscow is 11 hours ahead of PDT, so add 11 hours
ads2$rusTime <- ads2$pdtTime + hours(11)
# Modify data to have hours only for easy discrete plotting
ads2$pdtHour <- hour(ads2$pdtTime)
ads2$rusHour <- hour(ads2$rusTime) 

# PDT vs MSK plot
timePlot <- ggplot(data = ads2, aes(x = hour(pdtTime), y = hour(rusTime)))
timePlot + geom_point() + geom_jitter() + labs(title = "Pacific vs Moscow Time (EDA)", 
                                               x = "Pacific Daylight Time",
                                               y = "Moscow Time (PDT + 11)")

