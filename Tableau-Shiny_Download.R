#----------------------
# Test with mytab_test.csv
#---------------------


#library(shiny)

shinyApp(
    ui = fluidPage(
      titlePanel("Uploading Files"),
      sidebarLayout(
        sidebarPanel(
          fileInput('file1', 'Choose CSV File',
                    accept=c('text/csv', 
                             'text/comma-separated-values,text/plain', 
                             '.csv')),
          tags$hr(),
          checkboxInput('header', 'Header', TRUE),
          radioButtons('sep', 'Separator',
                       c(Comma=',',
                         Semicolon=';',
                         Tab='\t'),
                       ','),
          radioButtons('quote', 'Quote',
                       c(None='',
                         'Double Quote'='"',
                         'Single Quote'="'"),
                       '"')
        ),
        mainPanel(
          tableOutput("contents"),
          textOutput("text1")
        )
      )
    ),
    server = function(input, output) {
      output$contents <- renderTable({

        inFile <- input$file1
        
        if (is.null(inFile))
          return(NULL)
        
        read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                 quote=input$quote)
      })
      
      output$text1 <- renderText({
        inFile <- input$file1
        
        if (is.null(inFile))
          return(NULL)
        
        mytab=read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                 quote=input$quote)
        
        sumcol1= sum(mytab[,1])
          paste("Somme de la prmière colonne : ", sumcol1)
        })
      
      
    }
)