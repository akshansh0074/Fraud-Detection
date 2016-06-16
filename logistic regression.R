# check for multicollinearity
library('corrplot')
d <- data.frame(x1=rnorm(train$Price),
                x2=rnorm(train$),
                x3=rnorm(10))
cor.mtest <- function(mat, conf.level = 0.95) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat <- lowCI.mat <- uppCI.mat <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.mat) <- diag(uppCI.mat) <- 1
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], conf.level = conf.level)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      lowCI.mat[i, j] <- lowCI.mat[j, i] <- tmp$conf.int[1]
      uppCI.mat[i, j] <- uppCI.mat[j, i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.mat, uppCI.mat))
}

res1 <- cor.mtest(mtcars, 0.95)
res2 <- cor.mtest(mtcars, 0.99)
## specialized the insignificant value according to the significant level
corrplot(M, p.mat = res1[[1]], sig.level = 0.2)
M <- cor(cs_training,use = "na.or.complete") # get correlations

 #package corrplot
corrplot(M, method = "circle") #plot matrix



#creating a generalised logistic model

num_vars<-c(names(cs_training[,]))

xyz<-setdiff(names(cs_training),c("SeriousDlqin2yrs","X"))
b = paste("cs_training",xyz,sep = "$",collapse = "+")
a = paste("cs_training$SeriousDlqin2yrs",b,sep = "~")

my_formula <- paste(b,a,sep ="-")
my_formula <- as.formula(a)

logic<-glm(my_formula, family = binomial, data =cs_training)
anova(logic, test="Chisq")
prob <- predict(logic, type = "response")

#checking Rsquare value


library("usdm")
model = lm(SeriousDlqin2yrs~ ., cs_training)
dert<- vif(cs_training)
Rsq = summary(model)$r.squared

vif = 1/(1 - Rsq)

dert1<-vifstep(cs_training,th=10)
