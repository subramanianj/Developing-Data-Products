###### App for FindColor application
### Version 1: Aug 2014
######

###### Load required libraries

library(shiny)

## Get R colors matching string
yourColors <- function(colorStr) {
  y <- colors()[grep(tolower(colorStr), colors())]
  y
}

## For a given color, define a text color that will have good contrast
setTextColor <- function(color) {
  ifelse(mean(col2rgb(color)) > 127, "black", "white")
}


shinyServer(function(input, output, session) {
  ##### Computation, results, output
  
  output$matchColors <- renderPlot({
    colorStr <- input$colorStr
    if (colorStr == "") {
      stop("Enter (partial) name of any color")
    }
    matchColors <- yourColors(colorStr)
    textColor <- unlist(lapply(matchColors, setTextColor))
    
    n <- length(matchColors)
    
    if (n == 0){
      stop("No matching R colors! Enter another search string")
    } 
    
    if (n > 120){
      stop("Too many matching R colors! Enter a more specific search string")
    } 
    
    
    perCol <- 20  ## 20 colors in one column for good display
    nCols <- ceiling(n/perCol)
    maxCol <- 5   ## More then 5+1=6 columns will not display well in plot, with current settings
    
    ## Create plot region
    par(mar=c(1,1,1,1)) 
    plot(0, type="n", ylab="", xlab="", axes=FALSE,
         ylim=c(perCol,0), xlim=c(0,1.2))
    
    for (i in 0:(nCols-1)) {
      xl <- i/maxCol
      xu <- ((i+1)/maxCol)-0.025
      if (i == (nCols-1)) {
        lastCol <- ifelse((n < perCol*nCols), (n-(perCol*i)), perCol)
        yl <- 0:(lastCol-1)
        yu <- 1:lastCol
        rect(xl, yl, xu, yu,
             border="black", col=matchColors[((i*perCol)+1):((i*perCol)+lastCol)])
        text(xl+0.085, 0.45+(0:(lastCol-1)), 
             matchColors[((i*perCol)+1):((i*perCol)+lastCol)], 
             cex=0.8, font=2, col=textColor[((i*perCol)+1):((i*perCol)+lastCol)])
      } else {
        yl <- 0:(perCol-1)
        yu <- 1:perCol
        rect(xl, yl, xu, yu,
           border="black", col=matchColors[((i*perCol)+1):((i+1)*perCol)])
        text(xl+0.085, 0.45+(0:(perCol-1)), 
           matchColors[((i*perCol)+1):((i+1)*perCol)], 
           cex=0.8, font=2, col=textColor[((i*perCol)+1):((i+1)*perCol)])
      }
    }
  }) 
  
  output$colorStr <- renderPrint({input$colorStr})
  
})
