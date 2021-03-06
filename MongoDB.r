###############################################
##
##  MongoDB Example Scripts
##
##  author: Eina Ooka
##  created: Oct 2016
##  
###############################################

## =========================================
## Test Basic MongoDB Con & Server Information
## =========================================

library(mongolite)

# Connect to db
con <- mongo("test1", db = "test", url = "mongodb://eooka:eooka1!@13.91.1.230:27017")

# count documents or "rows"
con$count() 

# Insert Data (append up to specified pagesize)
con$insert(mtcars)

# Query data
con$find()

# Find db information
temp <- con$info()
names(temp)
temp$name

names(temp$stats)
temp$stats$ns # Namespace
temp$stats$count 
temp$stats$size
temp$stats$capped
names(temp$stats$indexDetails) # indexes

names(temp$server)
temp$server$host # server
temp$server$pid # port id

# Delete entire collection with all data and metadata
con$drop()

# Automatically disconnect when connection is removed
rm(con)
gc()

## =========================================
## Query Basics
## =========================================

# establish connection
m <- mongo("zips", db = "test", url = "mongodb://eooka:eooka1!@13.91.1.230:27017", verbose = FALSE)

# Use jsonlite to import data
library(jsonlite)
stream_in(url("http://media.mongodb.org/zips.json"), handler = function(df){m$insert(df)})
# or simply... m$import(url("http://media.mongodb.org/zips.json"))

# Check count
m$count()

# Import. Note the 'location' column is actually an array!
zips <- m$find()
dim(zips)

# Query 
m$find('{"city" : "SEATTLE"}')
m$find('{"pop":{"$gt":100000}}') # Population greater than 100,000
m$find('{"city" : "SEATTLE", "pop":{"$gt":30000}}')

# Sorting
ptm <- proc.time()
m$find('{"pop":{"$gt":80000}}', sort='{"pop":-1}')
proc.time() - ptm

# Add index
m$index(add = "pop")
ptm <- proc.time() # check if the query runs faster
m$find('{"pop":{"$gt":80000}}', sort='{"pop":-1}')
proc.time() - ptm

# Return only certain columns
m$find('{"pop":{"$gt":80000}}', fields = '{"_id":0, "city":1, "pop":1}') # 1 for returning, 0 for not.

# List unique values
m$distinct("state", '{"pop":{"$gt":80000}}')

# aggregate
m$aggregate('[
            {"$group":{"_id":"$state", "total": {"$sum": "$pop"}}}
            , {"$sort" : {"total" : -1}}
            ]')

# Clean up
m$drop()
rm(m, zips)
gc()

## =========================================
## Another example
## =========================================

# Import from jsonlines stream from connection
dmd <- mongo("diamonds", db = "test", url = "mongodb://eooka:eooka1!@13.91.1.230:27017")
dmd$import(url("http://jeroenooms.github.io/data/diamonds.json")) # import takes ndjson formatted data
dmd$count()
temp <- dmd$find()
dim(temp)

tf <- tempfile()
dmd$export()

# Clean up
dmd$drop()
rm(dmd)
gc()

## =========================================
## Test Saving large dataset
## =========================================

library(mongolite)

# Create a dummy data
data.mtx <- array(rnorm(5*365 * 1000 * 50), dim=c(5*365, 1000, 50))
length(data.mtx) # 91,250,000 data points

# Connect to a database
mdb <- mongo(collection = "stochvars", db = "HedgeFox", url = "mongodb://eooka:eooka1!@13.91.1.230:27017")
mdb$drop()
mdb$count()

# Insert Data - 390.28 sec (6.5 min)
ptm <- proc.time()
for (i in 1:1000) mdb$insert(data.frame("Iter"=i, data.mtx[,i,]))
proc.time() - ptm

# Find Data - 593.91 sec (9.9 min)
ptm <- proc.time()
temp <- mdb$find()
proc.time() - ptm 

mdb$count()
dim(temp)

rm(mdb)
gc()

## =========================================
## Save large dataset as local JSON file
## =========================================

# Write output as JSON  # 5.88 sec for 100 iteration --> 64.6 MB JSON file
setwd("C:/Documents and Settings/murphyeo/Desktop")
ptm <- proc.time()
writeLines(toJSON(data.mtx[,1:100,]), "test.JSON")
proc.time() - ptm
# compare this to 2.77 sec for 66.8 MB MB RDS file             

# Call bulk insert from shell             
system("ls -F")        
            
## =========================================
## Blobbing with JSON
## =========================================           

nVars <- 50
            
library(jsonlite)
df <- data.frame("var"=paste0("Var",1:nVars), json=NA)
for (i in 1:nVars) df[i, "json"] <- toJSON(data.mtx[,,i])

library(mongolite)
mdb <- mongo(collection = "stochvars", db = "HedgeFox", url = "mongodb://eooka:eooka1!@13.93.223.54:27017")
mdb$count()
mdb$drop()

# Insert  - 190.76 sec (3.17 min)
ptm <- proc.time()
mdb$insert(df)
proc.time() - ptm 

# Pull - 110.40 sec
ptm <- proc.time()
temp <- mdb$find()
proc.time() - ptm 

 # Convert back to large matrix - 93.30 sec
ptm <- proc.time()
mtx <- array(NA, dim=c(dim(fromJSON(temp$json[1])), 50))
for (i in 1:50) mtx[,,i] <- fromJSON(temp$json[i])
proc.time() - ptm             

# Converting takes shorter if multi-threading -  55.58 sec
library(foreach)
library(doParallel)
library(abind)
cores <- detectCores() # Hyper-Threading is not much helpful for improving performance
cl <- makeCluster(cores-1)

ptm <- proc.time()
registerDoParallel(cl, cores=cores)
mtx2 <- foreach(i=1:50, .packages=c('jsonlite'), .combine=function(x,y)abind(x,y,along=3)) %dopar% {
  fromJSON(temp$json[i])
  }
stopCluster(cl)
proc.time() - ptm             
            
            
            
