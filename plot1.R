plot1 <- function(datapath = '.', outfile = 'plot1.png') {
    ## Creates a PNG histogram plot of Global Active Power
    ## Requires the file "household_power_consumption.txt". The path
    ## to this file must be given by datapath
    
    library(sqldf) # Loads library for performing SQL code to load subset of file

    infile = paste(datapath, 'household_power_consumption.txt', sep = '/')

    #Loads rows from file only for selected dates			
    df = read.csv.sql(infile, sep=';', header = T, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", eol = "\n") 

    #Create histogram
    dev.new(x11, width=480, height=480)
    hist(df$Global_active_power, xlab = 'Global Active Power (kilowatts)', col = 'red', main = 'Global Active Power')

    # Save PNG
    dev.copy(png, paste(datapath, outfile, sep = '/'))
    dev.off()
}