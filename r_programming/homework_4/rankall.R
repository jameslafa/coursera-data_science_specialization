rankall <- function(outcome, num = "best"){
    # Read csv file
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")  
    
    # Depending on the outcome selected, we subset the right columns
    # Name + Rate of the outcome
    if (outcome == "heart attack"){
        data <- data[, c(2, 7, 11)]
    }
    else if (outcome == "heart failure"){
        data <- data[, c(2, 7, 17)]
    }
    else if (outcome == "pneumonia"){
        data <- data[, c(2, 7, 23)]
    }
    else{
        # Return error if the outcome doesn't exist
        stop("invalid outcome")
    }
    
    # Rename the data columns, it helps to subset
    colnames(data) <- c("Name", "State", "Rate")
    
    # Convert the rate to numeric
    suppressWarnings(data[, 3] <- as.numeric(data[, 3]))
    data <- na.omit(data)
    
    # Sort hospitals by rank and by name
    data <- data[order(data[, 2], data[, 3], data[, 1], decreasing = FALSE, na.last = TRUE), ]
    
    # Sort hospital name alphabetically
    data$Rank <- unlist( with(data, tapply(Rate, State, function(x) rank(x, ties.method = "first")) ) )
    
    # Get for every state the hospital at this rank
    
    # Get the list of all existing state
    states_list <- unique(data[, 2])
    
    # Store in another vector the hospital names
    hostpital_list <- c()
    
    # Loop on every state
    for(currentstate in states_list){
        # Subset the data only for the current state
        state_values <- subset(data, State == currentstate)
        
        # Depending on the num, extract the hospital name
        if (num == "best"){
            current_hospital <- state_values[1, 1]
        }
        else if (num == "worst"){
            current_hospital <- state_values[nrow(state_values), 1]
        }
        else if (num > nrow(state_values)){
            current_hospital <- NA
        }
        else {
            current_hospital <- state_values[num, 1]
        }
        
        # Add the hospital name to the vector
        hostpital_list = c(hostpital_list, current_hospital)        
    }
    
    # Build a data frame which will be returned as result
    result <- data.frame(hospital = hostpital_list, state = states_list)
    
    # Return result
    return(result)
}