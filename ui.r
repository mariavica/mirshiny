shinyUI(fluidPage(
  titlePanel("MiRTranslator"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Write here your miRNA name"),
      textInput(inputId = "mirname", label=NULL),
      helpText("or update your file"),
      fileInput(inputId = "mirfile", label=NULL, multiple = FALSE, accept = NULL, width = NULL, 
                buttonLabel = "Browse...", placeholder = "No file selected"),
      
      helpText("Your miRBase version"),
      
      selectInput(inputId = "mirfrom", label=NULL, choices=c("6","7","21","I dont't know"),
                  selected = "I don't know", multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
      
      helpText("Your desired miRBase version"),
      selectInput(inputId = "mirto", label=NULL, choices=c("6","7","21"),
                  selected = "I don't know", multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
      
      actionButton("goButton", "Go")
    ),    
    
    mainPanel(
      textOutput("text1", container=span),
      textOutput("text2", container=span)

    )
  )  
))
