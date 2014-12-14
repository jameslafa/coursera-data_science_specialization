corr <- function(directory, threshold = 0) {
  # Get the number of complete cases for each file of the directory
  directory_complete_cases = complete(directory)
  # Extract the list of file ids over the threshold
  file_ids = directory_complete_cases$id[directory_complete_cases$nobs > threshold]
  
  corr_vec = c()
  
  for(current_id in file_ids){
    # Current file name is a 3 characters string with leading 0
    current_file_name = formatC(current_id, width=3, flag="0")
    # Contruct the file full_path
    current_file_path = paste("./", directory, "/", current_file_name, ".csv", sep="")
    # Read CSV from data
    current_data = read.csv(current_file_path)
    
    # Compute the correlation
    current_corr_vec = cor(current_data$nitrate, current_data$sulfate, use="pairwise.complete.obs")
    # Add the correlation to the global vector that will be returned
    corr_vec = c(corr_vec, current_corr_vec)
  }
  
  # Return the result
  corr_vec
}