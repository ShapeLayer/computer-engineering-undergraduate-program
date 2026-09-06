install.packages("MASS")
install.packages("caret")

library(MASS)
library(rpart)
library(rpart.plot)
library(caret)
set.seed(123)


data("Boston")
df <- Boston


trainIndex <- createDataPartition(df$medv, p = 0.7, list = FALSE)
train <- df[trainIndex, ]
test  <- df[-trainIndex, ]

# 기본 rpart 회귀트리, cp 튜닝을 위한 train 사용
ctrl <- trainControl(method = "cv", number = 5)
grid <- expand.grid(cp = seq(0.001, 0.05, by = 0.0025))
set.seed(123)
tr <- train(medv ~ ., data = train, method = "rpart",
            trControl = ctrl, tuneGrid = grid)

# 최적 모델
best <- tr$finalModel
rpart.plot(best, type = 2, extra = 101)

# 예측 및 평가
pred <- predict(tr, newdata = test)
rmse <- sqrt(mean((pred - test$medv)^2))
mae  <- mean(abs(pred - test$medv))
r2   <- cor(pred, test$medv)^2

list(RMSE = rmse, MAE = mae, R2 = r2)
# 변수 중요도
varImp(tr)
