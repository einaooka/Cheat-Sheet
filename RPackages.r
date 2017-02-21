

install.packages(c("abind", "caret", "corrplot"
                  , "devtools", "doParallel", "dplyr", "DT", "dygraphs"
                  , "foreach", "forecast", "ggplot2", "jsonlite", "knitr"
                  , "leaflet", "leaps",  "MASS", "moments", "mongolite"
                   , "outliers"
                  , "randomForest", "readxl",  "RColorBrewer", "RCurl", "reshape2", "rhandsontable", "RODBC"
                  , "shiny", "shinydashboard", "shinyjs"
                  , "timeDate", "zoo"))
                  
library(devtools)
install_github("einaooka/tea.eo.plots")
install_github("einaooka/tea.datetime")
install_github("einaooka/tea.utilities")
