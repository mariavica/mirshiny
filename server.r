shinyServer(function(input, output) {
  
  output$text <- renderPlot( 
    {input$mirname
     })
  
})
