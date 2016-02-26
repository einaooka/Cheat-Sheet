#Useful R Codes

#### Table of Contents
1. [Packages](#packages)
2. [Date Time Manipulation](#date-time-manipulation)
3. [Plots and Layouts](#plots-and-layouts)
4. [Manipulate Data](#manipulate-data)
5. [Interactive Java Plots](#interactive-java-plots)
6. [multicore run](#multicore-run)
7. [Colors](#colors)
8. [Expression](#expression)
9. [Develop Packages](#develop-packages)


## Packages

##### Custom
```r
library(tea.eo.plots)
library(tea.color)
library(tea.datetime)
library(tea.utilities)
```

##### Often Used
```r
library(reshape)
library(RCurl)
library(corrplot)
library(leaps) # subset regression
library(zoo)
```

##### set directory
```r
setwd("C:/Documents and Settings/murphyeo/Desktop")
```

## Date Time Manipulation

```r
help(package = "tea.datetime")

as.Date0("date")

MonthFromDate(date)
YearFromDate(date)
FirstDayOfMonth(date)
DOW(date)	

DateAsDateTime(date)	
DateFromDateTime(datetime)	
HourFromDateTime(datetime)
DateAndHEAsPOSIX(date, HE)

MonthName(month, short = TRUE)
NumDaysInMonth(date)

dates <- seq(as.Date("2015-1-1"),as.Date("2020-1-1"), by=1)
GetDateTable(dates, c("Date", "pk.nHours", "opk.nHours"))	

Sys.Date() # Today's date

as.POSIXct(strptime(, "%m/%d/%Y %H:%M"))
as.POSIXct(strptime(, "%m/%d/%Y %I:%M:00 %p"))

```

**Note**:
Off- Peak Hours (HE): 1-6, 23-24
On-Peak Hours (HE):7-22 

## Plots and Layouts
```r
help(package = "tea.eo.plots")

plot.new() # start a new plot
par(new=TRUE) # Overlay another plot

Layout0()
Layout6(title = 2)
Layout12(title = 3)
title(main=MonthName(month), line=-2)

NPlotsLayout(n, withTitleSpace = FALSE)

par(mfrow=c(1,1), mar=c(4,4,4,2) + 0.1, oma=c(0,0,0,0))
par(mfrow=c(1,2), mar=c(4,3,4,1) + 0.1, oma=c(0,0,0,0))

# More complicated layout
layout(rbind(c(1,2), c(1,2)),widths=c(4,1),heights=c(1,1))
layout(matrix(c(1:2)),heights=c(4,1))

# modyfy plot borders
plot(, axes=FALSE)
box(fg = gray(0.5)); axis(c(1,2), fg = gray(0.5), col=gray(0.5))

# Legend
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

# Draw grid lines
DrawHLines(ylim)
Add.QlyShades(2010:2020)

# Add percentiles to a plot
QLines(df$Date, df$Y, mean.lwd = 2)
QMatLines(df$Date, df[,-1], qs=c(0.25,0.75), q.col=gray.f(0.5))

# Stochastic Projection
PlotStochastic(date, y1, blue.f, q1 = c(0.05,0.95), q2=c(0.25, 0.75), ylab="y")
Plot2Stochastics(date, y1, y2, red.f, blue.f, qs = c(0.05,0.95), ylab="y") # 2 series
PlotMatStochastic(df$Date, df[,-1], blue.f, q1 = c(0.05,0.95), q2=c(0.25, 0.75), ylab="y") # Short table

# Stacked area
PlotStackedArea(x, ys, cols = c(NA, NA), legend = list(need = FALSE,location = "topleft", cex = 1), ...)
PlotArea(x, y, col, add = FALSE, ...)
FillArea(x, y, col)

#Plot a histogram with quantiles
PlotHistogram(x, green.f)
PlotHistogram(x, blue.f, textStagger=TRUE)
PlotHistograms(list("x1"=x1, "x2"=x2), cols.f = list(red.f, blue.f), qs=c(0.05, 0.95)) # multiple histograms

# Display table
PlotTable(BasisDiff.df, col.f=orange.f)
PlotTable(BasisDiff.df, col.f=blue.f, colnames=c("Month", "On-Peak", "Off-Peak"))

# returns plot ranges
par("usr")

# bar plot example
midpts <- barplot(height, names.arg
                  , col=CA(2,0.4), border=CA(2,1), ylab="", ylim=c(0,1800))
text(x=midpts, y=height, c("text", "text"), pos=1, col=CA(2,1))
box()
```


## Manipulate Data

```r
help(package = "tea.utilities")

# Import data 
read.csv(, stringsAsFactors=FALSE
         , colClasses = classes # Specifying this makes reading faster
)

# Identify column class
tab5rows <- read.table("datatable.txt", header = TRUE, nrows = 100) 
classes <- sapply(tab5rows, class) 

# Import Data from Zema: RiskModelInput_MidC-Gas, AMP.AD.HH.Daily
ImportFromZema("HH Forward curves", "eina.murphy", timestep = "Monthly", useCurl=FALSE)
ImportFromZema("CAISO_SP15_DailyPrices", "eina.murphy", timestep = "Daily", useCurl=FALSE)

# Conver daily <--> Monthly
ConvertDailyToMonthly(df)
ConvertMonthlyToDaily(df, type = c("step", "smooth"))

# Check if a file exists
if(!exists("df")){}

# Remove commas from a data frame
gsub(",", "", df)
for (col in 2:ncol(temp.df)) df[,col] <- as.numeric(gsub(",", "", df[,col]))
gsub("_.*", "", x) # Remove everything after "_"

# Add comma for large numbers
format(12345.678,big.mark=",",scientific=FALSE)

# Omit rows with incomplete data. 
df=na.omit(df)

# vector contains a string 
grep("string", vector) # returns index number
grep("string1 | string2 | string3", vector) # returns index number
grepl("string", vector) # returns TRUE/FALSE

### Pivot table - make long table (df) into wide table with row (colName1) and column (colName2). 
cast(df, colName1 ~ colName2, value="colName3", fun.aggregate=NULL, subset=())

### Reshape a short table to a long table
reshape(data.df # data frame
        , varying = colnames(data.df)[-1] # column names to be combined into one
        , times = colnames(temp.df)[-1] # 
        , v.names = "Load" # New column names for combined data
        , timevar = "HE"   # New column names for the label (original coliumn names)
        , direction = "long")
melt(data)

### Fill in all missing data by liner interpolation or previous values
na.approx( , na.rm=FALSE)
na.locf(, na.rm = FALSE) # Last observation carried forward
na.spline( , na.rm=FALSE)
na.zero()

# Remove objects
rm(list=ls())
rm(list=ls()[grep("temp", ls()) ]) # Remove all object containing "temp"

# Pause
readline("Press <return to continue") 

# record time 
ptm <- proc.time()
proc.time() - ptm

# File manipulation
file.copy(from, to, overwrite = TRUE)
file.exists(...)

# 
isBetween(3:10, start=1, end=5)
isBetween(as.Date("2012-1-1"), startDate, endDate)

# save r-object
saveRDS(df, paste0("filename", Sys.Date(), ".rds"))
```

## Interactive Java Plots

```r
# Map coordinates on google map
library(leaflet)
leaflet(df) %>% cast
addTiles() %>% 
  addCircles(~Longitude, ~Latitude, color=~color)

# Interactive Time Series Plot
library(dygraphs)
library(xts)
x.ts <- as.xts(data.df[,"Sumas"], order.by = data.df$Date)
dygraph(x.ts, main = "Sumas") %>% 
  dyRangeSelector(dateWindow = c(data.df$Date[1], Sys.Date()))

# Data Table
library(DT)
datatable(data.df, options = list(pageLength = 20)
          , colnames = colnames(data.df)
          , rownames = FALSE)
```

## multicore run

```r
library(foreach)
library(doParallel)
cl <- makeCluster(5)
registerDoParallel(cl)

r <- foreach(icount(trials), .combine=cbind) %dopar% {
  # execution
}
```


## Colors
```r
rainbow.f(1, 0.5)
gray.f(0.5)

# Individual Colors
red.f(0.5)	
orange.f(0.5)
lightgreen.f(0.5)
green.f(0.5)
blue.f(0.5)
lightblue.f(0.5)
purple.f(0.5)
pink.f(0.5)	

# Make solid color transparent
makeTransparent(..., alpha=0.5)

terrain.colors(n, alpha=0.3)
### alpha indicate the transparency: 0 is transparent. 

library(RColorBrewer)
display.brewer.all(n=7, exact.n=FALSE)
brewer.pal(n,"Greens")
brewer.pal(n,"Spectral")
```

## Expression
```r
expression(phi)
expression(mu)
expression("main title"^2)
expression("sub-title"[2])
```

## Develop Packages
```r
library(devtools)
library(roxygen2)
roxygenise()

library(devtools)
install_github("einaooka/tea.eo.plots")
install_github("einaooka/tea.color")
install_github("einaooka/tea.datetime")
install_github("einaooka/tea.utilities")
```r
