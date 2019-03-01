#load packages
library(tidyverse)
library(rmarkdown)
library(knitr)

#load data
test_results_2 <- here::here('data/placement_2.csv') %>%
  read_csv(.)

#compute total and part scores
test_results_2 <- test_results_2 %>%
  mutate(total = rowSums(.[5:69], na.rm = TRUE),
         list_total = rowSums(select(., contains('_list_')), na.rm = TRUE),
         read_total = rowSums(select(., contains('_read_')), na.rm = TRUE))

#compute mean, save these values
total_mean <- mean(test_results_2$total, na.rm = TRUE)
list_mean <- mean(test_results_2$list_total, na.rm = TRUE)
read_mean <- mean(test_results_2$read_total, na.rm = TRUE)

test_results_rep <- slice(test_results_2, 1:5)


#loop for generating individual score reports
#student <- filter(d, ID == "358") #just for testing/building the Rmarkdown template

for (i in unique(test_results_rep$ID)){
  student <- test_results_rep %>% filter(ID == i)
  doc_path <- here::here('documents/')
  here::here('documents/score-report-template.Rmd') %>%
  rmarkdown::render(., output_file = paste0(doc_path, 'Score_Report_', as.character(student$names),'.pdf'))
}
