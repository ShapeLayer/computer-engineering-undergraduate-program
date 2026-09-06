library(dplyr)

wifi <- read.csv(
  "무료와이파이정보.csv"
)

count_sido <- wifi %>%
  group_by(설치시도명) %>%
  summarise(개수 = n()) %>%
  arrange(desc(개수))

cat("=== [설치시도명 별 집계] ===\n")
print(count_sido)

count_sigungu <- wifi %>%
  group_by(설치시도명, 설치시군구명) %>%
  summarise(개수 = n(), .groups = "drop") %>%
  arrange(설치시도명, desc(개수))

cat("\n=== [설치시도명 + 설치시군구명 별 집계] ===\n")
print(count_sigungu)
