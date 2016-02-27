#Cheat Sheet - Error Handling

#### Table of Contents
1. [Output Variables](#output-variables)
2. [Asserts](#asserts)
3. [Exception Handling](#exception-handling)
4. [Traceback](#traceback)

### Output Variables

```r
print()
```

### Asserts
```r
stop("Error!")
stopifnot(1 == 1, TRUE, 1 < 2) # Stops if conditions are not TRUE. 

cube_root <- function(x) {
  if (class(x) != "numeric") {
    stop("Wrong variable class: not a single number")
  }
  if (x < 0) {
    stop("Wrong range: cannot be less than 0")
  }
  if (!is.finite(x)) {
    stop("Wrong range: cannot be infinite or NA")
  }
  return(x^(1/3))
}
cube_root("error") # should throw an error

```

### Exception Handling

#### try()
Ignore an error. Returns "try-error"
```r
error <- try("a" + "b")
class(error)
inherits(error, "try-error")

# suppress nthe message. 
try(..., silent = TRUE) 

# Pass larger blocks of code
try({
  a <- 1
  b <- "x"
  a + b
})

# Use with lapply - still returns a list in spite of errors.  
elements <- list(1:10, c(-1, 10), c(T, F), letters)
results <- lapply(elements, function(x) try(log(x)))
is.error <- function(x) inherits(x, "try-error")
succeeded <- !sapply(results, is.error)

```

#### tryCatch()
```r
handle_type <- function(expr) {
  tryCatch(expr,
    error=function(e) "error",
    warning=function(e) "warning",
    message=function(e) "message"
    )
}
handle_type(stop("..."))
handle_type(warning("..."))
handle_type(message("..."))
handle_type(10)
```

### Traceback

```r
f <- function(x) g(x)
g <- function(x) x + "string"
f(0)
traceback()
```

### Unit Testing
* 'RUnit' package
* 'testthat' package

```r
test_that("Roots are numeric and correct", {
  y <- f(x1, x2)
  expect_is(y, "numeric")
  expect_equal(length(y), 2)
  expect_equal(y, c(5, 6))
})

test_file("test.roots_quadratic_equation.R")
```

### Degubbing with r-studio

```r
options(error = browser)
options(error = NULL) # Return to default

```



