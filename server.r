shinyServer(function(input, output) {
   library(ggplot2)
   versions.mirnas <- read.table("https://raw.githubusercontent.com/mariavica/mirtools/master/data/miRBase_conversions.csv",header=TRUE,sep="\t")
   
   mymirnas <- eventReactive(input$goButton, {
      input$mirname
     
   })
   
   
   mirto <- eventReactive(input$goButton, {
     input$mirto
      })
   
   mirfrom <- eventReactive(input$goButton, {
     input$mirfrom
   })
   
   
   
    output$percent <- renderPlot({
      perc <- function (x,target) {
        return(length(which((target %in% x) == TRUE)) / length(target) *100)
      }
      
      versions.mirnas<-versions.mirnas[,-1]
      
      mymirnas<-unlist(strsplit(as.character(input$mirname),c("\\,|\\ |\\\n")))
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
      selectedversion<-dat[maxs[length(maxs)] ,"x"]	
      
	   
   		qplot(x=dat$x, y=dat$y, fill=dat$x) + geom_bar(stat="identity") +
   		  guides(fill=FALSE) + xlab("miRBase version") + ylab("Coincidence (%)")

   })
   
    output$text1 <- renderText({
      
      perc <- function (x,target) {
        return(length(which((target %in% x) == TRUE)) / length(target) *100)
      }
      
      versions.mirnas<-versions.mirnas[,-1]
      
      mymirnas<-unlist(strsplit(as.character(input$mirname),c("\\,|\\ |\\\n")))
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
      #print(dat)
      
      maxs<-which(dat$y==max(dat$y))
      selectedversion<-dat[maxs[length(maxs)] ,"x"]	
      
      
      paste("Your miRNA version is:",selectedversion,"\n")
    })  
    
      
    output$translated <- renderTable({
      
      if (as.character(input$mirfrom) == "I don't know") {
      
      
      perc <- function (x,target) {
        return(length(which((target %in% x) == TRUE)) / length(target) *100)
      }
      
      versions.mirnas<-versions.mirnas[,-1]
      
      mymirnas<-unlist(strsplit(as.character(input$mirname),c("\\,|\\ |\\\n")))
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
      selectedversion<-dat[maxs[length(maxs)] ,"x"]	
      } else {
        selectedversion<-as.character(input$mirfrom)
      }
      
      print(paste("miRBase_",selectedversion,sep=""))
      
        
      mymirnas<-as.character(mymirnas)
      
      mytrans<-data.frame(mymirnas)
      
      for (i in 1:nrow(mytrans)) {
        if (mymirnas[i] %in% versions.mirnas[,paste("miRBase_",selectedversion,sep="")] ) {
          mytrans[i,2]<-as.character(versions.mirnas[ which(  (versions.mirnas[,paste("miRBase_",selectedversion,sep="")] %in%  mymirnas[i])  ), c(paste("miRBase_",as.character(input$mirto),sep="")) ])
          
        } else {
          
          mytrans[i,2]<-"Not in input"
          
        }
      }
        
      colnames(mytrans)<-c("Original_names",c(paste("miRBase_",as.character(input$mirto),sep="")))
      
  
  
      
      
      print(mytrans)
    })
    
    
  
    
})
