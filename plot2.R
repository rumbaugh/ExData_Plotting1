plot2 <- function(datapath = '.', outfile = 'plot2.png') {
    ## Creates a PNG plot of Global Active Power versus time
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
    plot(Dates, df$Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatts)', type = 'l')

    # Save PNG
    dev.copy(png, paste(datapath, outfile, sep = '/'))
    dev.off()
}