download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip", method = "curl")
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_SCC<-SCC[grep("Coal", SCC$SCC.Level.Three),1]
coal<-subset(NEI, subset = NEI$SCC %in% coal_SCC, select = c(Emissions, year))

a4<-with(coal, tapply(Emissions, year, sum, na.rm = TRUE))

png(filename = "plot4.png")

plot(x = names(a4), a4, main = "Coal combustion-related sources emmisions", xlab = "Year", ylab = "Emmisions (tons)", col = "red", type="l", xlim = c(1998,2010))

dev.off()