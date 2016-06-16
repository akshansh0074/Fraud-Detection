#set the directory to local minor project file
setwd("~/R/minor project");
 #sampling of data sets
smp_size <- floor(0.60 * nrow(Credit_Data))

train_ind <- sample(seq_len(nrow(Credit_Data)), size = smp_size)
cs_training <- Credit_Data[train_ind, ]
cs_test <- Credit_Data[-train_ind, ]

#import data sets
cs_training<-read.csv("cs-training.csv",header =T);
cs_test<-read.csv("cs-test.csv",header =T);

head(cs_training);
head(cs_test);

#names of classes
names(cs_training);

#types of classes
sapply(cs_training,class);

#graphs and plots to view the details
plots_hist<-function(a){
  if(is.integer(cs_training[[a]])|is.numeric(cs_training[[a]])){
    k3<-hist((cs_training[[a]]))
    return( k3)
  }
}

plots_bar<-function(a){
  if(is.integer(cs_training[[a]])|is.numeric(cs_training[[a]])){
    c3<-table(cs_training[[a]]);
    k3<-barplot(c3,main = "types")
    return( k3)
  }
}


#removal of NAs
newa= 
  function(df)
  {
    
    
    
    rew=
      function(x){
        
        
        ran_sam<-sample(1:length(df[,x]),size=sample(1:(0.1*length(df[,x])),1))
        df[ran_sam,x]<<-NA
      }
    
    sapply(names(df), rew)
    print(sapply(df,function(x)length(which(is.na(x)))))
    
    return(df)
    
  }
arjjr<-rep(NA,ncol(iris))

#removal of NAs with mean of the column
newa2=
  function(dff)
  {for(i in 1:ncol(dff)){
    dff[is.na(dff[,i]), i] <- mean(dff[,i], na.rm = TRUE)
    return(dff)
  }
  }

#p1 to p100
for(i in 1:NCOL(cs_training)){
  k[i]<-quantile(cs_training[[i]],seq.int(.01,1,by=0.01),na.rm =T)
}


  
  







