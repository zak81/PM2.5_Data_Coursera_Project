## plot1.R

library(dplyr)

## Read each of the two files using the readRDS()
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Use group_by function from the dplyr package to group dataset by year
by_year <- group_by(NEI, year)

## Use summarise function from the dplyr package to get sum of Emissions grouped by year
ttl_emissions <- summarise(by_year, sum(Emissions))

## Open a graphic device
png("plot1.PNG")

## Set the margin
par(mar = c(6,8,4,2))

## Plot the data with empty axis and labels
plot(ttl_emissions, xaxt = "n", yaxt = "n", xlab = "", ylab = "", type = "b", 
     col = "blue", main = expression(paste("Total PM " [2.5], " emissions in the United States")))

## Add x-axis with label
axis(1, at = ttl_emissions$year)
mtext("Year", side = 1, line = 3)

## Add y-axis with label
axis(2, at = ttl_emissions$Emissions, las = 1)
mtext(text = expression(paste("Total PM " [2.5], " emission (tons)")), side = 2, line = 4)

## CLose the graphics device connection
dev.off()