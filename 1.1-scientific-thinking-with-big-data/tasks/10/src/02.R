# R: 신경망 회귀 예시 (nnet via caret)
library(caret)
library(nnet)
set.seed(123)

# 데이터 및 분할(위와 동일)
df <- Boston
trainIndex <- createDataPartition(df$medv, p = 0.7, list = FALSE)
train <- df[trainIndex, ]
test  <- df[-trainIndex, ]

# 전처리: 스케일링(평균0, 표준편차1)
preProc <- preProcess(train[, -which(names(train) == "medv")], method = c("center", "scale"))
xtrain <- predict(preProc, train[, -which(names(train) == "medv")])
xtest  <- predict(preProc, test[, -which(names(test) == "medv")])
ytrain <- train$medv
ytest  <- test$medv

# caret을 이용한 튜닝
train_ctrl <- trainControl(method = "cv", number = 5)
grid <- expand.grid(size = c(3, 5, 7), decay = c(0, 0.001, 0.01))
set.seed(123)
nnet_tr <- train(x = xtrain, y = ytrain, method = "nnet",
                 trControl = train_ctrl, tuneGrid = grid, linout = TRUE, trace = FALSE, maxit = 1000)

# 예측 및 평가
pred_nnet <- predict(nnet_tr, newdata = xtest)
rmse_nnet <- sqrt(mean((pred_nnet - ytest)^2))
mae_nnet  <- mean(abs(pred_nnet - ytest))
r2_nnet   <- cor(pred_nnet, ytest)^2

list(RMSE = rmse_nnet, MAE = mae_nnet, R2 = r2_nnet)
# 변수 중요도(간단히)
varImp(nnet_tr)
