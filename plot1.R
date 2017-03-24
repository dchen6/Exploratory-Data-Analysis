# Objective: Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

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

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
Emissions_by_Year <- NEI[,.(Emissions_Sum = sum(Emissions)), by = year]
with(data = Emissions_by_Year, plot(year, Emissions_Sum/10^6, type = "b",
                                    xlab = "Year", ylab = "Emissions from PM2.5(10^6 tons)")) 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
