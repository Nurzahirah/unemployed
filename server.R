
library(shiny)
require(shinydashboard)
library(dplyr)
library(ggplot2)
theme_set(theme_bw())
gen<-read.csv("general.csv", stringsAsFactors = FALSE,header = TRUE)
male<-read.csv("male.csv", stringsAsFactors = FALSE,header = TRUE)
female<-read.csv("female.csv", stringsAsFactors = FALSE,header = TRUE)
year <- c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$gender_selector <-renderUI({
    radioButtons("rd",
                 label="Select a gender:",
                 choices = list("general"=2,"male"=0,"female"=1),
                 selected = "0"
    )
  })
  output$country_selector <- renderUI({
    check <-input$rd
    if(check==2){
      selectInput("name","Country Name:",gen[1])
      }
    else if(check==1){
      selectInput("name","Country Name:",female[1])
    }
    else if(check==0){
      selectInput("name","Country Name:",male[1])
    }
  })
  
  # choose columns to display
  gen2 = gen[sample(nrow(gen), 188, replace = FALSE, prob=NULL),
             ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(gen2[, input$show_vars, drop = FALSE])
  })
  male2 = male[sample(nrow(male), 129, replace = FALSE, prob=NULL),
               ]
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(male2[, input$show_vars2, drop = FALSE])
  })
  female2 = female[sample(nrow(female), 129, replace = FALSE, prob=NULL),
                   ]
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(female2[, input$show_vars3, drop = FALSE])
  })
  
  #plot the frequency graph   
  output$fgraph <- renderPlot({
    #radiobutton to check male or female and switch to the male dataset or female dataset
    radio <- input$rd
    #to search for the frequency of specific country
    q<- input$name
    #the vr is to append the data of the country later
    vr <- c()
    if(radio==1){
      #this is the for loop using the range of 1 : the number of rows of the dataset
      for (i in 1:nrow(female) ) {
        if(q==female[i,1]){
          #this is the for loop which using the range of 1: the number of columns of the dataset
          for (j in 1:ncol(female)) {
            if(j>2){
              #here is to append the data of the specific country from 2000 to 2017 year
              vr <- c(vr,female[i,j])}
          }
        }
      }
    }
    #here is same as the above
    else if(radio==0){
      for (i in 1:nrow(male) ) {
        if(q==male[i,1]){
          for (j in 1:ncol(male)) {
            if(j>2){
              vr <- c(vr,male[i,j])}
          }
        }
      }
    }
    #here is same as the above
    else if(radio==2){
      for (i in 1:nrow(gen) ) {
        if(q==gen[i,1]){
          for (j in 1:ncol(gen)) {
            if(j>2){
              vr <- c(vr,gen[i,j])}
          }
        }
      }
      year <- c(1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,year)
    }
    #i rename the vr which is the rate of unemployment to rate
    rate<-as.integer(vr)
    #i make the year which is defined after the library and the rate into a dataset
    d<- data.frame(year,rate)
    #here the grap is plotted, the d is the dataframe
    #the aes there, year point to the year data abd rate to the rate data in the dataframe
    #the fill there is the colour
    #the stat there, identity means that it is not count
    ggplot(d,aes(x=year,y=rate))+geom_smooth(fill = "#0073C2EF",stat = "identity")+xlab("year")+ylab("unemployment rate")
    
  })
  output$myplot <- renderPlot({
    #radiobutton to check male or female and switch to the male dataset or female dataset
    radio <- input$rd
    #to search for the frequency of specific country
    c<- input$name
    #the vr is to append the data of the country later
    vr <- c()
    if(radio==1){
      #this is the for loop using the range of 1 : the number of rows of the dataset
      for (i in 1:nrow(female) ) {
        if(c==female[i,1]){
          #this is the for loop which using the range of 1: the number of columns of the dataset
          for (j in 1:ncol(female)) {
            if(j>2){
              #here is to append the data of the specific country from 2000 to 2017 year
              vr <- c(vr,female[i,j])}
          }
        }
      }
    }
    #here is same as the above
    else if(radio==0){
      for (i in 1:nrow(male) ) {
        if(c==male[i,1]){
          for (j in 1:ncol(male)) {
            if(j>2){
              vr <- c(vr,male[i,j])}
          }
        }
      }
    }
    #here is same as the above
    else if(radio==2){
      for (i in 1:nrow(gen) ) {
        if(c==gen[i,1]){
          for (j in 1:ncol(gen)) {
            if(j>2){
              vr <- c(vr,gen[i,j])}
          }
        }
      }
      year <- c(1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,year)
    }
    #i rename the vr which is the rate of unemployment to rate
    rate<-as.integer(vr)
    #i make the year which is defined after the library and the rate into a dataset
    d<- data.frame(year,rate)
    boxplot(d[,2],
            xlab = 'year',
            ylab = 'percentage unemployment'
    )
    
  })
  
  da <- reactive({
    
    
    #radiobutton to check male or female and switch to the male dataset or female dataset
    radio <- input$rd
    #to search for the frequency of specific country
    c<- input$name
    #the vr is to append the data of the country later
    vr <- c()
    if(radio==1){
      #this is the for loop using the range of 1 : the number of rows of the dataset
      for (i in 1:nrow(female) ) {
        if(c==female[i,1]){
          #this is the for loop which using the range of 1: the number of columns of the dataset
          for (j in 1:ncol(female)) {
            if(j>2){
              #here is to append the data of the specific country from 2000 to 2017 year
              vr <- c(vr,female[i,j])}
          }
        }
      }
    }
    #here is same as the above
    else if(radio==0){
      for (i in 1:nrow(male) ) {
        if(c==male[i,1]){
          #this is the for loop which using the range of 1: the number of columns of the dataset
          for (j in 1:ncol(male)) {
            if(j>2){
              #here is to append the data of the specific country from 2000 to 2017 year
              vr <- c(vr,male[i,j])}
          }
        }
      }
    }
    #here is same as the above
    else if(radio==2){
      for (i in 1:nrow(gen) ) {
        if(c==gen[i,1]){
          for (j in 1:ncol(gen)) {
            if(j>2){
              vr <- c(vr,gen[i,j])}
          }
        }
      }
      year <- c(1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,year)
    }
    #i rename the vr which is the rate of unemployment to rate
    rate<-as.integer(vr)
    #i make the year which is defined after the library and the rate into a dataset
    d<- data.frame(year,rate)
    return(d)
  })
  
  output$t1 <- renderText({
    a <- da()
    paste("Mean               : ",mean(a[,2]))
  })
  
  output$t2 <- renderText({
    a <- da()
    paste("Mediam               : ",median(a[,2]))
  })
  
  output$t3 <- renderText({
    a <- da()
    paste("Standard Deviation   : ",sd(a[,2]))
  })
  
  output$t4 <- renderText({
    a <- da()
    paste("Min.Value            : ",min(a[,2]))
  })
  
  output$t5 <- renderText({
    a <- da()
    paste("Max.Value            : ",max(a[,2]))
  })
  
  output$myplot1 <- renderPlot({
    boxplot(gen[,3:30],
            xlab = 'year',
            ylab = 'percentage unemployment'
    )
    
  })
  
  output$comp <- renderPlot({
    c<-input$coun
    f<-c()
    for (i in 1:nrow(female)) {
      if(c==female[i,1]){
        for (j in 1:ncol(female)) {
          if(j>2){
            f<-c(f,female[i,j])
          }
        }
      }      
    }
    m<-c()
    for (i in 1:nrow(male)) {
      if(c==male[i,1]){
        for (j in 1:ncol(male)) {
          if(j>2){
            m<-c(m,male[i,j])
          }
        }
      }
    }
    gender<-c()
    for (i in 1:18) {
      gender<-c(gender,"female")
    }
    for (j in 1:18) {
      gender<-c(gender,"male")
    }
    yr<-c(2000:2017)
    value<-c(f,m)
    year<-c(yr,yr)
    df<- data.frame(year,gender,value)
    #ggplot(df,aes(x=year))+geom_point(aes(y=value,col=gender),size=6)+geom_line(aes(y=value,colour=gender),group=gender,size=1)+scale_color_manual(labels = c("female", "male"),values = c("female"="#00ba38", "male"="#f8766d"))+theme(axis.text.x = element_text(angle = 90, vjust=0.5, size = 8),panel.grid.minor = element_blank())
    ggplot(df,aes(x=year, y =value, group=gender, colour = gender))+geom_point()+geom_line()+scale_color_manual(labels = c("female", "male"),values = c("female"="red", "male"="blue"))+theme(axis.text.x = element_text(angle = 90, vjust=0.5, size = 8),panel.grid.minor = element_blank())
    
    }) 
  
  
  
  
})

