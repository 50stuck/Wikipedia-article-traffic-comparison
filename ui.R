library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Wikipedia article traffic comparison"),
  sidebarPanel(
    column(width=12,
           radioButtons("numofdays", "latest ... days", list("30", "60", "90"), inline=TRUE
                        ),
           textInput("article1", label="First Article (black line):", value="Marco Rubio"),
                print("Average daily traffic: "),
                verbatimTextOutput("average1"),
           textInput("article2", label="Second Article (red line):", value="Jeb Bush"),
                print("Average daily traffic: "),
                verbatimTextOutput("average2"),
           actionButton("goButton", "Compare!"),
           
           h5("Enter two english Wikipedia articles to compare the traffic of, and
              choose length of comparison period")
            )
  ),
  mainPanel(
          plotOutput("wikichart")
  )
))