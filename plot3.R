#plot3.R

source('functions.R')
readData()
png("plot3.png")
plot3(T)
dev.off()
