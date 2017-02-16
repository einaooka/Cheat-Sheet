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

### Basics

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
        private$..a_field <- a_field
      }
      if(!missing(another_field)) {
        private$..another_field <- another_field
    },
    finalize = function(){                 # Called with gc not rm
      message("Finalizing the Thing")
    },
    do_something = function(x){
      private$..another_field = private$..another_field + x
    }
  ),
  active = list(
     a_field = function(){  # Read-only active binding
       if(is.na(private$..a_field)) return("a missing value")
       private$..a_field
     },
     another_field = function(value){
       if(missing(value)) { #get
          private$..a_field
        } else { #set
         assert_is_a_number(value)
         private$..another_filed <- value
       }
     }
  
  )
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

# Active Bindings gives controled access to the private field
#  - Defined like functions
#  - Accessed like data
a_thing$a_field
a_thing$another_field <- 456

```

### Inheritance
```r
child_thing_factory <- R6Class(
  "ChildThing", 
  inherit = thing_factory, 
  public = list(
    do_something = function(){
      message("the child do_something method")  # overwrite do_something 
    }, 
    do_something_else = function(){
      message("the child do_something_else method")
      self$do_something()  # self$ accesses public methods in self
      super$do_something() # super$ accesses public methods in parent
    }
  )
)

# Chain Ingeritance - child has access to direct parent only. 
child_thing_factory <- R6Class(
  "ChildThing", 
  inherit = thing_factory, 
  public = list(
    do_something = function(){
      message("the child do_something method")
    },
    active = list(               # create active binding for grand-child method access. 
      super_ = function() super
    )
  )
)

grandchild_thing_factory <- R6Class(
  "GrandChildThing", 
  inherit = child_thing_factory, 
  public = list(
    do_something = function(){
      message("the grand-child do_something method")
      super$do_something()          # Access parent method
      super$super_$do_something()   # Access grand-parent method
    }
  )
)

```

### Advanced R6 - Environment
Environments copy by reference

```r 

thing_factory <- R6Class(
  "Thing", 
  private = list(
    shared = {
      e <- new.env()  # Assign a new environment
      e$a_shared_field = 123
      e
    }
  ), 
  active = list(
    a_shared_field = funciton(value){
      if(missing(value)){
        private$shared$a_shared_field
    } else {
      private$shared$a_shared_field <- value
    }
  )
)

# R6 objects copy by reference
a_clone <- a_thing$clone() # Copy them by value
a_deep_clone <- a_thing$clone(deep = TRUE) # copy by value deeply if R6 object includes other R6 objects
```
