best <- function(state, outcome) {
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
    
    # Find the minimal rate
    min_rate = min( data[, 2], na.rm = TRUE)
    
    # Select hospitals with the min rate
    data <- subset(data, Rate == min_rate)
    
    # Sort hospital name alphabetically
    data <- data[order(data$Name), ]
    
    # Return the name of the hospital of the first hospital
    data[1, 1]
}

