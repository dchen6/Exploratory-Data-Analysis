# Objective: Use the base plotting system to make a plot answering this question.

# load required packages
require(data.table)

# set working directory -----
setwd("/Users/DE/Desktop/Coursera/Exploratory Data Analysis/Course-Project-2")
list.files()
# free up memory space
rm(list = ls())

# read raw data
NEI <- readRDS("summarySCC_PM25.rds")

# convert to data tables
NEI <- data.table(NEI)
str(NEI)

# Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶")
# from 1999 to 2008? 

# summarize by year
Baltimore <- NEI[fips == "24510", .(Emissions_Sum = sum(Emissions)), by = year]
# create bar plot
with(Baltimore, barplot(Emissions_Sum, names.arg = year, xlab = "Year", ylab = "PM2.5 Emissions (Tons)",
                        main = "Total PM2.5 Emissions From all Baltimore City Sources by Year"))
# save image locally
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
