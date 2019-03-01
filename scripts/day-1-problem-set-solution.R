### Day 1 Problem Set - Example Solution ###

######################################################################################
#Data from: Isbell, D. R. (2017). An academic definitions test. TESL-EJ, 20(4), 1-28.# 
#http://www.tesl-ej.org/wordpress/issues/volume20/ej80/ej80a2/                       #
######################################################################################

### Set-up ----

#Load Packages
library(tidyverse)
library(CTT)
library(rcrtan)
library(rmarkdown)
library(knitr)

### Reminder: In bottom-right panel "Files", navigate to your folder and set as working directory.
### Use the blue gear icon to set WD

#read in data
data <- read_csv("data/adt_dataset.csv")

### Calculate a new variable ----

#calculate a new variable, total ADT
data$ADT_total <- select(data, 5:14) %>% rowSums(na.rm = T)

### Summarize data ----

#summarize total scores for the whole group
whole_group_summary <- summarise(data, mean = mean(ADT_total, na.rm = T),
                                 sd = sd(ADT_total, na.rm = T),
                                 median = median(ADT_total, na.rm = T),
                                 min = min(ADT_total, na.rm = T),
                                 max = max(ADT_total, na.rm = T))

#plot a histogram of whole group total scores
whole_group_hist <- ggplot(data, aes(x = ADT_total))+
  geom_histogram(binwidth = 1)+
  scale_x_continuous(breaks = 0:10)+
  labs(x = "ADT Total Score", y = "Number of Test-Takers")+
  theme_bw()

#what is the relationship between ADT scores and reading scores?
cor.test(data$ADT_total, data$ReadingTotalScore)

#plot showing relationship between ADT and Reading scores
adt_reading_scatter <- ggplot(data, aes(x = ADT_total, y = ReadingTotalScore))+
  geom_jitter()+
  geom_smooth(method = "lm", se = F)+
  scale_x_continuous(breaks = 0:10)+
  scale_y_continuous(breaks = c(0, 10, 20, 30, 40))+
  labs(x = "ADT Total Score", y = "Reading Score")+
  theme_bw()

### CTT and CRT test and item analyses ----

#CTT analyses
CTT <- itemAnalysis(select(data, 5:14))
CTT$alpha # .79
CTT_item_stats <- CTT$itemReport #now you can look at this df in the viewer. Save as a .csv 
# if you like!

#CRT stats
subkoviak(data, 5:14, 7, 16) # reliability, subkoviak's classification agreement, etc
CRT <- crt_iteman(data, 5:14, 7) #CRT item stats!

#### Student Score Report Loop ----

for (i in unique(data$SubjID)){
  student <- data[data$SubjID == i,]
  render("adt_score_report_template.rmd",output_file = paste0('ADT_score_report_',as.character(student$SubjID),'.pdf'))    
}
