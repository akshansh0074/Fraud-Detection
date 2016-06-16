library("dplyr")
library("mlr")
library("mlbench")
library("caret")
library("e1071")
library("gbm")
library("depmixS4")
library("RHmm")
library("ggplot2")
library("randomForest")
#Dataaa = read.csv("Datamining.COntest2009.Task2.Train.Inputs" ,header =T)
train = DataminingContest2009.Task2.Train
na.omit(train)
test = DataminingContest2009.Task2.Test 

#preprocessing for training data

table1 = as.data.frame(table(DataminingContest2009.Task2.Train$custAttr1))
#head(table1)

table_train  = subset.data.frame(table1,subset = table1$Freq>2) 
colnames(table_train)[which(names(table_train) == "Var1")] <- "custAttr1"
#table_train$custAttr1 = as.double(table_train$custAttr1)
#head(table_train)
#t_A <- train[match(table_train$custAttr1, train$custAttr1, nomatch=0),]
 train <- merge(train, table_train)
 #train =as.matrix(as.data.frame(train))

# for(i in 1:nrow(table_train)){
#   for(j in 1:nrow(train)){
#     if(train$custAttr1[i]==table_train$custAttr1[j]){
#       train <- train[-c(i), ]
#     }
#     else{
#       train<-train
#     }
#   }
# }

#preprocessing for test data

table2 = as.data.frame(table(DataminingContest2009.Task2.Test$custAttr1))
#head(table2)

table_test  = subset.data.frame(table2,subset = table2$Freq>2) 
#head(table_test)
colnames(table_test)[which(names(table_test) == "Var1")] <- "custAttr1"
#table_train$custAttr1 = as.double(table_train$custAttr1)
#head(table_train)
#t_A <- train[match(table_train$custAttr1, train$custAttr1, nomatch=0),]
test <- merge(test, table_test)
#test =as.matrix(as.data.frame(test))

#k-means clustering
# 
# for(i in 1:ncol(train)){
#   if((train[[i]])== "Boolean")
#     train = subset(train,select = -c(i))
# }
#  
train = subset(train, select = -c(zip1,custAttr2,state1) )
test = subset(test, select = -c(zip1,custAttr2,state1) )
test$class =0
trainee = train
kmeans_train=kmeans(trainee,centers = 2)

   plot(train[c(1, 2,3,4,5,6,7,8)], col=kmeans_train$cluster)
  points(kmeans_train$centers[,c(1,2,3,4,5,6,7,8)], col=1:14, pch=8, cex=2)
  kmeansRes<-factor(kmeans$cluster)
  train$class = kmeans_train$cluster
  
  save(train,file="train.Rda")

  
  #Hmm model
  train_hmm = train
  mod <- depmix(class~1,data=train_hmm,nstates=2)
  # print the model, formulae and parameter values
  mod
  set.seed(1)
  # fit the model by calling fit
  fm <- fit(mod)
  #test$hmm = predict(fm,test)
library(corrplot)
  correlationMatrix <- cor(train,use ="na.or.complete")
  # summarize the correlation matrix
 print(correlationMatrix)
 
  
 # rdesc = makeResampleDesc("Holdout")
 # ctrl = makeFeatSelControlSequential(method = "sfs", maxit = NA)
 # res = selectFeatures("classif.rpart", train.task, rdesc, control = ctrl)
 # analyzeFeatSelResult(res)
 # 
 # 
 
 
 #Prediction function to be used for backtesting
 # pred1pd = function(t) {
 #   print(t)
 #   ##add section to select the best variable set from those available using GA
 #   # evaluation function - selects the best indicators based on miminsied training error
 #   mi.evaluate <- function(string=c()) {
 #     tmp <- data[(t-lookback):t,-1]
 #     x <- string
 #     tmp <- tmp[,x==1]
 #     tmp <- cbind(data[(t-lookback):t,1],tmp)
 #     colnames(tmp)[1] <- "targets"
 #     trainedmodel = ksvm(targets ~ ., data = tmp, type = ktype, kernel="rbfdot", kpar=list(sigma=0.1), C = C, prob.model = FALSE, cross = crossvalid)
 #     result <- error(trainedmodel)
 #     print(result)
 #   }
 #   
 #   ## monitor tge GA process
 #   monitor <- function(obj) {
 #     minEval = min(obj$evaluations);
 #     plot(obj, type="hist");
 #   }
 #   
 #   ## pass out the GA results; size is set to be the number of potential indicators
 #   gaResults <- rbga.bin(size=39, mutationChance=0.10, zeroToOneRatio=10, evalFunc=mi.evaluate, verbose=TRUE, monitorFunc=monitor, popSize=50, iters=3, elitism=10)
 #   
 #   ## now need to pull out the best chromosome and rebuild the data frame based on these results so that we can train the model
 #   
 #   bestChro <- gaResults$population[1,]
 #   newData <- data[,-1]
 #   newData <- newData[,bestChro==1]
 #   newData <- cbind(data[,1],newData)
 #   colnames(newData)[1] <- "targets"
 #   print(colnames(newData))
 #   
 #   # Train model using new data set
 #   model = trainSVM(newData[(t-lookback):t, ], ktype, C, crossvalid)
 #   # Prediction
 #   pred = as.numeric(as.vector(predict(model, newData[t+1, -1], type="response")))
 #   # Print for user inspection
 #   print(pred)
 # }
 
 
 set.seed(7)
 # M <- cor(cs_training,use = "na.or.complete") # get correlations
 library(corrplot)
 #package corrplot
 # corrplot(M, method = "circle") #plot matrix
 # 
 
 # # load the data
 # data(train)
 # calculate correlation matrix
 correlationMatrix <- cor(train,use ="na.or.complete")
 # summarize the correlation matrix
 print(correlationMatrix)
 # find attributes that are highly corrected (ideally >0.75)
 highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5)
 # print indexes of highly correlated attributes
 print(highlyCorrelated)
 
 
 #Feature variable selction
 fitControl <- trainControl(## 10-fold CV
   method = "repeatedcv",
   number = 10,
   ## repeated ten times
   repeats = 10)
 
 
 #model1
 
 gbmFit1 <- train(class ~ ., data = train,
                  method = "gbm",
                  trControl = fitControl,
                  ## This last option is actually one
                  ## for gbm() that passes through
                  verbose = FALSE)
 gbmFit1
 gbmImp <- varImp(gbmFit1, scale = FALSE)
 gbmImp
 

 # model2
 
 # train the model
 model <- randomForest(as.factor(class)~., data=train,sampsize=c(1000),do.trace=TRUE,importance=TRUE,ntree=5000,mtry=3,forest=TRUE)
 # estimate variable importance
 pre =importance(model, scale=FALSE)
 # summarize importance
 print(pre)
 # plot importance
 plot(pre)
 
 
 #final model using svm
 
 svm.model <- svm(as.factor(class)~ ., kernel = "linear",data = train)
 svm.model
 anova(svm.model)
 # make the prediction (the dependent variable, Type, has column number 18)
 saveRDS(svm.model,"svm.rds")
 svm.pred <- as.data.frame(predict(svm.model, test))
 svm.pred
 test$svm.pred <- predict(svm.model, test)
 write.table(test, file ="output.csv",row.names=FALSE,sep=",")
 table(pred = svm.pred, true = test$class)
 
 # The function svm() returns an object of class "svm", which partly includes the following components:
 #  SV: matrix of support vectors found;
 #	labels: their labels in classification mode;
 #	index: index of the support vectors in the input data (could be used e.g., for visualization)
 
 # Other important parameters:
 # 	class.weights: allows to introduce class weighing, useful for very asymmetric classes 
 #	cross: (default 0) for k-fold CV
 
 # A nice tool in package e1071 is the possibility of tuning the parameters by 10-CV grid search:
 
 mytunedsvm <- tune(svm,class ~ ., data = train, gamma = 2^(-1:1), cost = 2^(2:4)) 
 summary(mytunedsvm)
 plot (mytunedsvm, transform.x=log10, xlab=expression(log[10](gamma)), ylab="C")
 
 # this value can be different on your computer
 # because the tune method  randomly shuffles the data
 tunedModelRMSE <- rmse(error) 
 
 # ggplot(test, aes(x = class, y = flag1) )+ geom_boxplot() + coord_flip()

 
 plot(train)