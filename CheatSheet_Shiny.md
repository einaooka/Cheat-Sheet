#Shiny Cheat Sheet

#### Table of Contents
1. [Run](#run)

## Run
```r
setwd("O:/TEA-Risk-Model")
library(shiny)
runApp("RCode/shiny-app")
```

## Useful

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
