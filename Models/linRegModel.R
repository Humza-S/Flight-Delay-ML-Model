install.packages('caret')
library(caret)
set.seed(122515)
featureCols <- c("ARR_DEL15", "DAY_OF_WEEK", "OP_CARRIER", "DEST", "ORIGIN", "DEP_TIME_BLK")
onTimeDataFiltered <- onTimeData[,featureCols]
inTrainRows <- createDataPartition(onTimeDataFiltered$ARR_DEL15, p=0.70, list=FALSE)
head(inTrainRows, 10)
trainDataFiltered <- onTimeDataFiltered[inTrainRows,]
View(onTimeDataFiltered)
View(trainDataFiltered)
testDataFiltered <- onTimeDataFiltered[-inTrainRows,]
nrow(trainDataFiltered)/(nrow(testDataFiltered) + nrow(trainDataFiltered))
nrow(testDataFiltered)/(nrow(testDataFiltered) + nrow(trainDataFiltered))


install.packages('e1071', dependencies = TRUE)


logisticRegModel <- train(ARR_DEL15 ~ ., data=trainDataFiltered, method="glm", family="binomial")
logRegPrediction <- predict(logisticRegModel, testDataFiltered)
logRegConfMat <- confusionMatrix(logRegPrediction, testDataFiltered[,"ARR_DEL15"])
logRegConfMat

