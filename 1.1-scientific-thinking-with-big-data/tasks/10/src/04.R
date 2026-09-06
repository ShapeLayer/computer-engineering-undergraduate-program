# ============================================================
# 패키지 설치 및 로드
# ============================================================
pkgs <- c("nnet", "caret", "dplyr", "ggplot2", "pROC",
          "NeuralNetTools", "reshape2")
for(p in pkgs){
  if(!require(p, character.only = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
}

# ============================================================
# 1단계: 데이터 불러오기
# ============================================================
loan <- read.csv("loan_data_set.csv",
                 stringsAsFactors = TRUE,
                 na.strings = "")

cat("===== 데이터 구조 =====\n")
str(loan)

# ============================================================
# 2단계: 전처리 (base R)
# ============================================================
loan <- loan[, !names(loan) %in% "Loan_ID"]

# 결측값 대체 함수
mode_val <- function(x) names(sort(table(x), decreasing = TRUE))[1]

replace_na_mode <- function(x) {
  mv <- mode_val(x)
  x  <- as.character(x)
  x[is.na(x)] <- mv
  return(factor(x))
}

loan$Gender        <- replace_na_mode(loan$Gender)
loan$Married       <- replace_na_mode(loan$Married)
loan$Dependents    <- replace_na_mode(loan$Dependents)
loan$Self_Employed <- replace_na_mode(loan$Self_Employed)

loan$LoanAmount[is.na(loan$LoanAmount)]             <- median(loan$LoanAmount, na.rm = TRUE)
loan$Loan_Amount_Term[is.na(loan$Loan_Amount_Term)] <- median(loan$Loan_Amount_Term, na.rm = TRUE)
loan$Credit_History[is.na(loan$Credit_History)]     <- median(loan$Credit_History, na.rm = TRUE)

# 변수 타입 정리
loan$Credit_History <- factor(loan$Credit_History, labels = c("bad", "good"))
loan$Loan_Status    <- factor(loan$Loan_Status,
                               levels = c("N","Y"),
                               labels = c("거절","승인"))

# 파생 변수
loan$TotalIncome <- loan$ApplicantIncome + loan$CoapplicantIncome

cat("\n===== 결측값 현황 =====\n")
colSums(is.na(loan))

cat("\n===== 대출 승인 비율 =====\n")
prop.table(table(loan$Loan_Status))

# ============================================================
# 3단계: 신경망 입력을 위한 데이터 준비
# ============================================================

# (1) 더미 변수 생성 (원-핫 인코딩)
dummy_formula <- ~ Gender + Married + Dependents + Education +
                   Self_Employed + Credit_History + Property_Area

dummy_model  <- dummyVars(dummy_formula, data = loan, fullRank = TRUE)
dummy_data   <- predict(dummy_model, newdata = loan)

# (2) 연속형 변수 선택
cont_vars <- loan[, c("ApplicantIncome","CoapplicantIncome",
                      "LoanAmount","Loan_Amount_Term","TotalIncome")]

# (3) 연속형 변수 Min-Max 정규화 (신경망 필수)
normalize <- function(x) (x - min(x)) / (max(x) - min(x))

cont_norm <- as.data.frame(lapply(cont_vars, normalize))
colnames(cont_norm) <- paste0(colnames(cont_norm), "_norm")

# (4) 최종 분석용 데이터프레임 구성
model_data <- data.frame(dummy_data, cont_norm,
                         Loan_Status = loan$Loan_Status)

cat("\n===== 최종 입력 변수 목록 =====\n")
print(names(model_data))
cat(sprintf("총 입력 변수 수: %d\n", ncol(model_data) - 1))

# ============================================================
# 4단계: 훈련 / 검증 데이터 분할 (7:3)
# ============================================================
set.seed(42)
train_idx  <- createDataPartition(model_data$Loan_Status,
                                   p = 0.7, list = FALSE)
train_data <- model_data[ train_idx, ]
test_data  <- model_data[-train_idx, ]

cat(sprintf("\n훈련: %d건 / 검증: %d건\n",
            nrow(train_data), nrow(test_data)))

# ============================================================
# 5단계: nnet 단일 은닉층 신경망 (기본 모델)
# ============================================================
set.seed(42)
nn_model <- nnet(
  Loan_Status ~ .,
  data     = train_data,
  size     = 7,        # 은닉 뉴런 수
  decay    = 0.01,     # L2 정규화 파라미터 (가중치 감쇠)
  maxit    = 300,      # 최대 반복 횟수
  trace    = TRUE,     # 학습 과정 출력
  linout   = FALSE     # 분류 문제 → FALSE
)

cat("\n===== 신경망 모델 요약 =====\n")
print(nn_model)
cat(sprintf("\n네트워크 구조: 입력층 %d개 → 은닉층 %d개 → 출력층 1개\n",
            ncol(train_data) - 1, 7))

# ============================================================
# 6단계: 은닉 뉴런 수 최적화 (그리드 서치)
# ============================================================
cat("\n===== 은닉 뉴런 수별 검증 정확도 비교 =====\n")

hidden_sizes <- c(3, 5, 7, 9, 11, 15)
results_grid <- data.frame(
  hidden_size = integer(),
  train_acc   = numeric(),
  test_acc    = numeric()
)

for(sz in hidden_sizes){
  set.seed(42)
  m <- nnet(Loan_Status ~ ., data = train_data,
            size = sz, decay = 0.01, maxit = 300,
            trace = FALSE, linout = FALSE)

  pred_tr <- predict(m, train_data, type = "class")
  pred_te <- predict(m, test_data,  type = "class")

  acc_tr <- mean(pred_tr == as.character(train_data$Loan_Status))
  acc_te <- mean(pred_te == as.character(test_data$Loan_Status))

  results_grid <- rbind(results_grid,
                        data.frame(hidden_size = sz,
                                   train_acc   = round(acc_tr, 4),
                                   test_acc    = round(acc_te, 4)))
  cat(sprintf("은닉 뉴런 %2d개 | 훈련 정확도: %.4f | 검증 정확도: %.4f\n",
              sz, acc_tr, acc_te))
}

# 최적 은닉 뉴런 수 선택 (검증 정확도 기준)
best_size <- results_grid$hidden_size[which.max(results_grid$test_acc)]
cat(sprintf("\n최적 은닉 뉴런 수: %d\n", best_size))

# ============================================================
# 7단계: caret을 이용한 교차검증(5-fold) + 최적 모델 재훈련
# ============================================================
set.seed(42)
train_ctrl <- trainControl(
  method          = "cv",
  number          = 5,
  classProbs      = TRUE,
  summaryFunction = twoClassSummary,
  savePredictions = "final"
)

# caret용 클래스명 영문 변환 (한글 클래스명 호환 처리)
train_cv <- train_data
test_cv  <- test_data
levels(train_cv$Loan_Status) <- c("rejected", "approved")
levels(test_cv$Loan_Status)  <- c("rejected", "approved")

set.seed(42)
nn_cv <- train(
  Loan_Status ~ .,
  data      = train_cv,
  method    = "nnet",
  trControl = train_ctrl,
  tuneGrid  = expand.grid(size  = c(5, 7, 9),
                           decay = c(0.001, 0.01, 0.1)),
  metric    = "ROC",
  maxit     = 300,
  trace     = FALSE
)

cat("\n===== 교차검증 결과 =====\n")
print(nn_cv)

cat("\n===== 최적 하이퍼파라미터 =====\n")
print(nn_cv$bestTune)

# ============================================================
# 8단계: 최적 모델로 최종 예측
# ============================================================
pred_class_tr <- predict(nn_cv, train_cv, type = "raw")
pred_class_te <- predict(nn_cv, test_cv,  type = "raw")
pred_prob_te  <- predict(nn_cv, test_cv,  type = "prob")[, "approved"]

cat("\n===== 훈련 데이터 혼동행렬 =====\n")
cm_train <- confusionMatrix(pred_class_tr,
                             train_cv$Loan_Status,
                             positive = "approved")
print(cm_train)

cat("\n===== 검증 데이터 혼동행렬 =====\n")
cm_test <- confusionMatrix(pred_class_te,
                            test_cv$Loan_Status,
                            positive = "approved")
print(cm_test)

# ============================================================
# 9단계: ROC 곡선 및 AUC
# ============================================================
roc_obj <- roc(test_cv$Loan_Status, pred_prob_te,
               levels = c("rejected","approved"),
               direction = "<")
auc_val <- auc(roc_obj)
cat(sprintf("\n검증 데이터 AUC: %.4f\n", auc_val))

# ============================================================
# 10단계: 시각화
# ============================================================

# (A) 은닉 뉴런 수별 정확도 비교 그래프
grid_long <- reshape2::melt(results_grid,
                             id.vars    = "hidden_size",
                             variable.name = "dataset",
                             value.name = "accuracy")
grid_long$dataset <- ifelse(grid_long$dataset == "train_acc",
                             "훈련 데이터", "검증 데이터")

p1 <- ggplot(grid_long, aes(x = hidden_size, y = accuracy,
                              color = dataset, group = dataset)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = hidden_sizes) +
  labs(title  = "은닉 뉴런 수에 따른 정확도 변화",
       x      = "은닉 뉴런 수",
       y      = "정확도",
       color  = "데이터셋") +
  theme_minimal(base_size = 13) +
  theme(legend.position = "bottom")
print(p1)

# (B) ROC 곡선
plot(roc_obj,
     col  = "steelblue",
     lwd  = 2,
     main = sprintf("ROC 곡선 - 신경망 모델 (AUC = %.3f)", auc_val),
     print.auc = TRUE)
abline(a = 0, b = 1, lty = 2, col = "gray60")

# (C) 혼동행렬 히트맵
cm_df <- as.data.frame(cm_test$table)
colnames(cm_df) <- c("예측값", "실제값", "빈도")

p2 <- ggplot(cm_df, aes(x = 예측값, y = 실제값, fill = 빈도)) +
  geom_tile(color = "white", linewidth = 1.2) +
  geom_text(aes(label = 빈도), size = 8, fontface = "bold", color = "white") +
  scale_fill_gradient(low = "#4575b4", high = "#d73027") +
  labs(title    = "혼동행렬 (검증 데이터)",
       subtitle = "신경망 모델 예측 결과",
       x = "예측값", y = "실제값") +
  theme_minimal(base_size = 13)
print(p2)

# (D) 교차검증 튜닝 결과 시각화
p3 <- ggplot(nn_cv$results,
             aes(x = factor(size), y = ROC,
                 color = factor(decay), group = factor(decay))) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(title  = "5-Fold CV 하이퍼파라미터 튜닝 결과",
       x      = "은닉 뉴런 수 (size)",
       y      = "AUC (ROC)",
       color  = "가중치 감쇠 (decay)") +
  theme_minimal(base_size = 13) +
  theme(legend.position = "bottom")
print(p3)

# (E) 신경망 구조 시각화 (NeuralNetTools)
plotnet(nn_cv$finalModel,
        main  = "신경망 구조 시각화",
        cex_val = 0.6,
        circle_cex = 3,
        pos_col = "steelblue",
        neg_col = "tomato")

# (F) 변수 중요도 (Garson 알고리즘)
garson_imp <- garson(nn_cv$finalModel) +
  labs(title = "변수 중요도 (Garson 알고리즘)") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(garson_imp)

# ============================================================
# 11단계: 성능 지표 종합 요약
# ============================================================
cat("\n")
cat("============================================================\n")
cat("          신경망 모델 성능 종합 요약\n")
cat("============================================================\n")
cat(sprintf("  최적 구조     : 입력층 → 은닉층(%d) → 출력층(1)\n",
            nn_cv$bestTune$size))
cat(sprintf("  가중치 감쇠   : %.3f\n", nn_cv$bestTune$decay))
cat("------------------------------------------------------------\n")
cat(sprintf("  훈련 정확도   : %.4f\n", cm_train$overall["Accuracy"]))
cat(sprintf("  검증 정확도   : %.4f\n", cm_test$overall["Accuracy"]))
cat(sprintf("  민감도(재현율): %.4f  ← 실제 승인 중 맞힌 비율\n",
            cm_test$byClass["Sensitivity"]))
cat(sprintf("  특이도        : %.4f  ← 실제 거절 중 맞힌 비율\n",
            cm_test$byClass["Specificity"]))
cat(sprintf("  정밀도        : %.4f  ← 승인 예측 중 실제 승인 비율\n",
            cm_test$byClass["Pos Pred Value"]))
cat(sprintf("  F1 Score      : %.4f\n", cm_test$byClass["F1"]))
cat(sprintf("  AUC           : %.4f\n", auc_val))
cat(sprintf("  Kappa         : %.4f\n", cm_test$overall["Kappa"]))
cat("============================================================\n")

