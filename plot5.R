## plot5.R

library(ggplot2)

## Read each of the two files using the readRDS()
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Merge NEI and SCC data frames by the SCC digit strings
if(!exists("merged_data")) {
  merged_data <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")
}

## Subset vehicle source by selecting type "ON-ROAD" and five-digit number for Baltimore City, Maryland
vehicle_source_baltimore <- subset(merged_data, fips == "24510" & type == "ON-ROAD")

## Used aggregate function to split data by year and apply sum
ttl_emissions <- aggregate(Emissions ~ year, data = vehicle_source_baltimore, sum)

## Open a graphic device
png("plot5.PNG")

## Create a ggplot plot
g <- ggplot(ttl_emissions, aes(year, Emissions)) +
  geom_line(color = "blue") +
  geom_point() +
  xlab("Year") +
  ylab(expression(paste("Total PM " [2.5], " emission (tons)"))) +
  ggtitle(expression(paste("Total PM " [2.5], " emission by motor vehicle sources in Baltimore City")))

## Print to a graphic device
print(g)

## Close the graphic device connection
dev.off()