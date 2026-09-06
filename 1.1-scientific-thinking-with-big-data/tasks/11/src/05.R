library(tidyverse)
library(KoNLP)
library(igraph)
library(ggraph)
library(tidygraph)
library(showtext)

# 05번:

font_add_google("Noto Sans KR", "notokr")
showtext_auto()

# ─────────────────────────────────────────
# 1. 수집된 논문 제목 데이터 입력
# ─────────────────────────────────────────
titles <- c(
  '[07 부산광역시 수영구] 읍면동 단위 빅데이터 분석을 통한 체계적 복지행정 구현',
  '[04 서울특별시 광진구] 해충발생 예측 및 방역 최적화 빅데이터 분석',
  '[05 강원도 춘천시] 빅데이터로 본 코로나19 발생 전후 주요 지역 상권 분석',
  '[06 충청남도 당진시] 버스정류장 승하차 현황 및 노선최적화 빅데이터 분석',
  '[08 경기도 가평군] 수난 사고 현황 빅데이터 분석',
  '2021 지방자치단체 빅데이터 분석 자료집 목차',
  '[05 서울특별시 동대문구] 1인 가구 빅데이터 분석',
  '[02 대전광역시] 임신·출산 정책 수립을 위한 빅데이터 분석',
  '[01 서울특별시 광진구] 바닥형 보행신호등 최적입지 선정 빅데이터 분석',
  '[05 서울특별시 광진구] 길고양이 민원 빅데이터 분석',
  '[07 충청남도 당진시] 종자 신청·공급 빅데이터 분석',
  '[02 경상북도] 경상북도 지역화폐 빅데이터 분석',
  '[03 서울특별시 성동구] 성동형 15분 도시 데이터 분석',
  '[09 경기도 하남시] 하남시 공공도서관 데이터 분석',
  '[03 서울특별시 종로구] 데이터기반 종로구 1인가구 분석',
  '[08 경상남도 양산시] 인공지능 및 민간 클라우드 데이터를 융합한 지역축제 분석',
  '소셜 빅데이터 분석 서비스 : 비정형 텍스트 빅데이터 분석과 응용 서비스',
  '모빌리티 빅데이터 가상결합 분석방법론 연구',
  '그래프 구조를 갖는 서지 빅데이터의 효율적인 온라인 탐색 및 분석을 지원하는 그래픽 인터페이스 개발',
  '빅데이터 분석을 위한 파티션 기반 시각화 알고리즘',
  '정책 분석 및 평가의 일관성 제고를 위한 빅데이터 분석 기반 지속가능발전의 현상학적 정의',
  '워게임 시뮬레이션 환경에 맞는 빅데이터 분석을 위한 분산처리기술',
  '특허분석을 통한 빅데이터 기술개발 동향',
  '빅데이터 환경에서 분석 자원이 기업 성과에 미치는 영향',
  '빅데이터 분석을 통한 기온 변화에 따른 상품의 판매량 분석',
  '빅데이터 분석을 이용한 기온 변화에 대한 판매량 예측 모델',
  '코로나로 인한 관광분야 대응을 위한 시사점 고찰 : 연구동향과 언론기사 빅데이터 분석을 중심으로',
  '유네스코학교 세계시민교육 우수사례 빅데이터 분석',
  '네이버 스마트스토어에 대한 빅데이터 분석 및소상공인 온라인쇼핑몰 지속성장 방안 제안',
  '데이터베이스 연동을 통한 빅데이터 분석결과 가시화',
  '소셜 빅데이터 이슈 탐지 및 예측분석 기술 동향',
  '빅데이터 분석을 활용한 서울시 D구의 문화다양성 인식 연구',
  '디지털 오일필드에서 빅데이터 분석기반 IT 융합 기술 동향',
  '빅데이터를 활용한 공공계약의 입찰참가자수 영향요인 분석',
  '영상 빅데이터 분석기술 동향',
  '하이브리드 빅데이터 분석을 통한 홍수 재해 예측 및 예방',
  '공공연구성과 실용화를 위한 데이터 기반의 기술 포트폴리오 분석: 빅데이터 및 인공지능 분야를 중심으로',
  '빅데이터 기반의 모빌리티 분석',
  'Visual Cell : 바이오세포 이미지 빅데이터를 위한 이미지 분석 및 시각적 검색 시스템',
  'A 은행 사례 분석을 통한 빅데이터 기반 자금세탁방지 시스템 설계',
  '제조 공정 분석을 위한 빅데이터 클라우드 서비스',
  '빅데이터 기반 산학협력 네트워크 분석',
  '교육종단연구 분석을 위한 빅데이터 플랫폼 개발 및 적용',
  '재난 위험신고 빅데이터를 활용한 사회연결망 분석',
  '빅데이터 분석을 통한 천만 관객 영화 예측 모델',
  '빅데이터 분석을 통한 영화 관객수, 매출액 예측 모델',
  '정신분석과 빅데이터와의 대화 가능성 : 감정을 어떻게 처리할 것인가?에 관한 토론문',
  '빅데이터 분석 교육 프로그램을 통한 대학 교육 가치 창출',
  '빅데이터 기반의 화물운송 효율성 분석 방법론 개발',
  '의료기관 빅데이터 품질관리의 필요성과 사례 분석'
)

cat("수집된 논문 수:", length(titles), "\n")

# ─────────────────────────────────────────
# 2. 전처리: 대괄호·영문·숫자·특수문자 제거
# ─────────────────────────────────────────
titles_clean <- titles %>%
  str_remove_all("\\[.*?\\]") %>%   # [07 부산광역시 수영구] 형태 제거
  str_remove_all("[A-Za-z0-9]") %>% # 영문·숫자 제거
  str_remove_all("[^가-힣\\s]") %>% # 한글·공백 외 제거
  str_squish()                       # 연속 공백 정리

# ─────────────────────────────────────────
# 3. KoNLP 명사 추출 (doc_id 보존)
# ─────────────────────────────────────────
useNIADic()

# 불용어 정의 (분석 목적과 무관한 조사·어미·범용어)
stopwords <- c(
  "빅데이터", "분석", "기반", "위한", "통한", "활용", "관련",
  "연구", "개발", "것이", "경우", "이용", "대한", "관한",
  "위해", "통해", "따른", "대한", "중심", "방법", "결과",
  "방안", "현황", "적용", "수립"
)

words_list <- lapply(seq_along(titles_clean), function(i) {
  nouns <- extractNoun(titles_clean[i])
  if (length(nouns) == 0) return(NULL)
  data.frame(doc_id = i, word = nouns, stringsAsFactors = FALSE)
})

words_df <- bind_rows(words_list) %>%
  filter(nchar(word) >= 2) %>%                  # 2글자 미만 제거
  filter(!word %in% stopwords)                  # 불용어 제거

cat("추출된 단어 수:", nrow(words_df), "\n")
cat("고유 단어 수:", length(unique(words_df$word)), "\n")

# ─────────────────────────────────────────
# 4. 단어 빈도 확인
# ─────────────────────────────────────────
word_freq <- words_df %>%
  count(word, sort = TRUE)

cat(capture.output(as.data.frame(head(word_freq, 20))), sep = "\n")

# ─────────────────────────────────────────
# 5. 동시 출현 단어 쌍 추출
# ─────────────────────────────────────────
cooccurrence_matrix <- words_df %>%
  group_by(doc_id) %>%
  summarise(words = list(unique(word)), .groups = "drop") %>%
  filter(lengths(words) >= 2) %>%
  mutate(pairs = map(words, function(x) {
    x_sorted <- sort(x)  # 쌍의 순서 통일 (A-B == B-A)
    pairs_mat <- combn(x_sorted, 2, simplify = TRUE)
    data.frame(
      V1 = pairs_mat[1, ],
      V2 = pairs_mat[2, ],
      stringsAsFactors = FALSE
    )
  })) %>%
  select(doc_id, pairs) %>%
  unnest(pairs) %>%
  group_by(V1, V2) %>%
  summarise(count = n(), .groups = "drop") %>%
  arrange(desc(count))

cat("\n상위 동시 출현 단어 쌍:\n")
print(cooccurrence_matrix, n = 20)

# ─────────────────────────────────────────
# 6. 시각화 (1) — 동시 출현 빈도 상위 막대그래프
# ─────────────────────────────────────────
top_pairs_bar <- cooccurrence_matrix %>%
  slice_max(count, n = 15, with_ties = FALSE) %>%
  mutate(pair_label = paste(V1, "-", V2))

ggplot(top_pairs_bar, aes(x = reorder(pair_label, count), y = count)) +
  geom_bar(stat = "identity", fill = "#4C72B0", width = 0.7) +
  geom_text(aes(label = count), hjust = -0.3, size = 3.5, family = "notokr") +
  coord_flip() +
  labs(
    title = "RISS 논문 제목 동시 출현 단어 쌍 Top 15",
    subtitle = "검색 키워드: '빅데이터 분석' (n = 50편)",
    x = "단어 쌍",
    y = "동시 출현 빈도"
  ) +
  theme_minimal(base_family = "notokr") +
  theme(
    plot.title    = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 10, color = "gray50"),
    axis.text     = element_text(size = 10)
  )

# ─────────────────────────────────────────
# 7. 시각화 (2) — 동시 출현 네트워크 그래프
# ─────────────────────────────────────────
# 네트워크 구성 (2회 이상 동시 출현 쌍만 사용)
network_pairs <- cooccurrence_matrix %>%
  filter(count >= 2)

cat("네트워크 엣지 수:", nrow(network_pairs), "\n")

# 노드 중요도: 연결 강도 합산
node_strength <- bind_rows(
  network_pairs %>% select(word = V1, count),
  network_pairs %>% select(word = V2, count)
) %>%
  group_by(word) %>%
  summarise(strength = sum(count), .groups = "drop")

graph_data <- tbl_graph(
  edges = network_pairs %>% rename(from = V1, to = V2, weight = count),
  directed = FALSE
) %>%
  activate(nodes) %>%
  left_join(node_strength, by = c("name" = "word"))

set.seed(42)  # 레이아웃 재현성 고정

ggraph(graph_data, layout = "fr") +
  geom_edge_link(
    aes(width = weight, alpha = weight),
    color = "steelblue",
    show.legend = FALSE
  ) +
  geom_node_point(
    aes(size = strength),
    color = "coral",
    alpha = 0.85
  ) +
  geom_node_text(
    aes(label = name),
    repel    = TRUE,
    size     = 3.5,
    family   = "notokr",
    fontface = "bold"
  ) +
  scale_edge_width(range = c(0.5, 3)) +
  scale_size(range = c(3, 10)) +
  labs(
    title    = "RISS 논문 제목 동시 출현 단어 네트워크",
    subtitle = "검색 키워드: '빅데이터 분석' | 동시 출현 빈도 ≥ 2",
    size     = "연결 강도"
  ) +
  theme_void(base_family = "notokr") +
  theme(
    plot.title    = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, color = "gray50", hjust = 0.5),
    legend.position = "bottom"
  )




# 06번:
remotes::install_github("nikita-moor/ldatuning")
library(ldatuning)

cat("사용 문서 수:", length(unique(words_df$doc_id)), "\n")
cat("사용 단어 수:", nrow(words_df), "\n")

# 단어 빈도 집계
dtm_df <- words_df %>%
  count(doc_id, word, name = "freq")

# tidytext → DTM 변환
dtm <- dtm_df %>%
  cast_dtm(document = doc_id,
           term     = word,
           value    = freq)

total_cells    <- nrow(dtm) * ncol(dtm)
nonzero_cells  <- sum(dtm$v != 0)          # 실제 0이 아닌 셀 수
sparsity_manual <- 1 - (nonzero_cells / total_cells)

cat("DTM 행(문서) 수:", nrow(dtm), "\n")
cat("DTM 열(단어) 수:", ncol(dtm), "\n")
cat("DTM 희소성:", round(sparsity_manual, 4), "\n")

# 비어있는 행(단어가 전혀 없는 문서) 제거
rowsum_check <- slam::row_sums(dtm)
dtm_clean    <- dtm[rowsum_check > 0, ]
cat("정제 후 문서 수:", nrow(dtm_clean), "\n")



# ldatuning으로 k = 2 ~ 10 범위 탐색
# ※ 문서 수가 적으므로 k 범위를 좁게 설정
set.seed(42)

result_metrics <- FindTopicsNumber(
  dtm_clean,
  topics  = 2:8,
  metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
  method  = "Gibbs",
  control = list(seed = 42),
  verbose = TRUE
)

# 시각화
FindTopicsNumber_plot(result_metrics)
# Griffiths2004·Deveaud2014 → 높을수록 좋음
# CaoJuan2009·Arun2010      → 낮을수록 좋음
# 꺾이는 지점(elbow)을 최적 k로 선택



# 최적 k 설정 (탐색 결과에 따라 조정, 여기서는 k = 4 설정)
k <- 4

set.seed(42)
lda_model <- LDA(
  dtm_clean,
  k       = k,
  method  = "Gibbs",
  control = list(
    seed       = 42,
    burnin     = 1000,   # 초기 샘플링 버림
    iter       = 2000,   # 반복 횟수
    keep       = 50,     # 로그 우도 기록 간격
    thin       = 10      # 샘플 간격
  )
)

cat("토픽 수:", k, "\n")

# 로그 우도 확인 (수렴 여부)
loglik <- lda_model@loglikelihood
cat("로그 우도:", round(loglik, 2), "\n")




# β: 각 토픽에서 단어가 등장할 확률
topic_terms <- tidy(lda_model, matrix = "beta")

# 토픽별 상위 10개 단어 추출
top_terms <- topic_terms %>%
  group_by(topic) %>%
  slice_max(beta, n = 10, with_ties = FALSE) %>%
  ungroup() %>%
  arrange(topic, desc(beta))


topic_labels <- c(
  "1" = "Topic 1",
  "2" = "Topic 2",
  "3" = "Topic 3",
  "4" = "Topic 4"
)





top_terms %>%
  mutate(
    topic = factor(paste0("Topic ", topic), levels = paste0("Topic ", 1:k)),
    term  = reorder_within(term, beta, topic)
  ) %>%
  ggplot(aes(x = term, y = beta, fill = topic)) +
  geom_bar(stat = "identity", show.legend = FALSE, width = 0.7) +
  geom_text(aes(label = round(beta, 4)),
            hjust = -0.1, size = 2.8, family = "notokr") +
  facet_wrap(~ topic, scales = "free_y", ncol = 2) +
  scale_x_reordered() +
  scale_fill_brewer(palette = "Set2") +
  coord_flip() +
  labs(
    title    = "LDA 토픽 모델링 — 토픽별 핵심 단어 (β)",
    subtitle = paste0("RISS '빅데이터 분석' 논문 제목 | k = ", k),
    x = "단어",
    y = "β (단어 확률)"
  ) +
  theme_minimal(base_family = "notokr") +
  theme(
    plot.title    = element_text(size = 13, face = "bold"),
    plot.subtitle = element_text(size = 10, color = "gray50"),
    strip.text    = element_text(size = 10, face = "bold"),
    axis.text     = element_text(size = 9)
  )



# γ: 각 문서가 특정 토픽에 속할 확률
doc_topics <- tidy(lda_model, matrix = "gamma")

# 문서별 주요 토픽(최댓값) 추출
doc_main_topic <- doc_topics %>%
  group_by(document) %>%
  slice_max(gamma, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  mutate(
    doc_id = as.integer(document),
    topic  = factor(paste0("Topic ", topic), levels = paste0("Topic ", 1:k))
  )


cat(capture.output(as.data.frame(doc_main_topic)), sep = "\n")


# 토픽별 문서 수 시각화
doc_main_topic %>%
  count(topic) %>%
  ggplot(aes(x = topic, y = n, fill = topic)) +
  geom_bar(stat = "identity", width = 0.6, show.legend = FALSE) +
  geom_text(aes(label = paste0(n, "편")),
            vjust = -0.5, size = 4, family = "notokr") +
  scale_fill_brewer(palette = "Set2") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title    = "토픽별 문서 배정 수",
    subtitle = paste0("RISS '빅데이터 분석' 논문 (n = 50편) | k = ", k),
    x = "토픽",
    y = "문서 수 (편)"
  ) +
  theme_minimal(base_family = "notokr") +
  theme(
    plot.title    = element_text(size = 13, face = "bold"),
    plot.subtitle = element_text(size = 10, color = "gray50"),
    axis.text     = element_text(size = 10)
  )



doc_topics %>%
  mutate(topic = factor(paste0("Topic ", topic), levels = paste0("Topic ", 1:k))) %>%
  ggplot(aes(x = topic, y = gamma, fill = topic)) +
  geom_boxplot(alpha = 0.7, outlier.shape = 21, show.legend = FALSE) +
  geom_jitter(aes(color = topic), width = 0.15, alpha = 0.4,
              size = 1.5, show.legend = FALSE) +
  scale_fill_brewer(palette  = "Set2") +
  scale_color_brewer(palette = "Set2") +
  labs(
    title    = "문서별 토픽 소속 확률(γ) 분포",
    subtitle = paste0("RISS '빅데이터 분석' 논문 | k = ", k),
    x = "토픽",
    y = "γ (토픽 소속 확률)"
  ) +
  theme_minimal(base_family = "notokr") +
  theme(
    plot.title    = element_text(size = 13, face = "bold"),
    plot.subtitle = element_text(size = 10, color = "gray50"),
    axis.text     = element_text(size = 10)
  )


