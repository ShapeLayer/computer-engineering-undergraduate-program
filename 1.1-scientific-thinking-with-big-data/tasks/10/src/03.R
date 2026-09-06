library("rpart")
library("rpart.plot")
library("caret")
library("dplyr")
library("ggplot2")
library("showtext")

setwd("./data/")
font_add_google("Noto Sans KR")
showtext_auto()

loan <- read.csv("loan_data_set.csv", stringsAsFactors = TRUE, na.strings = "")

summary(loan)

# 2단계: 데이터 전처리

colSums(is.na(loan))

# (1) Loan_ID 제거
loan <- loan[, !names(loan) %in% "Loan_ID"]

# (2) 결측값 대체
mode_val <- function(x) names(sort(table(x), decreasing = TRUE))[1]

# 범주형(factor/character) 변수 NA → 최빈값으로 대체
replace_na_mode <- function(x) {
  mode_value <- mode_val(x)
  x <- as.character(x)          # factor → character 변환
  x[is.na(x)] <- mode_value     # NA를 최빈값으로 대체
  return(factor(x))             # 다시 factor로 변환
}

loan$Gender        <- replace_na_mode(loan$Gender)
loan$Married       <- replace_na_mode(loan$Married)
loan$Dependents    <- replace_na_mode(loan$Dependents)
loan$Self_Employed <- replace_na_mode(loan$Self_Employed)

loan$LoanAmount[is.na(loan$LoanAmount)]           <- median(loan$LoanAmount, na.rm=TRUE)
loan$Loan_Amount_Term[is.na(loan$Loan_Amount_Term)] <- median(loan$Loan_Amount_Term, na.rm=TRUE)
loan$Credit_History[is.na(loan$Credit_History)]   <- median(loan$Credit_History, na.rm=TRUE)

# (3) 변수 타입 정리
loan$Credit_History <- factor(loan$Credit_History, labels = c("불량","양호"))
loan$Loan_Status    <- factor(loan$Loan_Status, levels = c("N","Y"),
                              labels = c("거절","승인"))

# (4) 파생 변수: 총 소득 (신청자 + 공동신청자)
loan$TotalIncome <- loan$ApplicantIncome + loan$CoapplicantIncome

colSums(is.na(loan))

# 대출 승인 비율
prop.table(table(loan$Loan_Status))


# 3단계: 훈련/검증 데이터 분할 (7:3)

set.seed(123)
train_idx  <- createDataPartition(loan$Loan_Status, p = 0.7, list = FALSE)
train_data <- loan[train_idx,  ]
test_data  <- loan[-train_idx, ]

cat(sprintf("\n훈련 데이터: %d건 / 검증 데이터: %d건\n",
            nrow(train_data), nrow(test_data)))


# 4단계: 의사결정나무 모델 구축

set.seed(123)
tree_model <- rpart(
  Loan_Status ~ Gender + Married + Dependents + Education +
    Self_Employed + ApplicantIncome + CoapplicantIncome +
    LoanAmount + Loan_Amount_Term + Credit_History +
    Property_Area + TotalIncome,
  data    = train_data,
  method  = "class",
  control = rpart.control(
    minsplit = 20,   # 분기 최소 관측수
    minbucket = 7,   # 말단 노드 최소 관측수
    cp       = 0.01, # 복잡도 파라미터
    maxdepth = 5     # 최대 깊이
  ),
  parms = list(split = "gini")  # 분기 기준: 지니 불순도
)

# 의사결정나무 요약
print(tree_model)
printcp(tree_model)


# 5단계: 나무 시각화

par(mfrow = c(1,1), mar = c(2,2,3,2))

# 원본 나무
rpart.plot(
  tree_model,
  type        = 4,        # 노드 형태
  extra       = 106,      # 클래스 비율 + 관측 비율 표시
  fallen.leaves = TRUE,
  cex         = 0.75,
  main        = "대출 승인 예측 의사결정나무 (원본)",
  box.palette = list("tomato", "lightblue"),
  shadow.col  = "gray"
)

# CP 플롯 (최적 가지치기 지점 확인)
plotcp(tree_model, main = "CP 플롯 (교차검증 오류)")


# 6단계: 가지치기 (Pruning)

# 교차검증 오류가 최소인 CP 선택
best_cp <- tree_model$cptable[
  which.min(tree_model$cptable[, "xerror"]), "CP"
]
cat(sprintf("\n최적 CP: %.4f\n", best_cp))

pruned_tree <- prune(tree_model, cp = best_cp)

# 가지치기 후 나무 시각화
rpart.plot(
  pruned_tree,
  type        = 4,
  extra       = 106,
  fallen.leaves = TRUE,
  cex         = 0.8,
  main        = "대출 승인 예측 의사결정나무 (가지치기 후)",
  box.palette = list("tomato", "lightblue"),
  shadow.col  = "gray"
)


# 7단계: 변수 중요도

var_imp <- pruned_tree$variable.importance
var_imp_df <- data.frame(
  Variable   = names(var_imp),
  Importance = as.numeric(var_imp)
) |> arrange(desc(Importance))

# 변수 중요도
print(var_imp_df)

# 8단계: 모델 평가

# 훈련 데이터 예측
pred_train <- predict(pruned_tree, train_data, type = "class")
pred_test  <- predict(pruned_tree, test_data,  type = "class")

# 확률값 (ROC 곡선용)
prob_test  <- predict(pruned_tree, test_data,  type = "prob")[, "승인"]

# 훈련 데이터 혼돈행렬
cm_train <- confusionMatrix(pred_train, train_data$Loan_Status, positive = "승인")
print(cm_train)

# 검증 데이터 혼돈행렬
cm_test <- confusionMatrix(pred_test, test_data$Loan_Status, positive = "승인")
print(cm_test)

# 주요 지표 요약 출력
cat(sprintf("훈련 정확도 : %.4f\n", cm_train$overall["Accuracy"]))
cat(sprintf("검증 정확도 : %.4f\n", cm_test$overall["Accuracy"]))
cat(sprintf("검증 민감도 (재현율) : %.4f\n", cm_test$byClass["Sensitivity"]))
cat(sprintf("검증 특이도 : %.4f\n", cm_test$byClass["Specificity"]))
cat(sprintf("검증 정밀도 : %.4f\n", cm_test$byClass["Pos Pred Value"]))
cat(sprintf("검증 F1 Score: %.4f\n", cm_test$byClass["F1"]))

# ROC 곡선 및 AUC
library(pROC)
roc_obj <- roc(test_data$Loan_Status, prob_test,
               levels = c("거절","승인"), direction = "<")
cat(sprintf("\n검증 AUC: %.4f\n", auc(roc_obj)))

plot(roc_obj,
     main = sprintf("ROC 곡선 (AUC = %.3f)", auc(roc_obj)),
     col  = "steelblue", lwd = 2)
abline(a=0, b=1, lty=2, col="gray")

# 9단계: 의사결정 규칙 추출
rpart.rules(pruned_tree, cover = TRUE)

