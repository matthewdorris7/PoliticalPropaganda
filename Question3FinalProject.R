# Groups Targetted --------------------------------------------------------


rm(list=ls())
setwd("c:/Users/khann/CS3654/CMDA3654PoliticalPropaganda")


Phrases <- read.csv(file = "interests_annotated_final.csv", header = T)


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


library("ggplot2")
ggplot() + geom_bar(data = CountsTop10, 
                    aes(x=reorder(rownames(CountsTop10), -CountsTop10$Number.of.Phrases), 
                        y=CountsTop10$Number.of.Phrases), stat="identity") +
  labs(title = "Groups Targeted by Frequency of Political Phrase", x = "Group Targeted", y = "Amount of Phrases")


chisq.test(CountsTop10,p=c(0.2,0.089,0.089,0.089,0.089,0.089,0.089,0.089,0.089,0.088))

chisq.test(CountsTop10,p=c(0.3,0.078,0.078,0.078,0.078,0.078,0.078,0.078,0.077,0.077))











