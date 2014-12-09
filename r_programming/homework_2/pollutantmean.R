pollutantmean <- function(directory, pollutant, id = 1:332) {
  for(current_id in id){
    # Current file name is a 3 characters string with leading 0
    current_file_name = formatC(current_id, width=3, flag="0")
    # Contruct the file full_path
    current_file_path = paste(directory, "/", current_file_name, ".csv", sep="")
    # Read CSV from data
    current_data = read.csv(current_file_path)
    
    # Extract data from requested column, only when data are not NA
    pollutant_data = subset(current_data, pollutant != 'NA', select = pollutant)
  }
}