shinyUI(fluidPage(
  titlePanel("MiRNA version identifier and translator"),
  
  sidebarLayout(
    sidebarPanel(
      
      helpText("Upload your file (\"*txt\" or \"*csv\" plain file):"),
      
      fileInput(inputId="csvfile", label=NULL , multiple = FALSE, accept = c(
        "text/csv", "text/comma-separated-values,text/plain",".csv",".txt"), width = NULL,
        buttonLabel = "Browse...", placeholder = "No file selected"),
      
      helpText("or paste here your miRNAs to start:"),
      textAreaInput(inputId = "mirname", label=NULL,cols=20,rows=17),
  #    helpText("or update your file"),
  #    fileInput(inputId = "mirfile", label=NULL, multiple = FALSE, accept = NULL, width = NULL, 
  #              buttonLabel = "Browse...", placeholder = "No file selected"),

      helpText("Your miRBase version"),
            
      selectInput(inputId = "mirfrom", label=NULL, choices=c("I don't know", "6.0", "7.0", "7.1", "8.0", "8.1", "8.2", "9.0", "9.1", "9.2", "10.0", "10.1", "11.0", "12.0", "13.0", "14", "15", "16", "17", "18", "19", "20", "21" ),
                  selected = "I don't know" , multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
      
      helpText("Your desired miRBase version"),
      selectInput(inputId = "mirto", label=NULL, choices=c("6.0", "7.0", "7.1", "8.0", "8.1", "8.2", "9.0", "9.1", "9.2", "10.0", "10.1", "11.0", "12.0", "13.0", "14", "15", "16", "17", "18", "19", "20", "21" ),
                  selected = "21", multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),

   helpText(strong("Proofreading:")),
  
  
  
        checkboxInput(inputId="forceTranslation",label="Force translation (miRNAs from other versions will be automatically translated to desired version)", value=FALSE),

  checkboxInput(inputId="capitalise",label="Correct capital letters (valid only for \"miR\" and \"let\")", value=FALSE),
  
    
  helpText("MiRNA species"),
  
  selectInput(inputId = "species", label=NULL, choices=c("select","Homo sapiens","Mus musculus"),
              selected = "Specified in name", multiple = FALSE, selectize = TRUE, width = NULL, size = NULL)
  
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
