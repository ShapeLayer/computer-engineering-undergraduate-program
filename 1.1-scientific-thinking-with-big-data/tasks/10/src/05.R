# ============================================================
# 1. 패키지 설치 및 로드
# ============================================================
install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)

# ============================================================
# 2. 데이터 불러오기 및 확인
# ============================================================
dvd <- read.csv("dvdtrans.csv", header = TRUE)

head(dvd, 10)
str(dvd)
cat("총 거래 수:", length(unique(dvd$ID)), "\n")
cat("총 아이템 수:", length(unique(dvd$Item)), "\n")

# ============================================================
# 3. 트랜잭션(Transaction) 객체로 변환
# ============================================================
# ID별로 Item을 리스트로 그룹화
dvd_list <- split(dvd$Item, dvd$ID)
dvd_trans <- as(dvd_list, "transactions")

# 트랜잭션 요약 확인
summary(dvd_trans)

# ============================================================
# 4. 아이템 빈도 시각화
# ============================================================
itemFrequency(dvd_trans)   # 각 아이템의 지지도 수치 출력

itemFrequencyPlot(dvd_trans,
                  support = 0.1,
                  main = "DVD 아이템별 지지도",
                  col = "steelblue",
                  xlab = "아이템",
                  ylab = "지지도(Support)")

# ============================================================
# 5. Apriori 알고리즘으로 연관 규칙 생성
# ============================================================
rules <- apriori(dvd_trans,
                 parameter = list(
                   support    = 0.2,   # 최소 지지도 20%
                   confidence = 0.5,   # 최소 신뢰도 50%
                   minlen     = 2      # 최소 아이템 수 2개
                 ))

# ============================================================
# 6. 결과 요약 및 출력
# ============================================================
summary(rules)

# lift 기준 내림차순 정렬하여 출력
cat("\n===== 연관 규칙 (lift 기준 정렬) =====\n")
inspect(sort(rules, by = "lift"))

# ============================================================
# 7. 시각화
# ============================================================
# (1) 산점도: support vs confidence (lift로 색상 구분)
plot(rules,
     measure  = c("support", "confidence"),
     shading  = "lift",
     main     = "연관 규칙 산점도")

# (2) 네트워크 그래프
plot(rules,
     method = "graph",)

# (3) 그룹 행렬 플롯
plot(rules,
     method = "grouped",)
     