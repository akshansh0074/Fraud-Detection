num_vars<-c(names(cs_training[,]))

xyz<-setdiff(names(cs_training),c("SeriousDlqin2yrs","X","NumberOfTimes90DaysLate","NumberOfTime60.89DaysPastDueNotWorse"))
b = paste("cs_training",xyz,sep = "$",collapse = "+")
a = paste("cs_training$SeriousDlqin2yrs",b,sep = "~")

my_formula <- paste(b,a,sep ="-")
my_formula <- as.formula(a)

logic<-glm(my_formula, family = binomial, data =cs_training)
anova(logic, test="Chisq")
prob <- predict(logic, type = "response")


#fit the model
cofint(logic)

res <- residuals(logic, type = "deviance")
 plot(predict(logic), res,xlab="Fitted values", ylab = "Residuals" )
 abline(h = 0, lty = 2)

