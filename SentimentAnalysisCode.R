# Class Project R Explore -- Chris Blair

#Library
library("XML")
library(tm)
library(wordcloud)
library(SentimentAnalysis)
####


dataset <- read.csv(file.choose(), header = T)

dataset <- dataset[order(-dataset$Impressions), ]

HighestImpressions <- dataset[1:100, ]


# Ad Text -----------------------------------------------------------------



corpus1 = VCorpus(VectorSource(HighestImpressions$AdText))

corpus1

wordcloud(corpus1, max.words=100, random.order = FALSE, colors="blue")

corpus1 <- tm_map(corpus1, removeWords, stopwords("english"))

wordcloud(corpus1, max.words=250, random.order = FALSE, colors="blue")


# Location ----------------------------------------------------------------



corpus2 = VCorpus(VectorSource(HighestImpressions$Location))

corpus1 <- tm_map(corpus1, removeWords, c("United", "States", "United States", "50",
                                          "20", "mi", "km", "living", "in", "living in"))

wordcloud(corpus2, max.words=100, random.order = FALSE, colors="blue")


# Sentiment Analysis ------------------------------------------------------

corpus3 = VCorpus(VectorSource(HighestImpressions$AdText))


sentiment <- analyzeSentiment(corpus3, language = "english", aggregate = NULL,
                 removeStopwords = TRUE, stemming = TRUE)

plotSentiment(sentiment, x = NULL, cumsum = FALSE, xlab = "",
              ylab = "Sentiment")
plotSentimentResponse(sentiment, response, smoothing = "gam",
                      xlab = "Sentiment", ylab = "Response")



# Groups Targetted --------------------------------------------------------

Phrases <- read.csv(file.choose(), header = T)

AA <- Phrases[Phrases$African.American == "African American", ]

Progressive <- Phrases[Phrases$Progressive == "Progressive", ]

Conservative <- Phrases[Phrases$Conservative == "Conservative", ]

Islam <- Phrases[Phrases$Islam == "Islam", ]

Christianity <- Phrases[Phrases$Christianity == "Christianity", ]

Latinx <- Phrases[Phrases$Latinx == "Latinx", ]

LGBTQ	<- Phrases[Phrases$LGBTQ == "LGBTQ", ]

Army	<- Phrases[Phrases$Army == "Army", ]

Police	<- Phrases[Phrases$Police == "Police", ]

AmericanSouth	<- Phrases[Phrases$American.South == "American South", ]

AntiImmigrant	<- Phrases[Phrases$Anti.Immigrant == "Anti-Immigrant", ]

GunRights	<- Phrases[Phrases$Gun.Rights == "Gun Rights", ]

Patriotism	<- Phrases[Phrases$Patriotism == "Patriotism", ]

Memes	<- Phrases[Phrases$Memes == "Memes", ]

Products	<- Phrases[Phrases$Products == "Products", ]

NativeAmerican	<- Phrases[Phrases$Native.American == "Native American", ]

Unknown	<- Phrases[Phrases$Unknown == "Unknown", ]

Geographic	<- Phrases[Phrases$Geographic == "Geographic", ]

Other <- Phrases[Phrases$Other == "Other", ]

Counts <- data.frame("African American" = nrow(AA), 
                     "Progressive" = nrow(Progressive), 
                     "Conservative" = nrow(Conservative),
                     "Islam" = nrow(Islam),
                     "Christianity" = nrow(Christianity),
                     "Latinx" = nrow(Latinx),
                     "LGBTQ" = nrow(LGBTQ),
                     "Army" = nrow(Army),
                     "Police" = nrow(Police),
                     "AmericanSouth" = nrow(AmericanSouth),
                     "AntiImmigrant" = nrow(AntiImmigrant),
                     "GunRights" = nrow(GunRights),
                     "Patriotism" = nrow(Patriotism),
                     "Memes" = nrow(Memes),
                     "Products" = nrow(Products),
                     "NativeAmerican" = nrow(NativeAmerican),
                     #"Unknown" = nrow(Unknown),
                     "Geographic" = nrow(Geographic),
                     "Other" = nrow(Other))

Counts <- t(Counts)

colnames(Counts)[1] <- "Number of Phrases"

Counts <- data.frame(Counts)

Counts <- Counts[order(-Counts$Number.of.Phrases), ,drop=F]

CountsTop10 <- Counts[1:10, , drop=F]

ggplot() + geom_bar(data = CountsTop10, 
                    aes(x=reorder(rownames(CountsTop10), -CountsTop10$Number.of.Phrases), 
                        y=CountsTop10$Number.of.Phrases), stat="identity") +
  labs(title = "Groups Targetted by Frequency of Political Phrase", x = "Group Targetted", y = "Amount of Phrases")

# Ads per month --------------------------------------------------------

     
shortDate <- dataset
shortDate$CreationDate <- paste(substr(shortDate$CreationDate, 1, 2), substr(shortDate$CreationDate, 7, 8), sep="/")

ads2015 <- shortDate[substr(shortDate$CreationDate, 4, 5) == "15",]
ads2016 <- shortDate[substr(shortDate$CreationDate, 4, 5) == "16",]
ads2017 <- shortDate[substr(shortDate$CreationDate, 4, 5) == "17",]

ggplot(data = ads2015) +
    geom_bar(aes(x = CreationDate, fill = CreationDate)) +
    labs(title = "2015 Advertisements by Month\n", x = "Month/Date", y = "Count")

ggplot(data = ads2016) +
    geom_bar(aes(x = CreationDate, fill = CreationDate)) +
    labs(title = "2016 Advertisements by Month\n", x = "Month/Date", y = "Count")

ggplot(data = ads2017) +
    geom_bar(aes(x = CreationDate, fill = CreationDate)) +
    labs(title = "2017 Advertisements by Month\n", x = "Month/Date", y = "Count")