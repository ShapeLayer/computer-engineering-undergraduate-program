# install.packages("e1071")
library(e1071)

setwd("~/Documents/GitHub/shapelayer/univ-lectures-private/26-1-ge-scientific-thinking-with-big-data/tasks/09/src")
job <- read.csv("job.csv")

# 3.
nb_model <- naiveBayes(직무 ~ ., data = job)

nb_pred <- predict(nb_model, job)
table(actual = job$직무, predict = nb_pred)

print(nb_model)

# 4.
library(class)

# 예측 변수와 타겟 변수 분리
train_x <- job[, c("야외활동성", "사교성", "보수성")]
train_y <- job$직무

# K-NN 수행 (보통 k는 데이터수의 제곱근이나 홀수 지정, 여기선 k=3 예시)
knn_pred <- knn(train = train_x, test = train_x, cl = train_y, k = 3)

# 결과 확인
table(actual = train_y, predict = knn_pred)


# 5.
library(e1071)

job$직무 <- as.factor(job$직무)
svm_model <- svm(직무 ~ ., data = job, kernel = "radial")
svm_pred <- predict(svm_model, job)

table(actual = job$직무, predict = svm_pred)

# 6. 
library(showtext)
font_add(family = "NotoSansKR", regular = "~/Library/Fonts/NotoSansKR-Regular.ttf")
showtext_auto()

library(rpart)
library(rpart.plot)

dt_model <- rpart(직무 ~ ., data = job, method = "class")
rpart.plot(dt_model) # 모델 시각화

dt_pred <- predict(dt_model, job, type = "class")
table(actual = job$직무, predict = dt_pred)

# 7.
library(nnet)

nn_model <- nnet(직무 ~ ., data = job, size = 5, maxit = 200)
nn_pred <- predict(nn_model, job, type = "class")

table(actual = job$직무, predict = nn_pred)

# 8. 

# 9.
new_emp <- data.frame(야외활동성 = 20, 사교성 = 15, 보수성 = 10)
predict(nn_model, new_emp, type = "class")
