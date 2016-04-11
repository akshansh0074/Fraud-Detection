# check for multicollinearity
# library('corrplot')
library('randomForest')


# library("MASS")
# library("randomForest")

cs_training<-read.csv("cs-training.csv",header =T);
cs_test<-read.csv("cs-test.csv",header =T);

# 
cs_training  = cs_training[,c(-1)]
# res1 <- cor.mtest(mtcars, 0.95)
# res2 <- cor.mtest(mtcars, 0.99)
## specialized the insignificant value according to the significant level
# corrplot(M, p.mat = res1[[1]], sig.level = 0.2)
# M <- cor(cs_training,use = "na.or.complete") # get correlations
# 
# #package corrplot
# corrplot(M, method = "circle") #plot matrix
# 
# 

#creating a generalised logistic model

# num_vars<-c(names(cs_training[,]))
# 
# xyz<-setdiff(names(cs_training),c("SeriousDlqin2yrs","X"))
# b = paste("cs_training",xyz,sep = "$",collapse = "+")
# a = paste("cs_training$SeriousDlqin2yrs",b,sep = "~")
# 
# my_formula <- paste(b,a,sep ="-")
# my_formula <- as.formula(a)
# 
# logic<-glm(my_formula, family = binomial, data =cs_training)
# anova(logic, test="Chisq")
# prob <- predict(logic, type = "response")

#checking Rsquare value



# 
# model = lm(SeriousDlqin2yrs~ ., cs_training)
# dert<- vif(cs_training)
# Rsq = summary(model)$r.squared
# 
# vif = 1/(1 - Rsq)
# 
# dert<-vifstep(cs_training)
# dert
# dert1<-vifstep(cs_training,th = 10)
# dert1


cs_training = na.omit(cs_training)
RF <- randomForest(SeriousDlqin2yrs~.,data = cs_training
                   ,sampsize=c(1000),do.trace=TRUE,importance=TRUE,ntree=5000,mtry=3,classwt=1,forest=TRUE)
saveRDS(RF,"random.rds")

# test <- read.csv("cs-test.csv")
# 
# pred <- data.frame(predict(RF,test[,-c(1,2,7,12)]))
# names(pred) <- "SeriousDlqin2yrs"
# predpre
# write.csv(pred,file="sampleEntry.csv")
