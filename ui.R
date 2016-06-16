#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(navbarPage(theme = shinytheme("united"),"Application",
                   tabPanel("Home",sidebarLayout(sidebarPanel(fluidRow(
                     
                     
                     
                     column(5,br(),img(src ="pred.PNG", height = 200, width = 200),align  = "center",br(),helpText(h2("PREDICTION")),br(),br())),
                     
                     fluidRow(column(5,img(src  = "ana.PNG", height = 200, width = 200),align  = "center",br(),helpText(h2("ANALYTICS")))
                     
                     
                     
                     
                   )),mainPanel(
                                     fluidRow(column(12,br(),
                                                     img(src="Credit-card-Fraud.jpg", height = 300, width = 500),align  = "center"
                                     )),

                                     fluidRow(h2("FRAUD DETECTION",align  = "center"),
                                              column(12,

                                                     helpText(h4("Fraud has become one of the major ethical issues in the credit card industry. Fraud associated with credit card are also rising today as it has the most popular mode of payment for both online as well as regular purchase. In order to detect frauds from the mix of genuine as well as fraudulent transactions, efficient fraud detection techniques to detect them accurately are vital rather than simple pattern matching techniques. ")))


                                     ),

                                     fluidRow(h2("CLASSIFICATION",align  = "center"),
                                              column(12,

                                                     helpText(h4("Risk management is critical for a credit card company to survive in such competing industry. In addition to operational expenses, provisional loss is a major driver to a company's expense. The provisional loss arises due to the bad accounts booked - bank lends the money to customers who eventually do not have capability to pay back.")))



                                     )))),
                   tabPanel("Fraud Detection",
                            
                              sidebarLayout(
                                sidebarPanel(numericInput("custAttr1", label = h3("custAttr1"), value = 0) ,
                                            numericInput("amount", label = h3("amount"), value = 0) ,
                                            numericInput("hour1", label = h3("hour1"),value = 0.1) ,
                                            
                                            numericInput("field1", label = h3("field1"), value = 0),
                                            
                                            numericInput("field2", label = h3("field2"), value = 0) ,
                                            numericInput("hour2", label = h3("hour2"),value = 0),
                                            numericInput("flag1", label = h3("flag1"),value = 0),
                                            numericInput("total", label = h3("total"), value = 0) ,
                                            numericInput("field3", label = h3("field3"),value = 0),
                                            numericInput("field4", label = h3("field4"),value = 0),
                                            numericInput("indicator1", label = h3("indicator1"), value = 0) ,
                                            numericInput("indicator2", label = h3("indicator2"),value = 0),
                                            numericInput("flag2", label = h3("flag2"),value = 0),
                                            numericInput("flag3", label = h3("flag3"),value = 0),
                                            numericInput("flag4", label = h3("flag4"),value = 0),
                                            numericInput("flag5", label = h3("flag5"),value = 0),
                                            numericInput("Freq",label = h3("Freq"),value  = 0),
                                            submitButton("Submit")), 
                                                                                                                                                
                                mainPanel( h2("FRAUD DETECTION",align = "center"),
                                           fluidRow(column(6,uiOutput("answer2"))),
                                          fluidRow(column(6,helpText("Do you want to send mail to inform user?"),textInput("custAttr2",label = h3("email id"),value = "enter email id"),actionButton("INFORM","inform")))
                              #             fluidRow(
                              #               column(width = 8,
                              #                      plotOutput("plot1", height=300,
                              #                                 click = "plot_click",  # Equiv, to click=clickOpts(id="plot_click")
                              #                                 hover = hoverOpts(id = "plot_hover", delayType = "throttle"),
                              #                                 brush = brushOpts(id = "plot_brush")
                              #                      )
                              #             )
                              # )
                            ))),
                   
                   tabPanel("Classification",sidebarLayout(
                     sidebarPanel(numericInput("revo", label = h4("UtilizationOfUnsecuredLines"), value = 0) ,
                                  numericInput("age",  label = h4("age"),value = 0) ,
                                  numericInput("time", label = h4("Time30.59DaysPastDue"),value =0),
                                  numericInput("debt", label = h4("DebtRatio"),value =0),
                                  numericInput("income", label = h4("MonthlyIncome"),value =0),
                                  numericInput("credit", label = h4("OpenCreditLinesAndLoans"),value =0),
                                  numericInput("times", label = h4("Times90DaysLate"), value =0) ,
                                  numericInput("estate", label = h4("NumberRealEstateLoans"),value =0),
                                  numericInput("due", label = h4("Time60.89DaysPastDue"),value =0),
                                  numericInput("depend", label = h4("NumberOfDependents"),value =0),
                                  submitButton("Submit")), 
                     
                     mainPanel( h2("CLASSIFICATION",align = "center"),
                                fluidRow(column(6,uiOutput("answer1")))
                   #              fluidRow(
                   #                column(width = 8,
                   #                       plotOutput("plot2", height=300,
                   #                                  click = "plot_click",  # Equiv, to click=clickOpts(id="plot_click")
                   #                                  hover = hoverOpts(id = "plot_hover", delayType = "throttle"),
                   #                                  brush = brushOpts(id = "plot_brush")
                   #                       )
                   #              )
                   # )
                   ))),header=(h1("Fraud Detection and Classifcation of Credit Card Company",align  = "center"))
                   
))
                  
