#Hadley-Verse Cheat Sheet

#### Table of Contents
1. [magrittr](#magrittr)
5. [dplyr](#dplyr)
4. [tidyr](#tidyr)
2. [readr](#readr)
2. [readxl](#readxl)
2. [lubridate](#lubridate)
3. [stringr](#stringr)
7. [ggplot2](#ggplot2)
9. [rvest](#rvest)
9. [devtools](#devtools)
9. [roxygen2](#roxygen2)
9. [testthat](#testthat)
9. [packrat](#packrat)
1. [feather](#feather)
2. [purrr](#purrr)
3. [broom](#broom)

##magrittr
```r
df %$% plot(x,y)  # Makes lhs visible to rhs
x %<>% sqrt() # compute & updates lhs 
```

##dplyr
```r
df %<>% 
  select(cols) %>%
  filter(condition) %>% 
  mutate(new.col= ~) %>% 
  arrange(col1, -col2) %>%  # sorting: dec() or '-' for decreasing
  group_by(col1) %>% summarize(min=min(col2)) %>% 
  group_by(col1) %>% filter(col2==max(col2))

# Merge function
left_join

```

##tidyr
```r
# collapse multiple columns into key-value pairs
gather(data, key.name, value.name, cols) 
# Example
gather(kerr.df, Iter, Value, -Date)

# oposite of gather
spread(data, key, value)

# Separate a column values into multiple columns based on a pattern
separate(data, col, into.cols, pattern, convert=TRUE)

```

##readr
```r
df <- read_csv() #comma-separated
read_delim() #any-other-char-separated

problems(df)$row
```

##readxl

##lubridate
```r
# Format
ymd(c("2001-01-12", "2011/3/31"))
dmy("310314")
ymd_hms("2001-01-12 14:12:00")

# Info
day(dt); month(dt); year(dt)
month(dt, label=TRUE)
wday(dt, label=TRUE)
yday(d) # day of year (1 to 366)

# Duration
weeks(2); days(4)
ymd(20150601) + weeks(2) + days(4)

# Last day of months
jan31 %m+% months(0:11)
```

##stringr
```r
str_c() # paste0

str_length(fruit)
str_count(fruit, "xx") # Return a number

# Detect -- return a binary
str_detect(fruit, "xx") 
str_detect(fruit, "^p") # matches start
str_detect(fruit, "a$") # matches end

# Extract patterns
people = c("Arthur 25", "Barry 33", "Charles 12", "Darren Edward 19")
str_extract(people, "\\d+")     # one or more digits
str_trim(str_extract(people, "[^0-9]+"))

# Split
str_split(bp, ";")

# Substrings
s = "The Quick Brown Fox"
str_sub(s, 5, 9)
str_sub(s, 5, 9) <- "Slow" # replace with different length
str_sub(s, -3, -1)         # negative numbers count from end

# Replace
str_replace(strings, phone, "XXX-XXX-XXXX")
str_replace_all(strings, matches)
```

##ggplot2
```
# Clean theme
+ theme_minimal()

# Basic plotting
ggplot(bps2, aes(x=obs_date, y=sys, colour=Name)) + geom_point()
    
geom_point()
geom_line()
geom_ribbon(alpha=0.5)
geom_histogram(binwidth=1)
geom_boxplot()

ggplot(bps2, aes(x=Week)) +
      geom_line(aes(y=sys, col="sys"), lwd=1) +
      geom_line(aes(y=dia, col="dia"), lwd=1) +
      scale_colour_manual(name="Phase", values=c(sys="red",dia="blue")) +
      ylab("mmHg")
      
# Faceting
ggplot(bps2, aes(x=obs_date, y=sys)) +
   geom_line() + stat_smooth(method="loess") +
   facet_wrap(~Name,nrow=1) +
   theme_stata()
   
ggplot(bps2, aes(x=obs_date, ymin=dia, ymax=sys, fill=Name)) +
   geom_ribbon(alpha=0.5) +
   facet_wrap(~Name, ncol=1, scales="free_y")
      
```

##rvest

##devtools

##roxygen2

##testthat
```r
foo = function(a, b=1){ a + b }
expect_equal(foo(1), 2)
expect_equal(foo(1, 2), 3)
expect_error(foo())

test_that("foo works", {
   expect_equal(foo(1, 2), 3, info="add 2 numbers")
   expect_equal(foo(1), 2, info="default b is 1")
   expect_error(foo(), info="need one arg")
   expect_error(foo(1,2,3,4,5), info="too many args")
 })

```

##packrat

##feather

## purrr
*dplyr for vectors.* 

## broom


