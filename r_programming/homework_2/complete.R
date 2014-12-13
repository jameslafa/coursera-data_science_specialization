complete <- function(directory, id = 1:332) {
  # Main vector storing the combined data of every file
  files = c()
  nobs = c()
  
  # Loop on every file
  for(current_id in id){
    
    # Current file name is a 3 characters string with leading 0
    current_file_name = formatC(current_id, width=3, flag="0")
    # Contruct the file full_path
    current_file_path = paste("./", directory, "/", current_file_name, ".csv", sep="")
    # Read CSV from data
    current_data = read.csv(current_file_path)
    
    # Extract every complete cases from data
    current_nobs = current_data[complete.cases(current_data), ]
    
    # Add id and count to vectors
    files <- append(files, current_id)
    nobs <- append(nobs, nrow(current_nobs))
  }
  
  # Create data.frame from both vector
  nobs_per_id <- data.frame(id=files, nobs=nobs)
}