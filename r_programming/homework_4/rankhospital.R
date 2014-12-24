rankhospital <- function(state, outcome, rank) {
    # Read csv file
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")    
    
    # Get all existing states avnd verify the value given exists
    all_states = unique(data[, 7])
    
    if ( !(state %in% all_states) ){
        stop("invalid state")
    }
    
    # Subset data for the specified state
    data <- subset(data, State == state)
    
    # Depending on the outcome selected, we subset the right columns
    # Name + Rate of the outcome
    if (outcome == "heart attack"){
        data <- data[, c(2, 11)]
    }
    else if (outcome == "heart failure"){
        data <- data[, c(2, 17)]
    }
    else if (outcome == "pneumonia"){
        data <- data[, c(2, 23)]
    }
    else{
        # Return error if the outcome doesn't exist
        stop("invalid outcome")
    }
    
    # Rename the data columns, it helps to subset
    colnames(data) <- c("Name", "Rate")
    
    # Convert the rate to numeric
    suppressWarnings(data[, 2] <- as.numeric(data[, 2]))
    
    # Sort hospitals by rank and by name
    data <- data[order(data[, 2], data[, 1], decreasing = FALSE, na.last = TRUE), ]
    data <- na.omit(data)
    
    # Add the rank column
    data$Rank <- ave(data$Rate, FUN=function(x) rank(x, ties.method = "first"))
    
    if (rank == "best"){
        index = 1
    }
    else if (rank == "worst"){
        index = nrow(data)
    }
    else if (rank > nrow(data)){
        return(NA)
    }
    else {
        index = rank
    }
    
    data[index, 1]
}