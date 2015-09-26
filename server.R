library(RJSONIO)
library(RCurl)
library(ggplot2)

shinyServer(function(input, output) {
  
   output$wikichart <- renderPlot({
      
      input$goButton
          
      isolate(page<-c(input$article1, input$article2))
        
      plotofwiki <- ggplot() + scale_x_datetime() + xlab("") + ylab("")
        
      for (i in 1:2){
         raw_data <- getURL(paste("http://stats.grok.se/json/en/latest", 
                input$numofdays, "/", page[i], sep=""))
         data <- fromJSON(raw_data)
         views <- data.frame(timestamp=paste(names(data$daily_views), " 12:00:00", sep=""), stringsAsFactors=F)
         views$count <- data$daily_views
         views$timestamp <- as.POSIXlt(views$timestamp) # Transform to POSIX datetime
         views <- views[order(views$timestamp),]
                
         plotofwiki <- plotofwiki + geom_line(data=views, aes(timestamp, count, colour=i), colour=i)
      }
        
      plotofwiki
   })
  
})
