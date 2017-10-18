setwd("C:/Users/Rosemary/Documents/445/FoodTrucks")

data <- read.csv('./CustomerOrder.csv', stringsAsFactors = FALSE)

#Need to add 10 MenuNames

menu.names <- c("I Can Show You The World", "Bread is the Devil", "I Love Olives", "Vegemites", "Tacos are Fancy Sandwiches", 
                "Wings", "Sweet Tooth", "No BBQuestions Asked", "Rabbit Food", "Hot Dawg")

colnames(data)

library(dplyr)
install.packages("xlsx")
library(xlsx)

data[nrow(data) + 1, ] = list("Rosemary", "Adams" , "07/19/1996", "10/17/2017")

rename(data,FName = ï..first, LName = last, DOB = birthday, OrderDate = date)

data$MenuName <- rep(menu.names,10000)

write.xlsx(data, "CustomerOrderMenu.xlsx")
