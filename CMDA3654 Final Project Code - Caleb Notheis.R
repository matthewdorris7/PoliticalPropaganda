# @author   Caleb Notheis
# @version  11.26.2018

# Group Project for CMDA 3654, Fall 2018
# Cleaning date/time, plotting PDT vs MSK, and generating tables
# ========================
# Import data (ads only) and install relevant packages
ads <- read.csv("C:/Users/Caleb/Documents/VT/2018 - 2019/CMDA3654/Project/CMDA3654PoliticalPropaganda-master/FacebookAds.csv") 

# install.packages("ISLR")
# install.packages("lubridate")
library("ISLR")
library("ggplot2")
library("lubridate")    # For manipulation of Time data

# ========================
# Clean time data
ads2 <- ads     # Copy data set for modification (out of personal preference)
# Isolate posting times and put them in their own column
ads2$pdtTime <- mdy_hms(as.character(ads2$CreationDate), tz = "America/New_York")
# Moscow is 10 hours ahead of PDT, so add 10 hours
ads2$rusTime <- ads2$pdtTime + hours(10)
# Modify data to have hours only for easy discrete plotting
ads2$pdtHour <- hour(ads2$pdtTime)
ads2$rusHour <- hour(ads2$rusTime) 

# ========================
# PDT vs MSK plot
timePlot <- ggplot(data = ads2, aes(x = hour(pdtTime), y = hour(rusTime)))
timePlot + geom_point() + geom_jitter() + labs(title = "Ad Posting Time - Pacific vs Moscow Time (24HR)", 
                                               x = "Pacific Daylight Time",
                                               y = "Moscow Time (PDT + 10)")

# ==========================
# TABLE CONSTRUCTION BY TIME
n <- length(ads2$rusHour)
x <- c(1:n)
# Use for-loop and ifelse statement to build columns of time table
for (i in x) {
  ifelse (ads2$rusHour[i] > 8 && ads2$rusHour[i] < 20, ads2$rusWorkTime[i] <- 1, ads2$rusWorkTime[i] <- 0)
}
# Factorize and check work
ads2$rusWorkTime <- as.factor(ads2$rusWorkTime)
summary(ads2$rusWorkTime)

# Create table
rusTable <- table(ads2$rusWorkTime)
names(rusTable) <- c("Off-hours", "Work Hours")
rusTable

# ========================
# Currency Table
summary(ads2$AdSpendCurrency)
curTable <- table(ads2$AdSpendCurrency)
names(curTable) <- c("NA", "RUB", "USD")
curTable
