#Hadley-Verse Cheat Sheet

#### Table of Contents
1. [magrittr](#magrittr)
2. [readr](#readr)
2. [lubridate](#lubridate)
3. [stringr](#stringr)
4. [tidyr](#tidyr)
5. [dplyr](#dplyr)
7. [ggplot2](#ggplot2)
9. [rvest](#rvest)
9. [devtools](#devtools)
9. [roxygen2](#roxygen2)
9. [testthat](#testthat)
9. [packrat](#packrat)
1. [feather](#feather)

##magrittr

##readr
```r
df <- read_csv() #comma-separated
read_delim() #any-other-char-separated

problems(df)$row
```

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
```

##stringr
```r
str_length(fruit)
str_count(fruit, "xx") # Return a number

# return a binary (T/F)
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
```

##tidyr

##dplyr

##ggplot2

##rvest

##devtools

##roxygen2

##testthat

##packrat

##feather
