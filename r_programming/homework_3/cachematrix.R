# University John Hopkins
# Course: R Programming
# Assignment 2
# By James Lafa

# By using 2 function and the double arrow operator we must implement
# a function holding a matrix and caching the inverted matrix (could be
# an heavy computation) to be able to access to the inverted matrix without
# computing it again.

# I'd like to say it is a very ugly peace of code, that I hope has been asked
# in order to teach us the double arrow operator. However, using a second 
# function 'cacheSolve' to compute the inverted matrix and store it inside the
# the other function is very dirty and I would never have wrote something like 
# this (that why it took me time to solve this exercice :-)


# makeCacheMatrix is a function storing the a matrix and that cache also
# store a the value of a the inversed matrix to use it has a cache.
# The original matrix and the cached inverted one can be access via the 
# function get and getinverse.
# The original matrix can be update via the function set, but the inverted
# matrix must be computed and stored again.
makeCacheMatrix <- function(x = matrix()) {
    # m hold the inverted matrix. Before the matrix is set
    # we initialize it with NULL
    m <- NULL
  
    # set a new matrix in the object. It will also erase the cached
    # inverted matrix which doesn't make sens anymore since the
    # original matrix has been changed
    set <- function(y) {
        # We use the double arrow operator to initialize the value
        # in the environnement the function is declared, in that case
        # inside the makeCacheMatrix function
        
        # We assign the matrix with the value of x
        x <<- y
        
        # We erase the value of m (the inverted matrix) because we 
        # just assigned a new matrix. setinverse has to be call again
        # to reinitialize it
        m <<- NULL
    }
  
    # get simply return the current matrix stored in x
    get <- function() {
        x
    }

    # setinverse store the inverted matrix into m (via double arrow operator 
    # to update the value inside the makeCacheMatrix function) to use it as a cache
    setinverse <- function(inverted_matrix) {
        m <<- inverted_matrix
    }
  
    # getinverse returned the saved value of the inverted matrix
    getinverse <- function() {
        m
    }
  
    # list available function
    list(
        set = set, 
        get = get,
        setinverse = setinverse,
        getinverse = getinverse
    )
}


# cacheSolve is a function taking advantage of the cache possibility of
# the function makeCacheMatrix.
# In case the matrix has already been inverted, the inverted value will
# be returned without being computed again.
# In case the matrix has never been inverted, the computation is made and
# stored in the cache of the makeCacheMatrix in order to use it on the next
# call
cacheSolve <- function(x, ...) {
    # get the inverted matrix from the matrix
    # given as an argument
    m <- x$getinverse()
    
    # in cache the inverted matrix is already defined
    # in x (we are using the already cached matrix),
    # let's print we use the cache and return it
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    
    # in cache m was null, we need to :
    # 1 - get the original matrix
    # 2 - caculate the inverted matrix
    # 3 - save the inverted matrix in the cache to reuse it later
    # 4 - return the inverted matrix
    
    # get the original matrix
    data <- x$get()
    # caculate the inverted matrix
    m <- solve(data, ...)
    # save the inverted matrix in the cache to reuse it later
    x$setinverse(m)
    # return the inverted matrix
    m
}
