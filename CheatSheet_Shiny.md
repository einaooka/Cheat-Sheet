#Shiny Cheat Sheet

#### Table of Contents
1. [Run](#run)
1. [Handsontable](#handsontable)
1. [Download](#download)
1. [Dynamic UI](#dynamic-ui)
2. [Other Functions](#other-functions)

### Run
```r
setwd("O:/TEA-Risk-Model/RCode/shiny-app")
library(shiny)
runApp()
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

### Download

```r
# ui
downloadButton("download.xxx", label = "Download")

# server
output$download.xxx <- downloadHandler(
  filename = function() {paste0("result-", Sys.Date(),".csv")}
  , content = function(file) { write.csv(df, file, row.names = FALSE) }
)
```

### Dynamic UI

```r
# ui
uiOutput("ui.xxx")

# server
output$ui.xxx <- renderUI({
  # UI widgets
})

# inputs from UI widgets need validation before used in server. 
validate()

```


### Other Functions

Blocking reactivity
```r
isolate()
```

Time-based reactivity (and so much more)
```r
invalidateLater()
```

Mechanisms for dealing with missing inputs and failed preconditions
```r
validate 
req # if not truthy, stop by raising a "silent" exception

output$plot <- renderPlot({
  if (req(input$plotType) == "histogram") {
    hist(dataset())
  } else if (input$plotType == "scatter") {
    qplot(dataset(), aes(x = x, y = y))
  }
})
```

```r
# Higher order reactives by Hadley
shinySignals

# observe : observeEvent = reactive : eventReactive
eventReactive
```
