shinyServer(function(input, output) {
   library(ggplot2)
   versions.mirnas <- read.table("https://raw.githubusercontent.com/mariavica/mirtools/master/data/miRBase_conversions.csv",header=TRUE,sep="\t")
   totrow<-nrow(versions.mirnas)
   totcol<-ncol(versions.mirnas)
   
   species_name<-c("Homo sapiens","Mus musculus")
   prefix<-c("hsa-","mmu-")
   
   
    maketable <- reactive( if (input$mirname!="")  {
      
      perc <- function (x,target) {
        return(length(which((target %in% x) == TRUE)) / length(target) *100)
      }
      
      versions.mirnas<-versions.mirnas[,-1]
      
      mymirnas<-unlist(strsplit(as.character(input$mirname),c("\\,|\\ |\\\n")))
      
      if (input$species!="select") {
        specie<-which(species_name %in% input$species)
        mymirnas<-paste(prefix[specie],mymirnas,sep="")
        mymirnas<-gsub(paste(prefix[specie],prefix[specie],sep=""),prefix[specie],mymirnas)
      } 
      
      if (input$capitalise) {
        mymirnas<-gsub("[mM][iI][rR]","miR",mymirnas)
        mymirnas<-gsub("[Ll][Ee][Tt]","let",mymirnas)
        mymirnas<-gsub("A","a",mymirnas)
        mymirnas<-gsub("B","b",mymirnas)
        mymirnas<-gsub("C","c",mymirnas)
        mymirnas<-gsub("D","d",mymirnas)
        mymirnas<-gsub("E","e",mymirnas)
        mymirnas<-gsub("F","f",mymirnas)
        mymirnas<-gsub("G","g",mymirnas)
        mymirnas<-gsub("H","h",mymirnas)
        mymirnas<-gsub("I","i",mymirnas)
        mymirnas<-gsub("J","j",mymirnas)
      }
      
      mymirnas<-mymirnas[which(mymirnas!="")]
      print(mymirnas)
      
      a<-apply(versions.mirnas,2,perc,mymirnas)
      
      dat<-data.frame(x=names(a),y=a)
      
      dat$x<-factor(gsub("miRBase_","",dat$x))
      dat$x<-relevel(dat$x,"9.2")
      dat$x<-relevel(dat$x,"9.1")
      dat$x<-relevel(dat$x,"9.0")
      dat$x<-relevel(dat$x,"8.2")
      dat$x<-relevel(dat$x,"8.1")
      dat$x<-relevel(dat$x,"8.0")
      dat$x<-relevel(dat$x,"7.1")
      dat$x<-relevel(dat$x,"7.0")
      dat$x<-relevel(dat$x,"6.0")
      print(dat)
      
      maxs<-which(dat$y==max(dat$y))
      proposedversion<-dat[maxs[length(maxs)] ,"x"]	
      
      
      if (input$mirfrom != "I don't know") {
        print("entering")
        selectedversion<-input$mirfrom
      } else {
        selectedversion<-proposedversion
      }
      
      print(paste("miRBase_",selectedversion,sep=""))
      
      mymirnas<-as.character(mymirnas)
      
      mytrans<-data.frame(mymirnas)
      
      for (i in 1:nrow(mytrans)) {
        if (mymirnas[i] %in% versions.mirnas[,paste("miRBase_",selectedversion,sep="")] ) {
          mytrans[i,2]<-as.character(versions.mirnas[ which(  (versions.mirnas[,paste("miRBase_",selectedversion,sep="")] %in%  mymirnas[i])  ), c(paste("miRBase_",as.character(input$mirto),sep="")) ])
          
        } else {
          
          if (mymirnas[i] %in% as.vector(as.matrix(versions.mirnas))) {
            
            if (input$forceTranslation) {
                  coincidences <- which(t(versions.mirnas)==mymirnas[i])
                  print(coincidences)
                  rowmir <- ceiling(coincidences[length(coincidences)]/(totcol-1))
                  print(rowmir)
                  
                  mytrans[i,2]<-as.character(versions.mirnas[rowmir, c(paste("miRBase_",as.character(input$mirto),sep="")) ])
            }
            
            else {
            
            coincidences <- which(versions.mirnas==mymirnas[i])
            version <- colnames(versions.mirnas)[ceiling(coincidences[length(coincidences)]/totrow)]
            
             mytrans[i,2]<-as.character(paste("Not found in miRBase_",selectedversion," (found in ", version,")", sep=""))
             
            }
             
          } else {
            mytrans[i,2]<-paste("Unknown miRNA")
          }
          
        }
      }
      
      colnames(mytrans)<-c((paste("miRBase_",as.character(selectedversion),sep="")),c(paste("miRBase_",as.character(input$mirto),sep="")))
      
      
      return(list(mytrans,proposedversion,dat))
    })
    
    output$text1 <- renderText({
      paste("Most of your miRNAs are from version:",maketable()[[2]],"\n")
    })  
    
    
    output$percent <- renderPlot({
      datp<-maketable()[[3]]
      qplot(x=datp$x, y=datp$y, fill=datp$x) + geom_bar(stat="identity") +
        guides(fill=FALSE) + xlab("miRBase version") + ylab("Coincidence (%)")
      
    })
    

    output$translated<-renderTable(maketable()[[1]])
    
    output$downloadTranslated <- downloadHandler( filename="translated.csv", content=function (file){ write.csv(maketable()[[1]], file, row.names=FALSE, sep="\t", quote=FALSE) })
    

    
})
