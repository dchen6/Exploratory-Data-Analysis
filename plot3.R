# Objective: # Use the ggplot2 plotting system to make a plot answer this question.

# load required packages
require(data.table)
require(ggplot2)

# set working directory -----
setwd("/Users/DE/Desktop/Coursera/Exploratory Data Analysis/Course-Project-2")
list.files()
# free up memory space
rm(list = ls())

# read raw data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# convert to data tables
NEI <- data.table(NEI)
str(NEI)
SCC <- data.table(SCC)
str(SCC)

# Q3: Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?

# extract Baltimore data and aggregate by year and type
Baltimore <- NEI[fips == "24510", .(Emissions_Sum = sum(Emissions)), by = .(year, type)]
# set up base data and x/y axis
q <- ggplot(Baltimore, aes(year, Emissions_Sum)) 
# add points, lines to plots and separte into different windows
q + geom_point(aes(color = type)) + geom_line() + 
    facet_grid(. ~ type) + scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) +
    labs(x = "Year", y = "PM2.5 Emissions (tons)") + 
    theme_bw(base_family = "Times") 

# save image locally
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

