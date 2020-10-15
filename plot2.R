download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip", method = "curl")
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

nei2<-subset(NEI, fips == "24510")
a2<-with(nei2, tapply(Emissions, year, sum, na.rm = TRUE))

options(scipen=999)

png(filename = "plot2.png")

plot(x = names(a2), a2, main = "Total PM2.5 emmisions in Baltimore City", xlab = "Year", ylab = "Emmisions (tons)", col = "red", type="l", xlim = c(1998,2010))

dev.off()