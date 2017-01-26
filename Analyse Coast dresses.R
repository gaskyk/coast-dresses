##############################################
###                                        ###
###  Analyse data about Coast dresses      ###
###  from web scraped data                 ###
###                                        ###
##############################################

## Import libraries
library(ggplot2)
library(reshape2)

## Import data and look at it
data <- read.csv("C:/Users/ONS-BIG-DATA/Documents/Karens github repo/coast-dresses/Coast_dresses_all.csv",
                 header = TRUE, sep = ",")
str(data)

## Which size has most stock?
size_summary <- as.data.frame(lapply(data[c(4:10)], table))
size_summary <- size_summary[c("size6.Var1", "size6.Freq", "size8.Freq", "size10.Freq",
                               "size12.Freq", "size14.Freq", "size16.Freq", "size18.Freq")]
colnames(size_summary) <- c("Stock", "size6", "size8", "size10", "size12", "size14",
                            "size16", "size18")

# Graph the data
size_summary.m <- melt(size_summary, id.vars = "Stock")
ggplot(size_summary.m, aes(x = variable, y = value, fill=Stock)) +
  geom_bar(stat='identity') + labs(x="Size", y="Dresses in stock", title="Stock levels of Coast dresses by size")

## Which colours are popular when?
colours <- as.data.frame(table(data$Colour, data$Date))
colours <- dcast(colours, Var1 ~ Var2, value.var="Freq")
colnames(colours)[1] <- "Colour"

## Analyse price distributions

# Box plots for each time point
ggplot(data, aes(x=Date, y=Price)) + geom_boxplot() +
  labs(title="Box plots of prices of dresses by date")

# Histogram for January 2017
Jan17 <- subset(data, Date == "Jan_17")
qplot(Jan17$Price,
      geom="histogram",
      main = "Histogram of dress prices, January 2017",
      binwidth = 10,
      xlab = "Price")












