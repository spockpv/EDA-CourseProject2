library("ggplot2")
library("reshape")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip", method = "curl")
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

nei2<-subset(NEI, fips == "24510")

a3<-split(nei2, f=nei2$type)

sum_year <- function(part_list) {
    with(part_list, tapply(Emissions, year, sum, na.rm = TRUE)) 
}

lty<-lapply(a3, sum_year)
df <- data.frame(matrix(unlist(lty), nrow=length(lty), byrow=F))
df<-cbind(c(1999,2002,2005,2008), df)
names(df)<-c("year", "NON-ROAD","NONPOINT","ON-ROAD","POINT")

png(filename = "plot3.png")

m2 <- melt(df, id = "year")

p <- ggplot(m2, aes(x = year, y = value, color = variable))
p + geom_line() + ylab("Emmisions (tons)") + ggtitle("Emmision types in Baltimore City") + xlab("Year")
dev.off()