#load packages
library(tidyverse)
library(psych)
library(eRm)

#load data
d <- read_csv("data/placement_1.csv")

items <- select(d, 5:39)

#Quick description of total score distribution
mean(rowSums(items))
sd(rowSums(items))

hist(rowSums(items))

#CTT reliability
reliability <- psych::alpha(items)
reliability$total

#Rasch analysis
##run it
rasch <- RM(items)
rasch_person <- person.parameter(rasch)
rasch_person_ability <- coef(rasch_person)

#mean item ease
summary(rasch)
mean(rasch$betapar)

#mean person ability
mean(rasch_person_ability)

#person separation
rasch_person_reliability <- SepRel(rasch_person)
summary(rasch_person_reliability)

#Wright Map
wright <- plotPImap(rasch)

#Item Stats
item_stats <- itemfit(rasch_person)
item_stats