# 1. Getting Started
packages <- c("tidytext", "dplyr", "ggplot2", "wordcloud", "tm", 
              "topicmodels", "stringr", "igraph", "ggraph", "tidyr", "purrr")

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# install.packages("remotes")
# library("remotes")
Sys.setenv("JAVA_HOME"='/opt/homebrew/Cellar/sdkman-cli/5.19.0/libexec/candidates/java/11.0.31-amzn')
dyn.load("/opt/homebrew/Cellar/sdkman-cli/5.19.0/libexec/candidates/java/11.0.31-amzn/lib/server/libjvm.dylib")
# remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library("KoNLP")
Sys.setlocale("LC_ALL", "ko_KR.UTF-8")
setwd("/Users/shapelayer/Documents/GitHub/ShapeLayer/univ-lectures-private/26-1-ge-scientific-thinking-with-big-data/tasks/11/src/")

library("showtext")
font_add_google("Noto Sans KR", family = "Noto Sans KR")
showtext_auto()

# 2. 데이터 전처리
speech_text <- readLines("./data/inaugural-speech-lee-sm.txt", encoding = "UTF-8")

# 한글과 공백만 보존
cleaned_text <- speech_text %>%
  str_remove_all("[^가-힣\\s]") %>%
  str_trim()

# 분리
full_text <- paste(cleaned_text, collapse = " ")      # 전체를 하나의 문자열로 합침
sentences <- unlist(str_split(full_text, "\\s{2,}"))  # 공백 2개 이상 기준으로 분리
sentences <- str_trim(sentences)
sentences <- sentences[nchar(sentences) >= 5]         # 너무 짧은 토막 제외

text_df <- data.frame(
  doc_id = seq_along(sentences),
  text   = sentences,
  stringsAsFactors = FALSE
)

# 토큰화 (형태소 분석)
library(KoNLP)

# 한국어 명사 추출
words_list <- lapply(seq_along(sentences), function(i) {
  nouns <- extractNoun(sentences[i])
  if (length(nouns) == 0) return(NULL)
  data.frame(
    doc_id = i,
    word   = nouns,
    stringsAsFactors = FALSE
  )
})

words_df <- bind_rows(words_list) %>%
  filter(nchar(word) >= 2)

# 3. 불용어 제거
stopwords_korean <- c("이", "그", "저", "것", "수", "등", "같", "때", "그러나", "하여",
                     "또한", "따라", "우리", "우리가", "있", "있다", "되", "되다",
                     "이다", "있는", "되는", "하는", "말", "따라서", "그리고",
                     "나의", "그러면", "그런데", "있게", "내가", "한다", "한")

words_cleaned <- words_df %>%
  filter(!word %in% stopwords_korean) %>%
  filter(nchar(word) >= 2)


# 4. 단어 빈도 분석
word_freq <- words_cleaned %>%
  group_by(word) %>%
  summarise(frequency = n(), .groups = "drop") %>%
  arrange(desc(frequency)) %>%
  head(30)

print(word_freq)

# 시각화: 상위 20개 키워드 막대 그래프
word_freq %>%
  head(20) %>%
  ggplot(aes(x = reorder(word, frequency), y = frequency)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(x = "키워드", y = "빈도") +
  theme_minimal() +
  theme(text = element_text(family = "HanSans"))


# 5. 단어 구름
library(wordcloud)

wordcloud(
  words = word_freq$word,
  freq = word_freq$frequency,
  min.freq = 2,
  max.words = 100,
  random.order = FALSE,
  rot.per = 0.2,
  colors = brewer.pal(8, "Dark2"),
  family = "HanSans"
)


# 6. 동시 출현 분석
library(igraph)

# 문장 내 동시 출현 단어 쌍 추출
cooccurrence_matrix <- words_cleaned %>%
  group_by(doc_id) %>%
  summarise(words = list(unique(word)), .groups = "drop") %>%
  filter(lengths(words) >= 2) %>%          # 단어가 1개뿐인 문장 제외 (combn 오류 방지)
  mutate(pairs = map(words, function(x) {
    pairs_mat <- combn(x, 2, simplify = TRUE)
    data.frame(
      V1 = pairs_mat[1, ],
      V2 = pairs_mat[2, ],
      stringsAsFactors = FALSE
    )
  })) %>%
  select(doc_id, pairs) %>%
  unnest(pairs) %>%
  group_by(V1, V2) %>%
  summarise(count = n(), .groups = "drop")

# 네트워크 그래프 생성 (상위 30개 동시 출현 관계)
top_cooccurrence <- cooccurrence_matrix %>%
  arrange(desc(count)) %>%
  head(30)

g <- graph_from_data_frame(
  top_cooccurrence[, c("V1", "V2", "count")],
  directed = FALSE
)

# 네트워크 시각화
layout <- layout_with_fr(g)
plot(g,
     vertex.size = degree(g) * 2,
     vertex.label.cex = 0.8,
     vertex.label.family = "NotoSansKR",
     edge.width = E(g)$count / 10,)


# 7. 주제 모델링
library(topicmodels)

# DTM(Document-Term Matrix) 생성
dtm <- words_cleaned %>%
  group_by(doc_id, word) %>%
  summarise(count = n(), .groups = "drop") %>%
  cast_dtm(doc_id, word, count)

# LDA 모델 적용 (3개 주제)
lda_model <- LDA(dtm, k = 3, control = list(seed = 1234))

# 주제별 상위 10개 키워드 추출
topics <- tidy(lda_model, matrix = "beta")

top_terms <- topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  arrange(topic, -beta)

print(top_terms)

# 주제별 키워드 시각화
top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  scale_y_reordered() +
  labs(title = "LDA 주제 모델링: 주제별 상위 키워드",
       x = "Beta (확률)", y = "키워드") +
  theme_minimal() +
  theme(text = element_text(family = "HanSans"))

# 문서별 주제 비율 추출
doc_topics <- tidy(lda_model, matrix = "gamma")
print(doc_topics)


# 8. TF-IDF 분석 (주요도 측정)
cat("전체 행 수:", nrow(tfidf_analysis), "\n")
cat("tf_idf > 0 행 수:", sum(tfidf_analysis$tf_idf > 0), "\n")
print(summary(tfidf_analysis$tf_idf))
print(head(tfidf_analysis, 10))
# TF-IDF 계산
tfidf_analysis <- words_cleaned %>%
  group_by(doc_id, word) %>%
  summarise(count = n(), .groups = "drop") %>%
  bind_tf_idf(word, doc_id, count) %>%
  arrange(desc(tf_idf))

# 상위 20개 고유도 높은 단어
top_tfidf <- tfidf_analysis %>%
  distinct(word, .keep_all = TRUE) %>%
  top_n(20, tf_idf)

print(top_tfidf)

# 시각화
top_tfidf %>%
  ggplot(aes(x = reorder(word, tf_idf), y = tf_idf)) +
  geom_bar(stat = "identity", fill = "coral") +
  coord_flip() +
  labs(title = "취임사 문맥 고유도 높은 키워드 (TF-IDF)",
       x = "키워드", y = "TF-IDF 값") +
  theme_minimal() +
  theme(text = element_text(family = "HanSans"))


# 9. 감정 분석
# 긍정/부정 단어 사전 정의
positive_words <- c("영광", "감격", "희망", "분발", "전진", "신성", "평화", "친선",
                   "사랑", "감사", "애국", "노력")
negative_words <- c("두려움", "어려움", "분열", "위기", "공산", "반대", "부패", "손실")

sentiment_analysis <- words_cleaned %>%
  mutate(sentiment = case_when(
    word %in% positive_words ~ "긍정",
    word %in% negative_words ~ "부정",
    TRUE ~ "중립"
  )) %>%
  group_by(sentiment) %>%
  summarise(count = n())

print(sentiment_analysis)

# 감정 분포 파이 차트
sentiment_analysis %>%
  ggplot(aes(x = "", y = count, fill = sentiment)) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = c("긍정" = "green", "부정" = "red", "중립" = "gray")) +
  labs() +
  theme_void() +
  theme(legend.position = "bottom", text = element_text(family = "NotoSansKR"))


# 10. 분석 결과 요약
# 분석 결과 정리
summary_report <- list(
  총_단어수 = nrow(words_cleaned),
  고유_단어수 = length(unique(words_cleaned$word)),
  평균_단어길이 = mean(nchar(words_cleaned$word)),
  상위_5개_키워드 = head(word_freq, 5)$word,
  주요_주제 = top_terms %>% group_by(topic) %>% summarise(keywords = paste(term, collapse = ", "))
)

# 리포트 출력
cat("총 단어수:", summary_report$총_단어수, "\n")
cat("고유 단어수:", summary_report$고유_단어수, "\n")
cat("상위 5개 핵심 키워드:", paste(summary_report$상위_5개_키워드, collapse = ", "), "\n")

