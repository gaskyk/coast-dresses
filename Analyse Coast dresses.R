##############################################
###                                        ###
###  Analyse data about Coast dresses      ###
###  from web scraped data                 ###
###                                        ###
##############################################

## Import libraries
library(tidyverse)
library(reshape2)
library(data.table)

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

# Graph the data for size and stock
size_summary.m <- melt(size_summary, id.vars = "Stock")
ggplot(size_summary.m, aes(x = variable, y = value, fill=Stock)) +
  geom_bar(stat='identity') + labs(x="Size", y="Dresses in stock", title="Stock levels of Coast dresses by size") +
  theme(plot.title = element_text(hjust = 0.5))

## Has stock availability changed over time?
stock_time <- data %>% 
                select(size6, size8, size10, size12, size14, size16, size18) %>% 
                map_dfc( ~ data %>% group_by(Date) %>% count(!!.x))

# Rename columns
stock_time$total <- rowSums(stock_time[,3:9])

# Graph the data for stock levels over time
stock_time.m <- melt(stock_time, id.vars = c("Date", "stock"))
stock_time_total <- subset(stock_time.m, variable=='total')
ggplot(stock_time_total, aes(x = Date, y = value, fill=stock)) +
  geom_bar(stat='identity') + labs(x="Month", y="Dresses in stock", title="Stock levels of Coast dresses by time") +
  theme(plot.title = element_text(hjust = 0.5))


## Which colours are popular when?
colours <- as.data.frame(table(data$Colour, data$Date))
colours <- dcast(colours, Var1 ~ Var2, value.var="Freq")
colnames(colours)[1] <- "Colour"

## Analyse price distributions

# Box plots for each time point
ggplot(data, aes(x=Date, y=Price)) + geom_boxplot() +
  labs(title="Box plots of prices of dresses by date") +
  theme(plot.title = element_text(hjust = 0.5))

# Histogram for January 2017
Dec17 <- subset(data, Date == "d_Dec_17")
qplot(Dec17$Price,
      geom="histogram",
      main = "Histogram of dress prices, December 2017",
      binwidth = 10,
      xlab = "Price") +
  theme(plot.title = element_text(hjust = 0.5))












