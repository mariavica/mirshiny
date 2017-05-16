shinyServer(function(input, output) {
   library(ggplot2)
   versions.mirnas <- read.table("https://raw.githubusercontent.com/mariavica/mirshiny/master/data/miRBase_conversions.csv",header=TRUE,sep="\t")
   
   mymirnas <- eventReactive(input$goButton, {
      input$mirname
   })
   
  
   output$text1 <- renderText({
      paste("Your miRNA is:",input$mirname,"\n")
   })      
   output$text2 <- renderText({
      paste("The header of mirtable is:",versions.mirnas[1,1])
   })
   
   
    output$percent <- renderPlot({
	    
	versions.mirnas<-versions.mirnas[,-1]

	perc <- function (x,target) {
		return(length(which((target %in% x) == TRUE)) / length(target) *100)
	}

	    mymirnas<-as.character(unlist(strsplit(mymirnas," ")))
	    
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
   
	    
   		qplot(x=dat$x, y=dat$y, geom="bar", stat="identity", fill=dat$x) +
            guides(fill=FALSE) + xlab("miRBase version") + ylab("Coincidence (%)")
   })
   
   
  
})
