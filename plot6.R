## plot6.R

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
## and Los Angeles County, California
vehicle_source <- subset(merged_data, fips == "24510" | fips == "06037" & type == "ON-ROAD")

## Used aggregate function to split data by year, fips and apply sum
ttl_emissions <- aggregate(Emissions ~ year + fips, data = vehicle_source, sum)

## Rename five-digit city code to city name
ttl_emissions[ttl_emissions$fips == "24510", 2] <- "Baltimore City"
ttl_emissions[ttl_emissions$fips == "06037", 2] <- "Los Angeles County"

## Open a graphic device
png("plot6.PNG", width = 800)

## Create a ggplot plot
g <- ggplot(ttl_emissions, aes(year, Emissions, color = fips)) +
  facet_wrap(~fips) +
  geom_line() +
  geom_point(size = 4) +
  xlab("Year") +
  ylab(expression(paste("Total PM " [2.5], " emission (tons)"))) +
  ggtitle(expression(paste("Comparison of Total PM " [2.5], " emission by motor vehicle sources in Baltimore City and Los Angeles County"))) +
  geom_smooth(method = "lm", se=FALSE, color="black", linetype = 2, show_guide = TRUE)
  
## Print to a graphic device
print(g)

## Close the graphic device connection
dev.off()
