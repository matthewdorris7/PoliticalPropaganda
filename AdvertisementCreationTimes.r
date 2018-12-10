library(ggplot2)
library(lubridate)
library(factoextra)

ads <- read.csv(file = "C:/Users/Daniel/OneDrive/Documents/Virginia Tech/Senior Year/Fall 2018/CMDA 3654/CMDA3654PoliticalPropaganda/FacebookAds.csv", header = TRUE, sep = ",", na.strings = c("","NA"))

ads.standardizedDates <- subset(ads, !is.na(CreationDate))
ads.standardizedDates$CreationDate <- mdy_hms(as.character(ads.standardizedDates$CreationDate), tz = "America/New_York")

ads.standardizedDates$Month <- format(ads.standardizedDates$CreationDate, "%B", levels = month.abb)
ads.standardizedDates$Week <- strtoi(week(ads.standardizedDates$CreationDate))
ads.standardizedDates$Day <- strtoi(yday(ads.standardizedDates$CreationDate))

ads2015 <- ads.standardizedDates[substr(ads.standardizedDates$CreationDate, 1, 4) == "2015",]
ads2016 <- ads.standardizedDates[substr(ads.standardizedDates$CreationDate, 1, 4) == "2016",]
ads2017 <- ads.standardizedDates[substr(ads.standardizedDates$CreationDate, 1, 4) == "2017",]

# Monthly Barplots

## 2015
ggplot(data = ads2015) +
    geom_bar(aes(x = factor(Month, levels = month.name), fill = Month)) +
    labs(title = "2015 Advertisements by Month\n", x = "Month", y = "Count")

## 2016
ggplot(data = ads2016) +
    geom_bar(aes(x = factor(Month, levels = month.name), fill = Month)) +
    labs(title = "2016 Advertisements by Month\n", x = "Month", y = "Count")

## 2017
ggplot(data = ads2017) +
    geom_bar(aes(x = factor(Month, levels = month.name), fill = Month)) +
    labs(title = "2017 Advertisements by Month\n", x = "Month", y = "Count")


# Regression by Days (Failed)

## 2016
adsByDay2016 <- data.frame(table(ads2016$Day))

fitl <- lm(Var1 ~ poly(Freq, degree=1), data = adsByDay2016)
summary(fitl)

fitq <- lm(Var1 ~ poly(Freq, degree=2), data = adsByDay2016)
summary(fitq)

fitc <- lm(Var1 ~ poly(Freq, degree=3), data = adsByDay2016)
summary(fitc)

ggplot(data = adsByDay2016, aes(x = Var1, y = Freq)) + geom_point() +
    geom_smooth(method = "lm", se = F, col = "tomato") +
    geom_smooth(method = "lm", formula = "y ~ poly(x, 2, raw = TRUE)", se = F, col = "steelblue") +
    geom_smooth(method = "lm", formula = "y ~ poly(x, 3, raw = TRUE)", se = F, col = "seagreen")


# Clustering by Days

## 2015
adsByDay2015 <- data.frame(table(ads2015$Day))
adsByDay2015$Var1 <- sapply(adsByDay2015[, 1], as.numeric)
adsByDay2015.scaled <- data.frame(scale(adsByDay2015))
fviz_nbclust(adsByDay2015.scaled, kmeans, method = "wss")

km4.2015 <- kmeans(adsByDay2015.scaled, 4)
fviz_cluster(km4.2015, data = adsByDay2015.scaled)

## 2016
adsByDay2016 <- data.frame(table(ads2016$Day))
adsByDay2016$Var1 <- sapply(adsByDay2016[, 1], as.numeric)
adsByDay2016.scaled <- data.frame(scale(adsByDay2016))
fviz_nbclust(adsByDay2016.scaled, kmeans, method = "wss")

km3.2016 <- kmeans(adsByDay2015.scaled, 3)
fviz_cluster(km3.2016, data = adsByDay2015.scaled)

## 2017
adsByDay2017 <- data.frame(table(ads2017$Day))
adsByDay2017$Var1 <- sapply(adsByDay2017[, 1], as.numeric)
adsByDay2017.scaled <- data.frame(scale(adsByDay2017))
fviz_nbclust(adsByDay2017.scaled, kmeans, method = "wss")

km3.2017 <- kmeans(adsByDay2017.scaled, 3)
fviz_cluster(km3.2017, data = adsByDay2017.scaled)
