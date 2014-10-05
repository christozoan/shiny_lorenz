library(shiny)
library(rgl)
library(shinyRGL)

shinyServer(function(input, output) {

    lorenz = function(X0 = 1, Y0 = 1, Z0 = 1,          
                      a = -8/3, b = -10, c = 28,       
                      T0 = 0, TF = 100, dT = 0.006)  {
        X = X0    
        Y = Y0
        Z = Z0
  
        Ts = seq(from = T0, to = TF, by = dT)  
        L = length(Ts)                         
        Xs = Ys = Zs = rep(0, L)

        for(i in 1:L)      {    
       
            Xs[i] = X            
            Ys[i] = Y
            Zs[i] = Z          
      
            dX = (a*X + Y*Z)*dT    
            dY = (b * (Y-Z))*dT   
            dZ = (-X*Y + c*Y - Z)*dT  
            
      
                   
            X = X + dX            
            Y = Y + dY
            Z = Z + dZ
        }   
        
        # rename variables for plot
        x = Xs
        y = Ys
        z = Zs
        t = Ts
        return(data.frame(x,y,z,t))
    }      
  
    
    lorenz_data = reactive({
        lorenz(a = input$a, 
               b = input$b, 
               c = input$c,
               dT = input$dT,
               TF = input$TF)
    })
    
    color = reactive({
        rgb(input$R, input$G, input$B, input$A,
            maxColorValue = 255) 
    })
    
    xax_number = reactive({
        xax = input$x_axis                   
        if(xax=="X") {
            return(1)
        }else if(xax=="Y"){ 
            return(2)
        }else if(xax=="Z"){ 
            return(3)
        }else {
            return(4)   
        }   
    })
    
          
    yax_number = reactive({
        yax = input$y_axis
        if(yax=="X") {
            return(1)
        }else if(yax=="Y"){ 
            return(2)
        }else if(yax=="Z"){ 
            return(3)
        }else {
            return(4)   
        }  
    }) 

                          
  output$lorenzPlot2d <- renderPlot({
     plot(lorenz_data()[,xax_number()], 
          lorenz_data()[,yax_number()], 
          type='l',
          col = color(),
          main = "Time Series",
          xlab = input$x_axis,
          ylab = input$y_axis
         )

     mtext("dx/dt = ax + yz",3,3, adj = 0)
     mtext("dy/dt = b(y - z)",3,2, adj = 0)
     mtext("dz/dt = cy - xy - z",3,1, adj = 0)
  })
  
  output$lorenzPlot3d <- renderWebGL({
       plot3d(lorenz_data()[,1], 
              lorenz_data()[,2], 
              lorenz_data()[,3],
              type='l',
              col = color(),
              main = "",
              xlab = "",
              ylab = "",
              zlab = "",
              box=FALSE,
              axes=FALSE
              
       )
  })


})

