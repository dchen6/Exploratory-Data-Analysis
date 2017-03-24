
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

# Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

# Get the emissions from motor vehicle sources (type = ON-ROAD) in Baltimore City
Baltimore_vehciles <- NEI[fips == "24510" & type == "ON-ROAD",]

# Get the total Baltimore emissions from motor vehicle sources by year
Baltimore_vehciles_yearlyEmissions <- aggregate(Emissions ~ year, data = Baltimore_vehciles, FUN = sum)

# create a new variable called city
Baltimore_vehciles_yearlyEmissions$city <- "Baltimore"

# Get the emissions from motor vehicle sources (type = ON-ROAD) in os Angeles County
LA_vehciles <- NEI[fips == "06037" & type == "ON-ROAD",]

# Get the total Baltimore emissions from motor vehicle sources by year
LA_vehciles_yearlyEmissions <- aggregate(Emissions ~ year, data = LA_vehciles, FUN = sum)

# create a new variable called city
LA_vehciles_yearlyEmissions$city <- "Los Angeles"

# stack two tables into one dataset
mdata <- rbindlist(list(Baltimore_vehciles_yearlyEmissions, LA_vehciles_yearlyEmissions), use.names = T)

# create comparison plots
q <- ggplot(mdata, aes(x = year, y = Emissions, fill = city))
q + geom_bar(aes(fill = year), stat="identity") + 
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) +
    facet_grid(scales = "free", space = "free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM2.5 Emission (tons)")) + 
    labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

# save image locaaly
dev.copy(png, file = "plot6.png")
dev.off()
