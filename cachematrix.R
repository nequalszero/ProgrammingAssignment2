## makeCacheMatrix creates a special "matrix", which is really a list containing a function to
## 1.) set the value of the matrix
## 2.) get the value of the matrix
## 3.) set the value of the inverse
## 4.) get the value of the inverse

## The cacheSolve function calculates the inverse of the special "matrix" created with the makeCacheMatrix function. 
## However, it first checks to see if the inverse has already been calculated. If so, it gets the inverse from the cache 
## and skips the computation. Otherwise, it calculates the inverse of the data and sets the value of the inverse in the 
## cache via the setinverse function.



## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        ## Both x and m are defined in a different environment, which is why we use "<<-".
        x <<- y
        m <<- NULL
    }
    ## Setting the inverse of matrix x and getting the inverse of that matrix -matrix m.
    get <- function() x
    setinverse <- function(solve) m <<- solve
    ## Function that will retrieve information stored in matrix m.
    getinverse <- function() m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should
## retrieve the inverse from the cache.
## Checking if the matrix m is populated with the inverse matrix x.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    ## If matrix m is empty, then proceed to the next step. If it's NOT empty, then get data stored in matrix m -inverse of x.
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    ## This step is only executed if matrix m is empty. If it's empty, then the inverse of matrix x is calculated using "solve(x)".
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}

## Copy of makeVector function provided from course for reference
## makeVector creates a special "vector", which is really a list containing a function to

## 1.) set the value of the vector
## 2.) get the value of the vector
## 3.) set the value of the mean
## 4.) get the value of the mean

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

## Copy of cachemean function provided from course for reference
## The following function calculates the mean of the special "vector" created with the above function. 
## However, it first checks to see if the mean has already been calculated. If so, it gets the mean from the cache 
## and skips the computation. Otherwise, it calculates the mean of the data and sets the value of the mean in the 
## cache via the setmean function.

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}