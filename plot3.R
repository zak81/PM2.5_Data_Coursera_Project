## plot3.R

library(ggplot2)

## Read each of the two files using the readRDS()
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## subset Baltimore City five-digit number
baltimore <- NEI[NEI$fips == "24510", ]

## Used base function aggregate to split baltimore data into subsets by type and year
## apply function sum to subsets
ttl_emissions <- aggregate(Emissions ~ type + year, data = baltimore, sum)

## Open a graphic device
png("plot3.PNG")

## Create a ggplot plot
g <- ggplot(ttl_emissions, aes(year, Emissions, color = type)) +
    geom_line() +
    geom_point() +
    xlab("Year") +
    ylab(expression(paste("Total PM " [2.5], " emission (tons)"))) +
    ggtitle(expression(paste("Total PM " [2.5], " emission by source type in Baltimore CIty")))

## Print to a graphic device
print(g)

## Close the graphic device connection
dev.off()

