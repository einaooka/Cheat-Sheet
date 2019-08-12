# Useful R Codes

#### Table of Contents
1. [Date Time Manipulation](#date-time-manipulation)
3. [Plots and Layouts](#plots-and-layouts)
4. [Manipulate Data](#manipulate-data)
5. [htmlwidgets](#htmlwidgets)
7. [Colors](#colors)
9. [Develop Packages](#develop-packages)
10. [SQL](#SQL)


### Date Time Manipulation

```r
dates <- seq(as.Date("2015-1-1"),as.Date("2020-1-1"), by=1)
GetDateTable(dates, c("Date", "pk.nHours", "opk.nHours"))	

as.POSIXct(strptime(, "%m/%d/%Y %H:%M"))
as.POSIXct(strptime(, "%m/%d/%Y %I:%M:00 %p"))

# Time zone
tz <- switch (market
              , PNW = "America/Los_Angeles"
              , CAISO = "America/Los_Angeles"
              , MISO = "EST"                   # Does not follow Daylight Saving
              , PJM = "US/Eastern"
              , SPP = "US/Central"
              , SE = "EST"
              ) 

```

**Note**:
* Off- Peak Hours (HE): 1-6, 23-24
* On-Peak Hours (HE):7-22 

### Plots and Layouts

#### Layouts
```r
plot.new() # start a new plot
par(new=TRUE) # Overlay another plot

Layout0()
Layout6(title = 2)
Layout12(title = 3)
NPlotsLayout(n, withTitleSpace = FALSE)

par(mfrow=c(1,1), mar=c(4,4,4,2) + 0.1, oma=c(0,0,0,0))
par(mfrow=c(1,2), mar=c(4,3,4,1) + 0.1, oma=c(0,0,0,0))

# More complicated layout
layout(rbind(c(1,2), c(1,2)),widths=c(4,1),heights=c(1,1))
layout(matrix(c(1:2)),heights=c(4,1))

# modyfy plot borders
plot(, axes=FALSE)
box(fg = gray(0.5)); axis(c(1,2), fg = gray(0.5), col=gray(0.5))
```

Legend
```r
legend("topleft"
       , inset=.05
       , title="title"
       , c("x", "y", "z")
       , col=c(CA(1,1), CA(3,1), CA(6,1))
       , lty=c(0,0,1)
       , lwd=2
       , pch=c(15,15,NA)
       , pt.cex=2
       , horiz=FALSE
       , border=colorBWArray(0.8)
       , bg="white")
       
```

Plotting functions
```r

# returns plot ranges
par("usr")
text(par("usr")[1:2] %*% c(0.1,0.9), par("usr")[3:4] %*% c(0.1,0.9), "text")  # upper right
text(par("usr")[1:2] %*% c(0.9,0.1), par("usr")[3:4] %*% c(0.1,0.9), "text") # upper left

# Draw grid lines
DrawHLines(ylim)
Add.QlyShades(2010:2020)

# bar plot example
midpts <- barplot(height, names.arg
                  , col=CA(2,0.4), border=CA(2,1), ylab="", ylim=c(0,1800))
text(x=midpts, y=height, c("text", "text"), pos=1, col=CA(2,1))
box()
```

### Manipulate Data

#### Import & Export Data
```r
#csv
read.csv(, stringsAsFactors=FALSE
         , colClasses = classes # Specifying this makes reading faster
)

# Read in multiple files into a data frame. 
ldply(paths, read.csv, stringAsFactors = FALSE)

# Import
readr::read_csv(url, skip = 6, col_types = "Dnnnnnn")
jsonlite::read_jason()
xml2::read_xml()
curl::curl_download()

# Read Excel: load all the worksheets in a workbook at once
library(readxl)
library(dplyr)
library(purrr)
excel_sheets(path)
path %>%
  excel_sheets() %>%
  set_names() %>%
  map(read_excel, path = path)

# Identify column class
tab5rows <- read.table("datatable.txt", header = TRUE, nrows = 100) 
classes <- sapply(tab5rows, class) 

# Check if data set already exists
if(!exists("df")){}

```

#### Reformat data

```r
# Remove commas from a data frame
gsub(",", "", df)
for (col in 2:ncol(temp.df)) df[,col] <- as.numeric(gsub(",", "", df[,col]))
df[,-1] <- lapply(df[,-1, drop=FALSE], function(x){as.numeric(gsub(",", "", x))}) 
gsub("_.*", "", x) # Remove everything after "_"

# Example
files = c("tmp-project.csv", "project.csv", "project2-csv-specs.csv", "project2.csv2.specs.xlsx", "project_cars.ods"
, "project-houses.csv", "Project_Trees.csv","project-cars.R","project-houses.r", "project-final.xls", "Project-final2.xlsx")

# Hat means the beginnings
grep("^Proj", files, value = TRUE)
# Dollar means the end 
grep("\\.csv$", files, value = TRUE)
# OR
grep("\\.csv$|\\.ods$", files, value = TRUE)
grep("\\.(csv|ods)$", files, value = TRUE)
# '.*' means 1 or more of any character(s) 
grep("^(P|p)roject.*(csv|ods)$", files, value = TRUE)
# Combination... 
grep("(P|p)roject(\\_|\\-)[a-zA-Z]*\\.(csv|ods)$", files, value = TRUE)

```
[Summary of 'gsub'](http://www.endmemo.com/program/R/gsub.php)

```r
# Add comma for large numbers
format(12345.678,big.mark=",",scientific=FALSE)

# Assign itself as names
purrr::set_names(x) # x is a vector

### library(reshape2)
dcast()
melt()

### tidyr
gather(load.df, Month, Value, -Year) # For a data frame with Year, Jan, ..., Dec columns

### library(dplyr)
filter(df, month == 1, day == 1)
filter(df, month == 1 | month == 2)
arrange(df, year, month,day) # reorder by specificed columns
arrange(df, desc(year)) # decending order
select(df, year, month, day) # Select specified columns
select(df, year:day)
select(df, -(year:day))
select(df, old.name = new.name) # Rename columns while selecting certain columns
rename(df, old.name = new.name) # Renaming. 
distinct(select(df, col1, col2)) # faster than unique()
mutate(df,
  new.col1 = old.col1 - old.col2,
  new.col2 = new.col1 / old.col1 * 60)
sample_n(df, 10)

x <- 1:50
case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  TRUE ~ as.character(x)
)

# Unquoting quosure
my_group_by <- function(df, group_var) {
  group_var <- enquo(group_var)

  df %>%
    group_by(!!group_var) %>%
    summarise(a = mean(a))
}
my_group_by(df, g1)

summary_var <- quo(a)
df %>%
  group_by(g1) %>%
  summarise(
    mean = mean(!!summary_var),
    sd = sd(!!summary_var)
  )
)

## See: https://github.com/rstudio/webinars/blob/master/39-dplyr-0.7.0/tidyeval.R

```

#### Filter & Subsetting
```r
# Modifying data frame
df[,,drop=FALSE] # Preserving the type
df$col <- NULL # Removing columns

# vector contains a string 
grep("string", vector) # returns index number
grep("string", vector, value=TRUE) # returns values
grep("string1 | string2 | string3", vector) # returns index number
grepl("string", vector) # returns TRUE/FALSE

# 
isBetween(3:10, start=1, end=5)
isBetween(as.Date("2012-1-1"), startDate, endDate)
```

#### NA manipulation
```r
# Omit rows with incomplete data. 
df=na.omit(df)

#Replace NA
library(zoo)
na.approx( , na.rm=FALSE) # Fill in all missing data by liner interpolation or previous values
na.locf(, na.rm = FALSE) # Last observation carried forward
na.spline( , na.rm=FALSE) # cubic spline interpolation
na.zero() # replace by zero. 
```

#### Multicore run

```r
library(foreach)
library(doParallel)
cores <- detectCores(logical = FALSE) # Hyper-Threading is not much helpful for improving performance
cl <- makeCluster(cores)

registerDoParallel(cl, cores=cores)
r <- foreach(icount(trials), .combine=cbind) %dopar% {
  # execution
}

clusterExport(cl, c('solve.quad.eq', 'a', 'b', 'c')) # Export data and functions to workers
res1.p <- parLapply(cl, 1:len, function(x) { solve.quad.eq(a[x], b[x], c[x]) })

stopCluster(cl)

```

```r
library(parallel)
cluster <- makePSOCKcluster(cores)
parLapply(cluster, 1:10, f)
clusterExport(cluster, "x)
```

#### Functional Programing
```r
# Example
funs <- c(mean, median, sd, mad, IQR)
lapply(funs, function(f) f(x,na.rm=TRUE))
```

Note: use vapply instead of sapply for better handling of data types and computational speed. 
```r
vapply(lst, fun, numeric(1)) # returns a vector of numeric values. 
vapply(lst, fun, character(2)) # returns a matrix with 2 rows of strings.  
```

#### Reduce: extend a function that works with 2 inputs into a function that can deal with any number of inputs. 
```r
# Example
lst <- replicate(5, sample(1:10, 15, replace=TRUE), simplify = FALSE)
f <- intersect
Reduce(f,lst)
```

Predicate functionals
```r
df <- data.frame(x=1:3, y=c("a", "b", "c"))
Filter(is.factor, df)
Find(is.factor, df)
Position(is.factor, df)
```

#### Input Functional Operators
```r
# Partial Function Application by pryr::partial()
f <- partial(sum, na.rm=TRUE)
```

#### Other Utility Functions
```r
# Remove objects
rm(list=ls())
rm(list=grep("temp", ls(), value=TRUE)) # Remove all object containing "temp"

# Pause
readline("Press <return to continue") 

# record time 
ptm <- proc.time()
proc.time() - ptm

# File manipulation
file.copy(from, to, overwrite = TRUE)
file.exists(...)

```
### Meta-Programming

```r
deparse(substitute())
eval(quote())
```

#### Expression
```r
expression(phi)
expression(mu)
expression("main title"^2)
expression("sub-title"[2])
```

### htmlwidgets

**Leaflet** -- Map coordinates on google map
```r
library(leaflet)
leaflet(df) %>% cast
addTiles() %>% 
  addCircles(~Longitude, ~Latitude, color=~color)
```

**dygraphs** - Interactive Time Series Plot
```r
library(dygraphs)
library(xts)
x.ts <- as.xts(data.df[,"Sumas"], order.by = data.df$Date)
dygraph(x.ts, main = "Sumas") %>% 
  dyRangeSelector(dateWindow = c(data.df$Date[1], Sys.Date()))
```

### Colors
```r
rainbow.f(1, 0.5)
gray.f(0.5)
red.f(0.5)	
orange.f(0.5)
lightgreen.f(0.5)
green.f(0.5)
blue.f(0.5)
lightblue.f(0.5)
purple.f(0.5)
pink.f(0.5)	

# A function to convert a numeric values to a color on a palette. 
library(leaflet)
pal = colorBin("Spectral", domain = 0:16, bins = 7, pretty = TRUE, na.color = "#808080", alpha = FALSE)
col=pal(1:15)

# Make solid color transparent
makeTransparent(..., alpha=0.5)

terrain.colors(n, alpha=0.3)
### alpha indicate the transparency: 0 is transparent. 

library(RColorBrewer)
display.brewer.all(n=7, exact.n=FALSE)
brewer.pal(n,"Greens")
brewer.pal(n,"Spectral")
```

### Develop Packages
```r
library(devtools)
library(roxygen2)
roxygenise()
build_vignettes()
```

### SQL
```r
# Database connection
dsn <- "Driver={ODBC Driver 17 for SQL Server}; Server=SQLPAnalytics; Database=Ozette; Uid=uid; pwd=pass;"
con <- dbConnect(odbc::odbc(), .connection_string = dsn)
channel <- odbcDriverConnect(dsn)

RunID <- na.zero(as.numeric(dbGetQuery(con, glue("SELECT max(RunID) FROM {schema}.Runs;")))) + 1
# Write Run info 
df <- data.frame(RunID = RunID
                 , RunType = env.run
                 , RunStartDateTimeUTC = format(Sys.time(), tz = "UTC")
                 , RunEndDateTimeUTC = NA
                 , CreateUser = Sys.getenv("USERNAME")
                 , IsLatest = 0)
sqlSave(channel, df, tablename = glue(schema, ".Runs"), rownames = FALSE, append = TRUE)

# Database run updates
dbGetQuery(con, glue("UPDATE {schema}.Runs SET IsLatest = 0 WHERE IsLatest = 1"))
dbGetQuery(con, glue("UPDATE {schema}.Runs SET IsLatest = 1 WHERE RunID = {RunID}"))
dbGetQuery(con, glue("UPDATE {schema}.Runs SET RunEndDateTimeUTC = '{format(Sys.time(), tz = \"UTC\")}' WHERE RunID = {RunID}"))
dbDisconnect(con)
close(channel)
```



