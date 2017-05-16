shinyServer(function(input, output) {
   mirtable <- read.table("data/miRBase_conversion.csv",header=TRUE,sep="\t")
   
   text1 <- eventReactive(input$goButton, {
      input$mirname
   })
   
   text1<-mirtable[1,1]
   output$text <- renderText({
      text1()
   })
  
})
