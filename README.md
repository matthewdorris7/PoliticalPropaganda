
# Introductory Data Analytics and Visualization Political Propaganda Project
# Did Russia interfere with the 2016 Election?

## Background Information
The 2016 election marked the first time a foreign nation was suspected of tampering with and influencing US citizens through Social Media. Our dataset pertains directly to this issue, all of these ads are sourced by the cryptic Internet Research Agency (IRA), a Moscow-backed group that sought to sow discontent and misinformation during the presidential election.

## Description of Dataset:
The dataset contains social media data, specifically Facebook and Twitter data, that the Permanent Select
Committee on Intelligence of the US House of Representatives deemed sourced by the cryptic Internet Research Agency (IRA). The Facebook data provided advertisement text, data on ad social engagement, amount of money spent per advertisement, and other advertisement related data.

## My Role on the Team
Which political ideology are the advertisements meant to support?
***See NaiveBayesClassifierIdeologyText.R***

### Approach and Methodology
  Ideally, we want to know how Russia targeted specific political ideologies when advertising on Facebook during the time leading up to the election. We approached this problem by focusing on the AdText and PeopleWhoMatch features in the FacebookAds.csv file. The AdText feature consisted of advertisements by Russia during election time which were typically 40-120 words long. Each of these advertisements were connected to a political ideology in the PeopleWhoMatch feature. There were 17 different political ideologies an AdText could be classified as. A few examples of these political ideologies include “Being Patriotic”, “LGBT United”, “Don’t Shoot” amongst others. We wanted to create our own classification algorithm that would predict which of the 17 political groups a specific advertisement fell under. We decided the best way to do this was through a Naive Bayes classification algorithm for the Adtext, using each of the 17 political ideologies as classes. The Naive Bayes algorithm learns the probability of an object with certain features belonging to a particular class. It will ultimately classify Adtext based on probability and Bayesian statistics.
  
  When coding the algorithm, our first step was to clean the advertisement text data so we can optimize the algorithm’s performance. This ultimately yielded a data set with the political ideologies associated with each Adtext. The next step was to randomize this data set so there wouldn’t be any unwarranted biases. Next, a corpus was created to clean the data even further by transforming it to lowercase, removing punctuation, removing numbers, removing stop words, and stripping any whitespace in the text. A document term matrix was generated so the Naive Bayes classification could be implemented. 75% of the data was used as training data, and 25% of the data was used as testing data.
  
### Conclusion
The Naive Bayes classification algorithm was a good model for predicting political ideology. It had a classification accuracy of 70.47%. The model yielded a Kappa statistic of .572. A Kappa statistic compares observed accuracy with an expected accuracy due to random chance. .572 can be interpreted as moderate to good agreement. If we were given a Russian advertisement, we are very confident we would be able to classify it into the correct political ideology with a classification accuracy of 70.47%.


## Project Conclusion
We were able to conclude that an outside entity, specifically we believe to be the Russia's Internet Research Agency, was responsible for posting the Ads that disproportionately targeted African Americans and primarily focused on Liberal Ideologies as the content of their ads.
