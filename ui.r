shinyUI(fluidPage(
  titlePanel("MiRTranslator"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Write here your miRNA name"),
      
    textInput(inputId = "mirname"),
       
    mainPanel(
      textOutput("text")
    )
  )
))
