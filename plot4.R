## plot4.R

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

## Match keyword "Coal", case insensitive in Short.Name variable and subset data
source_coal <- subset(merged_data, grepl("Coal", merged_data$Short.Name, ignore.case = TRUE))

## Used base function aggregate to split source_coal data into subsets by year and apply sum
ttl_emissions <- aggregate(Emissions ~ year, data = source_coal, sum)

## Open a graphic device
png("plot4.PNG", width = 640)

## Create a ggplot plot
g <- ggplot(ttl_emissions, aes(year, Emissions)) +
  geom_line(color = "blue") +
  geom_point() +
  xlab("Year") +
  ylab(expression(paste("Total PM " [2.5], " emission (tons)"))) +
  ggtitle(expression(paste("Total PM " [2.5], " emission by coal combustion-related sources in the U.S.")))

## Print to a graphic device
print(g)

## Close the graphic device connection
dev.off()