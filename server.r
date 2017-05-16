shinyServer(function(input, output) {
   mirtable <- read.table("https://raw.githubusercontent.com/mariavica/mirshiny/master/data/miRBase_conversions.csv",header=TRUE,sep="\t")
   
   text1 <- eventReactive(input$goButton, {
      input$mirname
   })
   
   output$text1 <- renderText({
      paste("Your miRNA is:",as.character(text1))
   })      
   output$text2 <- renderText({
      paste("The header of mirtable is:",mirtable[1,1])
   })
  
})
