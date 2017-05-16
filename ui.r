shinyUI(fluidPage(
  titlePanel("MiRTranslator"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Write here your miRNA name"),
      textInput(inputId = "mirname", label=NULL),
      actionButton("goButton", "Go")
    ),    
    
    mainPanel(
      textOutput("text", container=span)
    )
  )  
))
