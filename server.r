shinyServer(function(input, output) {

   text1 <- eventReactive(input$goButton, {
      input$mirname
   })
   output$text <- renderText({
      text1()
   })
  
})
