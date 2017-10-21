setwd("C:/Users/Rosemary/Documents/445/FoodTrucks")

data <- read.csv('./CustomerOrder.csv', stringsAsFactors = FALSE)

#Need to add 10 MenuNames

menu.names <- c("I Can Show You The World", "Bread is the Devil", "I Love Olives", "Vegemites", "Tacos are Fancy Sandwiches", 
                "Wings", "Sweet Tooth", "No BBQuestions Asked", "Rabbit Food", "Hot Dawg")

colnames(data)

library(dplyr)
#install.packages("xlsx")
library(xlsx)

data[nrow(data) + 1, ] = list("Rosemary", "Adams" , "07/19/1996", "10/17/2017")

rename(data,FName = ï..first, LName = last, DOB = birthday, OrderDate = date)

data$MenuName <- rep(menu.names,10000)

write.xlsx(data, "CustomerOrderMenu.xlsx")

############################################################################

indan.menu.item <- c("Curry", "Naan", "Chai")
gluten.free.menu.item <- c("pizza", "pasta", "beer")
greek.menu.items <- c("gyro", "baclava", "spanakopida")
vegan.menu.items <- c("hummus", "soup", "panini")
wings.menu.items <- c("spicy wings", "ranch wings", "soda")
dessert.menu.items <- c("ice cream", "chocolate fruit", "sorbet")
korean.bbq.menu.items <- c("hambao", "chicken", "pork")
salad.menu.items <- c("kale", "beans", "cesear")
american.menu.items <- c("hot dog", "hamburger", "milkshake")

################################################################################
data <- read.xlsx('./CustomerOrderMenu.xlsx', stringsAsFactors = FALSE, 1)
library(xlsx)


