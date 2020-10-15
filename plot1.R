download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip", method = "curl")
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

a1<-with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))

options(scipen=999)

png(filename = "plot1.png")

plot(x = names(a1), a1, main = "Total PM2.5 Emmision", xlab = "Year", ylab = "Emmisions (tons)", col = "red", type="l", xlim = c(1998,2010))

dev.off()