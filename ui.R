library(shiny)

### Define UI for FindColor application
### Version 1: Aug 2014
###

shinyUI(
  pageWithSidebar(
    headerPanel(HTML('<center><img src="title.bmp"></center>'),
                "Show R colors"),
    #headerPanel(h2(img(src="title.bmp", align="center")),"Show R colors"),
    
    sidebarPanel(
      textInput(inputId="colorStr", label="Enter Color Name to Match", value="orchid"),
      submitButton('Submit')
    ),
    
    mainPanel(
      wellPanel(h4("About this app.."),
                p("Colors are very important for the graphical visualization of the 
                    results of a data analysis. There are 657 colors that are defined in R using  
                    color names. The names of these colors can be obtained using the", code("colors()"), 
                    "command in R.  
                    Some examples of color names in R include exotic sounding ones such as 'steelblue1', 'thistle', 
                    'mintcream' and so on! But how do these colors actually look?"),
                p("This Shiny app can be used to quickly visulize how the named colors in R look 
                    onscreen before they are used in graphics."),
                h4("Using this app:"),
                HTML('<ol><li>Enter a common color name (or a string) in the text box provided on the left
                  and click <b> Submit </b></li>
                  <li> The named colors in R that contain the entered string are displayed below.
                        An example is provided for colors in R that match the string 
                      <em> orchid </em></li>
                      <li> If no match is found for the user entered term, an error
                        message is displayed </li></ol>'),
                h4("Reference:"),
                HTML('<p><A href="http://research.stowers-institute.org/efg/R/Color/Chart/"
                       target="_blank">Chart of R Colors</A></p>')
               ),
      wellPanel(h4("You entered text:"),
      verbatimTextOutput("colorStr"),
      h4("Matching named colors in R:"),
      plotOutput("matchColors")
    )
  )
))