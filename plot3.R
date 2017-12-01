plot3 <- function(datapath = '.', outfile = 'plot3.png') {
    ## Creates a PNG plot of Energy Sub Metering versus time
    ## Requires the file "household_power_consumption.txt". The path
    ## to this file must be given by datapath
    
    library(sqldf) # Loads library for performing SQL code to load subset of file

    infile = paste(datapath, 'household_power_consumption.txt', sep = '/')

    #Loads rows from file only for selected dates			
    df = read.csv.sql(infile, sep=';', header = T, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", eol = "\n") 

    # Create POSIX vector for dates and times
    Dates = strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

    #Create plot
    dev.new(x11, width=480, height=480)

    # Initiate plot
    plot(Dates, df$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'n')

    # Loop through 3 sub metering columns and plot each
    colors = c('black','red','blue')
    for (i in 1:3) {
    	column = paste('Sub_metering_', i, sep = '')
        points(Dates, df[,column], col = colors[[i]], type = 'l')
    }

    # Create legend
    legend("topright", paste("Sub_metering_", 1:3, sep=''), col = colors, lty = 1)

    # Save PNG
    dev.copy(png, paste(datapath, outfile, sep = '/'))
    dev.off()
}