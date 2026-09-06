# 2. http://ssra.or.kr.co.kr/bigdata/data.csv 에서 data.csv 파일을 다운로드하여
# R로 불러들여 `data`라는 데이터프레임 변수로 만들고, 이 데이터프레임의 소득 변수에 대하여
# 성별 평균 차이 분석을 수행하고 결과를 해석하시오.
setwd("~/Documents/GitHub/shapelayer/univ-lectures-private/26-1-ge-scientific-thinking-with-big-data/tasks/08/src")
data <- read.csv("data.csv")

t.test(data$소득 ~ data$성별)

# 
#         Welch Two Sample t-test
# 
# data:  data$소득 by data$성별
# t = -0.28289, df = 80.512, p-value = 0.778
# alternative hypothesis: true difference in means between group 남자 and group 여자 is not equal to 0
# 95 percent confidence interval:
#  -891.0445  669.2263
# sample estimates:
# mean in group 남자 mean in group 여자 
#           5159.091           5270.000 

# 소득과 성별 간 관계에 대해, p-value 0.778로 신뢰구간 95%에서 귀무가설을 기각할 수 없다.
# 따라서 두 변수는 독립이다.

# 3. 상기 데이터프레임에서 다음과 같이 만족 여부 변수를 생성한 후, 만족 여부에 대한
# 성별 비율 차이 분석을 수행하고 결과를 해석하시오.
data$만족여부 <- ifelse((data$쇼핑만족도 > 3), '만족', '불만족')
table(data$만족여부, data$성별)

#         
#          남자 여자
#   만족     53   31
#   불만족    2    4

chisq.test(table(data$만족여부, data$성별))

#         Pearson's Chi-squared test with Yates' continuity correction
# 
# data:  table(data$만족여부, data$성별)
# X-squared = 1.0227, df = 1, p-value = 0.3119
# 
# Warning message:
# In chisq.test(table(data$만족여부, data$성별)) :
#   Chi-squared approximation may be incorrect

# 만족 여부와 성별 간 관계에 대해, p-value 0.3119로 신뢰구간 95%에서 귀무가설을 기각할 수 없다.
# 따라서 두 변수는 독립이다.

# 4. 상기 데이터프레임의 소득 변수에 대하여 주거지역에 대한 분산분석을 수행하고 결과를 해석하시오.

data$주거지역 <- as.factor(data$주거지역)
aov_result <- aov(data$소득 ~ data$주거지역)
summary(aov_result)

#               Df    Sum Sq Mean Sq F value Pr(>F)
# data$주거지역  2   2593896 1296948   0.367  0.694
# Residuals     87 307840660 3538398  

# 주거지역과 소득 간 관계에 대해, p-value 0.694로 신뢰구간 95%에서 귀무가설을 기각할 수 없다.
# 따라서 두 변수는 독립이다.

# 5. 상기 데이터프레임의 쇼핑액과 쇼핑만족도 간의 상관관계 분석을 수행하고 결과를 해석하시오.

cor.test(data$쇼핑액, data$쇼핑만족도)

# 
#         Pearson's product-moment correlation
# 
# data:  data$쇼핑액 and data$쇼핑만족도
# t = 0.041531, df = 88, p-value = 0.967
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  -0.2028499  0.2113246
# sample estimates:
#         cor 
# 0.004427222 

# 쇼핑액과 쇼핑만족도 간 관계에 대해, p-value 0.967로 신뢰구간 95%에서 귀무가설을 기각할 수 없다.
# 따라서 두 변수는 독립이다.

# 6. 상기 데이터프레임의 쇼핑액에 대한 소득, 이용만족도가 쇼핑만족도의 영향 유무를 알아보기 위한 회귀분석을 수행하고 결과를 해석하시오.

lm_result <- lm(data$쇼핑만족도 ~ data$소득 + data$이용만족도)
summary(lm_result)


# Call:
# lm(formula = data$쇼핑만족도 ~ data$소득 + data$이용만족도)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -3.4518 -0.4372  0.2334  0.5949  2.5652 
# 
# Coefficients:
#                  Estimate Std. Error t value Pr(>|t|)    
# (Intercept)     1.667e+00  5.840e-01   2.854  0.00539 ** 
# data$소득       2.430e-05  6.345e-05   0.383  0.70267    
# data$이용만족도 6.617e-01  8.342e-02   7.932 6.81e-12 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 1.114 on 87 degrees of freedom
# Multiple R-squared:   0.42,     Adjusted R-squared:  0.4067 
# F-statistic:  31.5 on 2 and 87 DF,  p-value: 5.108e-11

# 소득과 이용만족도가 쇼핑만족도에 미치는 영향에 대해, 소득의 p-value 0.70267로 신뢰구간 95%에서 귀무가설을 기각할 수 없다.
# 따라서 소득은 쇼핑만족도에 영향을 미치지 않는다.
# 
# 반면 이용만족도의 p-value 6.81e-12로 신뢰구간 95%에서 귀무가설을 기각할 수 있다.
# 따라서 이용만족도는 쇼핑만족도에 영향을 미친다. 회귀모형의 R-squared 값이 0.42로,
# 이 모형이 쇼핑만족도의 변동성의 42%를 설명한다. F-statistic의 p-value 5.108e-11로,
# 이 모형이 유의미하다고 할 수 있다.
