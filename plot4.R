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

# Q4: Across the United States, 
# how have emissions from coal combustion-related sources changed from 1999–2008?

# select the coal related sources, using Short.Name as EI.Sector exclude some
SCC_coal <- SCC[grepl("[Cc]oal", Short.Name)]

# select NEI data based on coal sources
NEI_coal <- NEI[SCC %in% SCC_coal$SCC]

# summarize coal emissions by year
NEI_coal_yearly <- NEI_coal[, .(Emissions_Yearly = sum(Emissions)), by = year]

# create bar plots for emissions by year
p <- ggplot(NEI_coal_yearly, aes(year, Emissions_Yearly/10^3))

p + geom_bar(stat = "identity", fill = "blue") + 
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) +
    labs(x="year", y=expression("Total PM2.5 Emission (10^3 Tons)")) + 
    labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US from 1999-2008")) +
    theme_bw()

# save image locally
dev.copy(png, file = "plot4.png")
dev.off()
