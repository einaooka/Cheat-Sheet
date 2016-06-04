#Shiny Cheat Sheet

#### Table of Contents
1. [Basic](#basic)
1. [Debugging](#debugging)
1. [Download](#download)
1. [Error Handling](#error-handling)
1. [Handsontable](#handsontable)

### Basic
#### Run
```r
library(shiny)
runApp("shiny-app")
```

#### Render/Output pair
| Render        | Output           | 
| ------------- |:-------------:| 
| renderDataTable   | dataTableOutput | 
| renderImage    | imageOutput    |  
| renderPlot | plotOutput    |  
| renderPrint | verbatimTextOutput   |  
| renderTable | tableOutput    |  
| renderText | textOutput     |  
| renderUI | uiOutput     |  

### Debugging
```r
suppressMessages(library(plyr))

# Run the following and press Ctrl + F3
options(shiny.reactlog=TRUE) 

# Pausing on errors
options(shiny.error = browser)

# Print information on the console
cat(file=stderr(), "Reading data from", input$datanase.name)
```

### Error Handling
```r 
validate(need(try(reactive.exp()), "Could not connect to the database. Please check the information."))

validate(
      need(input$data != "", "Please select a data set"),
      need(input$data %in% c("mtcars", "faithful", "iris"), "Unrecognized data set"),
      need(input$data, "Input is an empty string"),
      need(!is.null(input$data), "Input is not an empty string, it is NULL")
)
```

### Download

#### csv
```r
# ui
downloadButton("download.xxx", label = "Download")

# server
output$download.xxx <- downloadHandler(
  filename = function() {paste0("result-", Sys.Date(),".csv")}
  , content = function(file) { write.csv(df, file, row.names = FALSE) }
)
```

#### rmarkdown
```r
# ui
downloadButton("report", label = "Generate Report"))

# server
output$report<- downloadHandler(
  filename = function() { 
    paste0('report.', Sys.Date(),'.html')
  }
  , content = function(file) {
    out <- render('report.Rmd', "html_document")
    file.rename(out, file)
  }
)
```

### Handsontable

```r
library(rhandsontable)

# ui
rHandsontableOutput("table.xxx")

# server
output$table.xxx <- renderRHandsontable({
  rhandsontable(df, readOnly = TRUE, rowHeaders=NULL) %>%
      hot_cols(colWidths = c(150, 80, 80, 80, 110)) %>% 
      hot_col("Hist", format = "0.0") %>%
      hot_heatmap(color_scale = c("#ffffff", "#FEB24C")) %>%
      hot_cols(fixedColumnsLeft = 1)
})

```
