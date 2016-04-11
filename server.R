#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library('shiny')
library('randomForest')
library("dplyr")
library("mlr")
library(mlbench)
library('shinyAce')
library("e1071")
library(gbm)
library('sendmailR')
library('mailR')

# 0.88551908,43,0,0.17751272,5700,4, 0,  0, 0,0


shinyServer(function(input, output) {
  RF = readRDS("random.rds") 
  svm.model  = readRDS("svm.rds")
  train = load("train.Rda")
  cs_training =load("cs_training.Rda")
   
  output$answer2 <- renderUI({ 
    class = 0
    class  = as.factor(class)
    #"amount"     "hour1"      "state1"     "zip1"       "custAttr1"  "field1"     "custAttr2"  "field2"     "hour2"     
     #"flag1"      "total"      "field3"     "field4"     "indicator1" "indicator2" "flag2"      "flag3"      "flag4"     
     #"flag5"  
    amount  = input$amount
    hour1 = input$hour1
    custAttr1 = input$custAttr1
    field1  = input$field1
    field2  = input$field2
    hour2  = input$hour2
    flag1 = input$flag1
    total = input$total
    field3  = input$field3
    field4  = input$field4
    indicator1  = input$indicator1
    indicator2 = input$indicator2
    flag2   = input$flag2
    flag3   = input$flag3
    flag4   = input$flag4
    flag5    = input$flag5
    Freq   =  input$Freq
    predicter2 = data.frame(custAttr1,amount,hour1,field1,field2,
                            hour2,flag1,total,field3,field4,indicator1,indicator2,flag2,flag3,flag4,flag5,Freq,class)
    colnames(predicter2) = c("custAttr1","amount","hour1" ,         "field1"     ,"field2"  ,
                             "hour2" ,     "flag1" ,     "total"   ,   "field3",     "field4"     ,"indicator1", "indicator2" ,"flag2","flag3",
                             "flag4",     "flag5","Freq","class")
    ans2  = predict(svm.model,predicter2)
    ifelse(ans2==1,paste("The prediction is: YES"),paste("The prediction is: NO"))
    
    #paste("The prediction is" ,ans2)
    
    
  })
  observe({
    if(is.null(input$INFORM) || input$INFORM==0 ) return(NULL)
    from <- "<akshanshgreat@gmail.com>"
    to <- "<akshanshgreat@gmail.com>"
    subject <- "Fraud Detection"
    msg <- "Your Account has been compromised"
    sendmail(from, to, subject, msg,control=list(smtpServer="ASPMX.L.GOOGLE.COM"))
    # send.mail(from = "akshanshis@gmail.com",
    #           to = input$custAttr2,
    #           subject = "Fraud Detection",
    #           body = "Your credit has been compromised .Please contact your bank.",
    #           smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "akshanshis", passwd = "", ssl = TRUE),
    #           authenticate = TRUE,
    #           send = TRUE,
    #            # optional parameter
    #           debug = TRUE)
  })
  output$answer1 <- renderUI({
    credibility =0
    revo  = input$revo
    age  =  input$age
    time  = input$time
    debt  = input$debt
    income = input$income
    credit  = input$credit
    times  = input$times
    estate  = input$estate
    due   = input$due
    depend   = input$depend
    
    predicter  = data.frame(credibility,revo,age,time,debt,income,credit,times,estate,due,depend)
    colnames(predicter)  <- c("SeriousDlqin2yrs","RevolvingUtilizationOfUnsecuredLines","age","NumberOfTime30.59DaysPastDueNotWorse","DebtRatio","MonthlyIncome","NumberOfOpenCreditLinesAndLoans",
                   "NumberOfTimes90DaysLate","NumberRealEstateLoansOrLines","NumberOfTime60.89DaysPastDueNotWorse","NumberOfDependents")
    ans  = predict(RF,predicter)
    ifelse(ans  <0.5,paste("The prediction is: NO"),paste("The prediction is: YES"))
    
    
    # numericInput("Revo", label = h4("UtilizationOfUnsecuredLines"), value = 0) ,
    # numericInput("age",  label = h4("age"),value = 0) ,
    # numericInput("time", label = h4("Time30.59DaysPastDue"),value =0),
    # numericInput("Debt", label = h4("DebtRatio"),value =0),
    # numericInput("income", label = h4("MonthlyIncome"),value =0),
    # numericInput("credit", label = h4("OpenCreditLinesAndLoans"),value =0),
    # numericInput("times", label = h4("Times90DaysLate"), value =0) ,
    # numericInput("estate", label = h4("NumberRealEstateLoans"),value =0),
    # numericInput("due", label = h4("Time60.89DaysPastDue"),value =0),
    # numericInput("depend", label = h4("NumberOfDependents"),value =0),
    # cities <- getNearestCities(input$lat, input$long)
    # checkboxGroupInput("cities", "Choose Cities", cities)
  })
  # output$plot1 <- renderPlot({
  #   
  #   plot(train$custAttr1, train$class)
  # })
  # output$plot2 <- renderPlot({
  #   
  #   plot(cs_training$SeriousDlqin2yrs, cs_training$DebtRatio)
  # })
  
})
