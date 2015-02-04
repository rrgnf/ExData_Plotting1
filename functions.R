readData <- function(){
  if(!require("data.table",character.only = T)){
    install.packages("data.table")
    require(data.table)
  }
  if(!require("lubridate",character.only = T)){
    install.packages("lubridate")
    require(lubridate)
  }
  
  if(file.exists("power1.csv")){
    power1 <<- fread("power1.csv")
    power1 <<- power1[,Date1 := ymd_hms(Date1)]
  }else{
    
    if(!file.exists("household_power_consumption.txt")){
      download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip','power.zip')
      unzip('power.zip')
    }
    
    d1 <- ymd_hms("2007-02-01 0:0:0")
    d2 <- ymd_hms("2007-02-02 23:59:59")
    fileName = "household_power_consumption.txt"
    
    power0 <- fread(fileName, na.strings = "?",verbose=F)
    
    power0[,Date1 := dmy_hms(paste(Date, Time),"%d/%m/%Y %H:%M:%S")]
    
    power1 <-- power0[ (d1 <= Date1) & (Date1 <= d2) ]
    
    rm(power0, d1, d2, fileName)
    write.csv(power1,file="power1.csv",row.names=F)
  }
}

plot1 <- function(){
  
  hist(as.numeric(power1$Global_active_power),
       col="red",
       xlab = "Global Active Power (kilowatts)",
       main="Global Active Power")
  
}

plot2 <- function(){
  with(power1, 
       plot(Date1,as.numeric(Global_active_power),
            type="s",
            ylab = "Global Active Power (kilowatts)",
            xlab =""
       )
  )
}

plot3 <- function(){
  with(power1, plot(Date1,as.numeric(Sub_metering_1),
                    type="s",ylab = "Energy sub metering",
                    xlab="",
                    #xlim=as.numeric(Date1)
  ))
  
  with(power1, lines(Date1,as.numeric(Sub_metering_2),col="red",type = "s"))
  with(power1, lines(Date1,as.numeric(Sub_metering_3),col="blue",type = "s"))
  legend("topright", pch="______", col=c('black','red','blue'),
         legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
}

plot4 <- function(){
  with(power1, 
       plot(Date1,as.numeric(Voltage),
            type="l",
            ylab="Voltage",
            xlab ="datetime"
       )
  )
}

plot5 <- function(){
  with(power1, 
       plot(Date1,as.numeric(Global_reactive_power),
            type="l",
            ylab="Global_reactive_power",
            xlab ="datetime"
       )
  )
}
plot5()
