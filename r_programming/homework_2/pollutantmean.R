pollutantmean <- function(directory, pollutant, id = 1:332) {
  # Main vector storing the combined data of every file
  pollutant_data = c()
  
  # Loop on every file
  for(current_id in id){
    
    # Current file name is a 3 characters string with leading 0
    current_file_name = formatC(current_id, width=3, flag="0")
    # Contruct the file full_path
    current_file_path = paste("./", directory, "/", current_file_name, ".csv", sep="")
    # Read CSV from data
    current_data = read.csv(current_file_path)
    
    # Extract data from requested column and remove every NA
    current_pollutant_data = na.omit(current_data[, pollutant])
    # Combine the new vector with the main one
    pollutant_data = c(pollutant_data, current_pollutant_data)
  }
  
  # Every data and now in the vector pollutant_data
  # Let's run and mean and round the value to 3 digits
  round(mean(pollutant_data), 3)
}