

# S3

### Existing methods
```r
# Inspect workspace
ls.str()

methods(mean)

methods(class="glm") # returns S3 and S4
.S3methods(class="glm) # returns only S3

# Test an object is of 'my_class'
inherits(x, "my_class")

```

# R6

```r

library(R6)

# Generate Class
thing_factory <- R6Class(
  "Thing",                  # Class names should be UpperCamelCase
  private = list(
    ..a_field = "a value",  # private filed should start with ".." 
    ..another_field = 123
  ),
  public = list(
      initialize = function(a_field, another_field) {
      if(!missing(a_field)) {
        private$a_field <- a_field
      }
      if(!missing(another_field)) {
        private$another_field <- another_field
      },
    
    do_something = function(x,y,z){
      print(private$a_field)
    }
  ),
  active = list()
)

# Create objects
a_thing <- thing_factory$new()
another_thing <- thing_factory$new()

# Encapsulation by public
a_thing$do_something()

a_thing <- thing_factory$new(  # Initialize public function
  a_field = "a different value", 
  another_field = 456
)

# Active Bindings


```
