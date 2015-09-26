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

   output$average1 <- renderText({
           input$goButton
           isolate(article1<-input$article1)
           raw_data1 <- getURL(paste("http://stats.grok.se/json/en/latest", 
                                    input$numofdays, "/", article1, sep=""))
           data1 <- fromJSON(raw_data1)
           average1 <- ave(data1$daily_views)[1]
           average1
   })

   output$average2 <- renderText({
           input$goButton
           isolate(article2<-input$article2)
           raw_data2 <- getURL(paste("http://stats.grok.se/json/en/latest", 
                                    input$numofdays, "/", article2, sep=""))
           data2 <- fromJSON(raw_data2)
           average2 <- ave(data2$daily_views)[1]
           average2
   })
  
})
