shinyServer(function(input, output) {
   mirtable <- read.table("https://raw.githubusercontent.com/mariavica/mirshiny/master/data/miRBase_conversions.csv",header=TRUE,sep="\t")
   
   text1 <- eventReactive(input$goButton, {
      input$mirname
   })
   
   text1<-mirtable[1,1]
   output$text <- renderText({
      text()
   })
  
})
