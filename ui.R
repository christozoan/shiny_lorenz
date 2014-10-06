library(shiny)
library(rgl)
library(shinyRGL)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Lorenz system demo"),

  sidebarLayout(
    sidebarPanel(
      helpText("Function parameters:"),
      sliderInput("a",
                  "a (default -2.66)",
                  min = -15,
                  max = 0,
                  value = -2.66,
                  step = 0.1,
                  width = 400),
      sliderInput("b",
                  "b (default -10)",
                  min = -100,
                  max = 00,
                  value = -10,
                  step = 1,
                  width = 400),
      sliderInput("c",
                  "c (default 28)",
                  min = -75,
                  max = 100,
                  value = 28,
                  step = 1,
                  width = 400),
      HTML("<br>"),
      helpText("Time series options (T0==0):"),
      numericInput("dT", 
                   "Time step (default 0.003)", 
                   0.003),
      numericInput("TF", 
                   "Stop time (default 100)", 
                   100, 
                   min = 1,
                   step = 1),
      HTML("<br><br>"),
      checkboxInput("threeD", 
                    "Display 3d plot (experimental/buggy)",
                    value=FALSE),
      
      conditionalPanel("input.threeD==false", 
        helpText("Plot axes"),              
        selectInput("x_axis", "Horizontal axis variable", 
                    list("X","Y","Z","T"), 
                    selected = "X"
                    ),
        selectInput("y_axis", "Vertical axis variable", 
                      list("X","Y","Z","T"), 
                      selected = "Y"
                      )
      ),
      
   #   conditionalPanel("input.cage==true", 
   #                     img(src="cage.jpg")),
      HTML("<br>"),
      helpText("Plot color"),
      sliderInput("R", "Red", value=0, min=0, max=255, step=1),
      sliderInput("G", "Green", value=0,min=0,max=255, step=1),
      sliderInput("B", "Blue", value=255,min=0, max=255, step=1),
#      sliderInput("A", "Alpha", value=255,min=0, max=255, step=1),
      HTML("<br>"),
      checkboxInput("cage",
                    "Leave this box unchecked", 
                    value=FALSE)
    ),  
  
    mainPanel(

        #conditionalPanel("input.threeD==true",
        #    webGLOutput("lorenzPlot3d", width = 650, height = 650)
        #),
        conditionalPanel("input.threeD==false",
            plotOutput("lorenzPlot2d", width = 600, height = 600)
        )
        
    )
  )
))

