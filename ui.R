
library(shiny)
require(shinydashboard)
library(dplyr)
library(ggplot2)
#all the datasets that are being used
gen<-read.csv("general.csv", stringsAsFactors = FALSE)
male<-read.csv("male.csv", stringsAsFactors = FALSE)
female<-read.csv("female.csv", stringsAsFactors = FALSE)
year <- c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017)
yr <- c("1990"=3,"1991"=4,"1992"=5,"1993"=6,"1994"=7,"1995"=8,"1996"=9,"1997"=10,"1998"=11,"1999"=12,"2000"=13,"2001"=14,"2002"=15,"2003"=16,"2004"=17,"2005"=18,"2006"=19,"2007"=20,"2008"=21,"2009"=22,"2010"=23,"2011"=24,"2012"=25,"2013"=26,"2014"=27,"2015"=28,"2016"=29,"2017"=30)

# Define UI for application that draws a histogram
shinyUI(
  dashboardPage(
    skin="red",
    dashboardHeader(title="Unemployed"), #title pf dashboard
    dashboardSidebar(
      sidebarMenu(
        #create two tabs and show it under sidebar
        menuItem("Unemployment rate", tabName = "dashboard", icon=icon("calculator")),
        menuItem("Dataset", tabName="dataset",icon=icon("book")),
        menuItem("Boxplot", tabName="boxplot",icon=icon("bar-chart-o")),
        menuItem("Comparison of Gender", tabName="compare",icon=icon("line-chart"))
      )
    ),
    dashboardBody(
      tabItems(
        # First tab content
        # Dashboard
        tabItem(tabName = "dashboard",
                h1("UNemployed"),
                
                fluidRow(
                  #image used
                  img(src='https://image.shutterstock.com/image-vector/male-boss-dismisses-pointing-hand-260nw-1361601686.jpg',  height="20%", width="100%", align = "center"),
                  h2("Basic concepts of unemployment"),
                  p("Unemployed = People who are jobless, looking for a job and available for work"),
                  p("The labor force is made up of the employed and the unemployed"),
                 
                  # Box 1: user input
                  
                  box(

                   
                    title=strong("Input Dashboard"), solidHeader = TRUE,collapsible=TRUE,status="danger",
                   
                    h4(strong("Choose your filter to visualise the data")),
                    htmlOutput("gender_selector"),
                    #choose year range
                    #sliderInput("year", "Year: ", 1999, 2016, value = c(2003, 2015), sep = ""),
                    #select countries
                    #
                    htmlOutput("country_selector")
                  ),
                  # Box 2: Frequency Graph
                  box (
                    #set bar title, the colour of the header and make it collapsible
                    title="Frequency Graph", solidHeader = TRUE,collapsible=TRUE,status="danger",
                    #inner part of result
                    h4(strong("Year versus Unemployment Rate")),###REMEMBER TO PUT COMMA
                    plotOutput("fgraph")
                        
                     
                    
                  ),
                  # Box 3: result 2
                  box(
                    title="Boxplot", solidHeader = TRUE, collapsible = TRUE,status="danger",
                    h4(strong("For the country chosen:")),
                    
                    # some basic information of graph
                    plotOutput("myplot")
                    
                  ),
                  # Box 4: result 3
                  box(
                    title="Exploratory Analysis", solidHeader = TRUE, collapsible = TRUE,status="danger",
                    h4(strong("Analysis for the chosen country:")),
                    
                    # some basic information of graph
                    textOutput("t1"),
                    textOutput("t2"),
                    textOutput("t3"),
                    textOutput("t4"),
                    textOutput("t5")
                    
                  )
                  
                )
                
                
                
        ),
        
        
        #Second tab
        
        tabItem(tabName = "dataset",
                #fluidPage(
                fluidPage(
                  h2("Dataset used"),
                  p("The dataset that we used is sorced from worldbank.org. Table below represents an interactive visualisation of dataset used"),
                  br(),
                  sidebarLayout(
                    sidebarPanel(
                      conditionalPanel(
                        'input.dataset === "gen"',
                        helpText("Choose the variable(s) to show"),
                        checkboxGroupInput("show_vars", "Columns in datasets:",
                                           names(gen), selected = )
                        
                      ),
                      conditionalPanel(
                        'input.dataset === "male"',
                        helpText("Choose the variable(s) to show"),
                        checkboxGroupInput("show_vars2", "Columns in datasets:",
                                           names(male), selected = )
                        
                      ),
                      conditionalPanel(
                        'input.dataset === "female"',
                        helpText("Choose the variable(s) to show"),
                        checkboxGroupInput("show_vars3", "Columns in datasets:",
                                           names(female), selected = )
                        
                      )
                    ),
                    
                    
                    
                    mainPanel(
                      tabsetPanel(
                        id = 'dataset',
                        tabPanel("gen", DT::dataTableOutput("mytable1")),
                        tabPanel("male", DT::dataTableOutput("mytable2")),
                        tabPanel("female", DT::dataTableOutput("mytable3"))
                      )
                    )
                  )
                  
                )#,DT::dataTableOutput("table")
        ),
        
        #third tab
        tabItem(tabName = "boxplot",
                #fluidPage(
                fluidPage(
                  h2("BoxPlot of The Whole Dataset from All Country"),
                  p("This visualisation gives us a bigger picture on global unemployment rate as a whole."),
                  br(),
                  plotOutput("myplot1")
                  
                )#,DT::dataTableOutput("table")
        ),
        
        #forth tab
        tabItem(tabName = "compare",
                fluidPage(
                  h2("Comparison of Unemployment Rate between Male and Female"),
                  p("The unemployment gender gap is defined as the difference between female and male unemployment rates. Global awareness of the gender gap in labour force has escalated  in recent years."),
                  br(),
                  sidebarLayout(
                    sidebarPanel(
                      selectInput("coun","Select a Country: ",female[,1])
                    ),
                    mainPanel(
                      plotOutput("comp")
                    )
                  )
                ))
        
        
        
      )
    )
  )
  
)
