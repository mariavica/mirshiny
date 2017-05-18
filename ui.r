shinyUI(fluidPage(
  titlePanel("MiRTranslator"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Paste here your miRNAs"),
      textAreaInput(inputId = "mirname", label=NULL,cols=20,rows=5),
  #    helpText("or update your file"),
  #    fileInput(inputId = "mirfile", label=NULL, multiple = FALSE, accept = NULL, width = NULL, 
  #              buttonLabel = "Browse...", placeholder = "No file selected"),
      
      helpText("Your miRBase version"),
            
      selectInput(inputId = "mirfrom", label=NULL, choices=c("I don't know", "6.0", "7.0", "7.1", "8.0", "8.1", "8.2", "9.0", "9.1", "9.2", "10.0", "10.1", "11.0", "12.0", "13.0", "14", "15", "16", "17", "18", "19", "20", "21" ),
                  selected = "I don't know" , multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
      
      helpText("Your desired miRBase version"),
      selectInput(inputId = "mirto", label=NULL, choices=c("6.0", "7.0", "7.1", "8.0", "8.1", "8.2", "9.0", "9.1", "9.2", "10.0", "10.1", "11.0", "12.0", "13.0", "14", "15", "16", "17", "18", "19", "20", "21" ),
                  selected = "21", multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
      
      actionButton("goButton", "Go")
    ),    
    
    mainPanel(
      #textOutput("text2", container=span),
      helpText("Coincidences across miRNA versions"),
      plotOutput("percent"),

      textOutput("text1", container=span),
      
      helpText("Your translated miRNAs are:"),
      
      downloadButton("downloadTranslated",label="Download table"),
      
      
      tableOutput("translated")
      
      
      
    )
  )  
))
