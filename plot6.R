library("ggplot2")
library("reshape")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip", method = "curl")
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

options(scipen=999)

vehicle_SCC<-SCC[grep(pattern = 'Vehicle|Truck', x = SCC$SCC.Level.Three),1]

vehicle_both<-subset(NEI, NEI$SCC %in% vehicle_SCC & (fips == "24510" | fips == "06037"), select = c(Emissions, fips, year))

a6<-split(vehicle_both, f=vehicle_both$fips)

sum_year <- function(part_list) {
    with(part_list, tapply(Emissions, year, sum, na.rm = TRUE)) 
}

lty<-lapply(a6, sum_year)

df <- data.frame(matrix(unlist(lty), nrow=4, byrow=F))

df<-cbind(c(1999,2002,2005,2008), df)

names(df)<-c("year", "Baltimore City","Low Angeles County")

m2 <- melt(df, id = "year")

png(filename = "plot6.png")

p <- ggplot(m2, aes(x = year, y = value, color = variable))
p + geom_line() + ylab("Emmisions (tons)") + ggtitle("Emmision from motor vehicles") + xlab("Year")

dev.off()
