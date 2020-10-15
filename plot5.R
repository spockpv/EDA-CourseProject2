download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip", method = "curl")
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

options(scipen=999)

vehicle_baltimore_SCC<-SCC[grep(pattern = 'Vehicle|Truck', x = SCC$SCC.Level.Three),1]

vehicle_baltimore<-subset(NEI, NEI$SCC %in% vehicle_baltimore_SCC & fips == "24510", select = c(Emissions, year))

a5<-with(vehicle_baltimore, tapply(Emissions, year, sum, na.rm = TRUE))

png(filename = "plot5.png")

plot(x = names(a5), a5, main = "Motor vehicle sources emmisions", xlab = "Year", ylab = "Emmisions (tons)", col = "red", type="l", xlim = c(1998,2010))

dev.off()