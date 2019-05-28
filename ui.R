
library(shiny)
require(shinydashboard)
library(dplyr)
library(ggplot2)
#all the datasets that are being used
gen<-read.csv("general.csv", stringsAsFactors = FALSE)
male<-read.csv("male.csv", stringsAsFactors = FALSE)
female<-read.csv("female.csv", stringsAsFactors = FALSE)
year <- c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017)

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
        menuItem("Boxplot", tabName="boxplot",icon=icon("bar-chart-o"))
      )
    ),
    dashboardBody(
      tabItems(
        # First tab content
        # Dashboard
        tabItem(tabName = "dashboard",
                fluidRow(
                  #image used
                  img(src='https://image.shutterstock.com/image-vector/male-boss-dismisses-pointing-hand-260nw-1361601686.jpg',  height="20%", width="100%", align = "center"),
                  # Box 1: user input
                  box(
                    title=strong("Your input"),
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
                    h4(strong("Your graph:")),
                    
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
                  br(),
                  plotOutput("myplot1")
                  
                )#,DT::dataTableOutput("table")
        )        
        
        
        
      )
    )
  )
  
)
