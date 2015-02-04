#plot4.R

source('functions.R')
readData()
png("plot4.png")
par(mfcol=c(2,2))
plot2()
plot3()
plot4()
plot5()
dev.off()
