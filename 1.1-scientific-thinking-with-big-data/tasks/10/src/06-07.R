library(MASS)

# ── 0. 준비 ──────────────────────────────────────────────
data("iris")
iris_data <- iris[, -5]          # 수치형 변수만 사용 (Species 제외)
iris_scaled <- scale(iris_data)  # 변수 간 스케일 차이 제거 (표준화)

# ── 1. 거리 행렬 계산 ─────────────────────────────────────
dist_matrix <- dist(iris_scaled, method = "euclidean")

# ── 2. 계층형 군집 분석 수행 (Ward 연결법) ────────────────
hc <- hclust(dist_matrix, method = "ward.D2")

# ── 3. 덴드로그램 시각화 ──────────────────────────────────
par(mfrow = c(1, 1))
plot(hc,
     main  = "Iris 계층형 군집 덴드로그램 (Ward.D2)",
     xlab  = "관측치",
     ylab  = "Height (병합 비용)",
     cex   = 0.4,
     hang  = -1)

# 3개 군집으로 절단선 표시
rect.hclust(hc, k = 3, border = c("red","blue","green"))

# ── 4. 군집 할당 (k = 3) ──────────────────────────────────
hc_cluster <- cutree(hc, k = 3)
table(hc_cluster)                    # 군집별 관측치 수

# ── 5. 실제 Species와 교차표 비교 ────────────────────────
table(hc_cluster, iris$Species)

# ── 6. 군집별 변수 평균 ───────────────────────────────────
aggregate(iris_data, by = list(Cluster = hc_cluster), FUN = mean)

# ── 7. 주성분 분석(PCA) 후 군집 시각화 ───────────────────
library(ggplot2)
pca <- prcomp(iris_scaled)
pca_df <- data.frame(pca$x[, 1:2],
                     Cluster = factor(hc_cluster),
                     Species = iris$Species)

ggplot(pca_df, aes(x = PC1, y = PC2, color = Cluster, shape = Species)) +
  geom_point(size = 2.5, alpha = 0.8) +
  labs(title = "계층형 군집 결과 (PCA 2D 시각화)",
       x = "PC1", y = "PC2") +
  theme_bw()

# ── 8. 연결법 비교 (4가지) ───────────────────────────────
methods <- c("single","complete","average","ward.D2")
par(mfrow = c(2, 2))
for (m in methods) {
  hc_m <- hclust(dist_matrix, method = m)
  plot(hc_m, main = paste("Method:", m), xlab = "", cex = 0.35, hang = -1)
  rect.hclust(hc_m, k = 3, border = "red")
}
par(mfrow = c(1, 1))
