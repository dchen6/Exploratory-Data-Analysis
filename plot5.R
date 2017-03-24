
# load required packages
require(data.table)
require(dplyr)
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


# Q5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Get the emissions from motor vehicle sources (type = ON-ROAD) in Baltimore City
Baltimore_vehciles <- NEI[fips == "24510" & type == "ON-ROAD",]

# Get the total Baltimore emissions from motor vehicle sources by year
Baltimore_vehciles_yearlyEmissions <- aggregate(Emissions ~ year, data = Baltimore_vehciles, FUN = sum)


with(Baltimore_vehciles_yearlyEmissions, 
    plot(year, Emissions, type = 'b',
         xlab="Year",
         ylab='PM2.5 Emissions (tons)',
         main='PM2.5 Emissions from motor vehicle sources in Baltimore City'))

dev.copy(png, file = "plot5.png")
dev.off()
