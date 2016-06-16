#using different packages
install.packages("packagename");

library(foreign)
library(nnet)
library(ggplot2)
library(reshape2)
cs_training<-read.csv("cs-training.csv",header = T);
a<-sapply(cs_training,names)


#with(cs_tarinin, table(ses, prog))


#with(ml, do.call(rbind, tapply(write, prog, function(x) c(M = mean(x), SD = sd(x)))))


#ml$prog2 <- relevel(ml$prog, ref = "academic")

xyz<-setdiff(names(cs_training),c("SeriousDlqin2yrs","X","NumberOfTime30.59DaysPastDueNotWorse","NumberOfTimes90DaysLate","NumberOfTime60.89DaysPastDueNotWorse"))
b = paste("cs_training",xyz,sep = "$",collapse = "+")
a = paste("cs_training$SeriousDlqin2yrs",b,sep = "~")

my_formula <- paste(b,a,sep ="-")
my_formula <- as.formula(a)
cs_training<-na.omit(cs_training)
test <- glm(my_formula, family = binomial(link = "logit"), 
            data = cs_training)

summary(test)
z <- test$coefficients/test$standard.errors
p <- (1 - pnorm(abs(z), 0, 1)) * 2
exp(coef(test))
head(pp <- fitted(test))
#Now we can run the anova() function on the model to analyze the table of deviance
anova(test, test="Chisq")

fitted.results <- predict(test,newdata=subset(cs_training,select=c(3,4,5,6,7,8,9,10,11,12)),type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)

misClasificError <- mean(fitted.results != cs_training$SeriousDlqin2yrs)
print(paste('Accuracy',1-misClasificError))

library(ROCR)
p <- predict(test, newdata=subset(cs_training,select=c(3,4,5,6,7,8,9,10,11,12)), type="response")
pr <- prediction(p, cs_training$SeriousDlqin2yrs)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc


## store the predicted probabilities for each value of ses and write
pp. <- cbind(cs_training1, predict(test, newdata = dwrite, type = "probs", se = TRUE))

## calculate the mean probabilities within each level of ses
by(pp.write[, 3:5], pp.write$ses, colMeans)


lpp <- melt(pp.write, id.vars = c("ses", "write"), value.name = "probability")
head(lpp)

ggplot(lpp, aes(x = write, y = probability, colour = ses)) + geom_line() + facet_grid(variable ~
                                                                                        ., scales = "free")