library(e1071)
library(rpart)
library(mlbench)




testset <- read.csv("cs-test.csv", header = TRUE)

trainset <- read.csv("cs-training.csv",header =T)

# fit the model
#trainset<-na.omit(trainset)
#trainset$SeriousDlqin2yrs<-as.numeric(trainset$SeriousDlqin2yrs)
#testset<-na.omit(testset)
#testset$SeriousDlqin2yrs<-as.numeric(testset$SeriousDlqin2yrs)


svm.model <- svm(SeriousDlqin2yrs~ .,kernel = "linear",data = trainset,cost = 100, gamma = 1)
svm.model
# make the prediction (the dependent variable, Type, has column number 10)

svm.pred <- predict(svm.model, testset[,-2])
svm.pred
table(pred = svm.pred, true = testset[,2])

# The function svm() returns an object of class "svm", which partly includes the following components:
#  SV: matrix of support vectors found;
#	labels: their labels in classification mode;
#	index: index of the support vectors in the input data (could be used e.g., for visualization)

# Other important parameters:
# 	class.weights: allows to introduce class weighing, useful for very asymmetric classes 
#	cross: (default 0) for k-fold CV

# A nice tool in package e1071 is the possibility of tuning the parameters by 10-CV grid search:

mytunedsvm <- tune.svm(SeriousDlqin2yrs ~ ., data = trainset, gamma = 2^(-1:1), cost = 2^(2:4)) 
summary(mytunedsvm)
plot (mytunedsvm, transform.x=log10, xlab=expression(log[10](gamma)), ylab="C")
