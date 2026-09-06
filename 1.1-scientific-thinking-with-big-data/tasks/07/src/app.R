library(descr)
library(psych)

# 3번 문항
data <- read.csv("data.csv")

# 성별, 연령대, 직업, 주거지역 빈도분석 및 그래프
freq_vars <- c("성별", "연령대", "직업", "주거지역")
for(v in freq_vars) {
  cat("\n---", v, "빈도분석 결과 ---\n")
  freq_table <- freq(data[[v]], plot=TRUE, main=paste(v, "분포"))
  print(freq_table)
}

# 4번 문항
cat("\n--- 쇼핑액 기술 분석 ---\n")
shopping_desc <- describe(data$쇼핑액)
print(shopping_desc)
# 출력된 결과에서 n(표본수), mean, sd, median, min, max, range, skew(왜도), kurtosis(첨도), se(표준오차) 확인 가능

# 5번 문항
cat("\n--- 성별 x 연령대 교차표 ---\n")
cross_tab <- CrossTable(data$성별, data$연령대)
print(cross_tab)

# 6번 문항
# 다차원 분석을 위해 쇼핑 금액 데이터만 추출하여 거리 계산
mds_data <- data[, c("쇼핑1월", "쇼핑2월", "쇼핑3월")]
dist_matrix <- dist(mds_data) # 유클리드 거리 계산
mds_fit <- cmdscale(dist_matrix) # 다차원척도법 실행
plot(mds_fit, 
     pch = 19,
     col = "blue")
text(mds_fit, labels=data$사번, cex=0.7)

# 7번 문항
cat("\n--- 연령대별 평균 이용만족도 ---\n")
group_mean <- aggregate(이용만족도 ~ 연령대, data = data, mean)
print(group_mean)

# 8~10 번 문항 공통 작업
data$쇼핑액_round <- round(data$쇼핑액)

# 8번 문항
boxplot(data$쇼핑액_round, main="쇼핑액 박스 플롯", ylab="쇼핑액")
# 해석: 중앙값의 위치, IQR(상자 크기), 이상치(Outlier) 존재 여부를 파악합니다.

# 9번 문항
stem(data$쇼핑액_round)
# 해석: 숫자의 빈도를 시각적으로 나타내어 데이터의 상세 분포를 파악합니다.

# 10번 문항
qqnorm(data$쇼핑액_round)
qqline(data$쇼핑액_round, col="red")
# 해석: 도표의 점들이 붉은 실선에 가까울수록 데이터가 정규분포를 따른다고 해석합니다.
