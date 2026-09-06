#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제11차 리포트
  \
  
  공과대학 컴퓨터정보통신공학과\
  박종현(214823)
]]

#pagebreak()
#counter(page).update(1)

// Required End

#set page(margin: (
  top: 15mm,
  bottom: 15mm,
  left: 15mm,
  right: 15mm,
),
  numbering: "1",
  header: [
    #text(size: .7em, fill: gray)[#columns(2)[
      #align(left)[〈빅데이터의과학적탐구〉제11차 리포트]
      #colbreak()
      #align(right)[박종현]
    ]
  ]]
)


// #show raw: it => text(font: mono)[#it]

#set text(font: serif, size: 10pt)
#show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(center)
  #text(weight: "regular", size: 1.3em)[
    #it.body
  ]
]

#show heading.where(level: 2): set text(size: 1.5em, weight: "semibold")
#show heading.where(level: 3): set text(size: 1.3em, weight: "regular")

#let img(path, size: 100%) = {
  align(center)[
    #image(path, width: size)
  ]
}

#let col2(..content) = {
  grid(
    columns: 2,
    ..content
  )
}

#let ans(ans, desc: none) = {
  grid(
    columns: 2,
    gutter: 1em,
    [답안], [#ans],
    ..if desc != none {
      ([의견], [#desc])
    } else {
      ()
    }
  )
}

#let rc(content) = text(fill: rgb("#e74c3c"))[#content]
#let cb(content) = block(fill: rgb("#f0f0f0"), inset: 1em, width: 100%)[#content]

#let ul(s) = [#underline[#link(s)]]

#set table(stroke: 0.5pt + black)

#let hero(
  title,
  subtitle,
) = [
  #place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
  )[
    = #title
    
    #align(center)[#text(size: 1.2em)[
      #subtitle
    ]]
    
    #align(center)[
    박종현, 
    공과대학 컴퓨터정보통신공학과\
    jonghyeon\@jnu.ac.kr
    ]
  ]
]


#show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 3pt), inset: (x: 2pt), text(fill: red, it))
#show raw.where(block: true): it => block(fill: rgb("f5f5f5"), inset: (x: 10pt, y: 10pt), width: 100%, it)

/*
 * Content Start
 */

#hero(
  [제11차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#11]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


#set table(stroke: 0.5pt + gray,)


1. 텍스트마이닝 기반인 주제어 분석, 동시 출현 단어 분석, 토픽 모델링, 감성 분석에 대하여 설명하시오.

#ans[
  주제어 분석(키워드 추출, 주제어 분석)
  - 문서 집합에서 핵심어·핵심 구문(문서의 주요 주제나 특징)을 자동으로 추출해 요약·색인·검색 등에 활용.
  - 주요 방법
    - 통계기반: TF, TF-IDF(문서 중요도 반영), chi-square, mutual information 등.
    - 그래프 기반: TextRank(문장·단어를 노드로 그래프 구성, PageRank로 중요도 계산).
    - 규칙·의미 기반: 명사구 추출, 품사 패턴(예: Noun+Noun)·문장구조 활용.
    - 키워드 확장: RAKE(관계 기반 키프레이즈 추출).
  - 절차: 토큰화 → 품사 필터링(명사·형용사 등) → 불용어 제거 → 어근화/정규화 → 가중치 계산 → 상위 키워드 선택
  - 장단점: 간단·빠름(TF-IDF), 의미적 연결성은 약함(문맥 무시). TextRank는 문맥 반영 가능.
  - 활용: 문서 요약, 색인, 태그 추천, 주제 탐색

  동시 출현 단어 분석(Co-occurrence / Collocation)
  - 동일 문서·문장·윈도우 내에서 함께 등장하는 단어 쌍(또는 집합)을 분석해 연관 관계·개념 네트워크를 파악.
  - 주요 방법
    - 빈도 기반 동시출현 행렬(co-occurrence matrix).
    - 통계적 지표: PMI(pointwise mutual information), normalized PMI, log-likelihood ratio, χ2 등.
    - 네트워크 분석: 단어를 노드, 동시출현을 엣지로 하는 그래프 생성 → 중심성·클러스터링 분석(community detection).
  - 윈도우 크기(문장/고정 토큰 수) 설정이 중요.
  - 절차: 전처리 → 윈도우 정의 → 동시출현 행렬 생성 → 가중치/스코어 계산 → 시각화(네트워크, 워드클라우드)
  - 장단점: 의미적 연결·구조 파악에 유용(공동 등장 규칙), 희소성 문제 및 문맥의 방향성(원인·결과) 파악 어려움.
  - 활용: 용어 네트워크, 개념 맵, 관계 추출, 토픽 전처리

  토픽 모델링(Topic Modeling)
  - 문서 집합에서 잠재적 주제(토픽)를 확률적·수학적으로 추출, 각 문서는 여러 토픽의 혼합으로 표현.
  - 대표 알고리즘
    - LDA(Latent Dirichlet Allocation): 단어-토픽, 토픽-문서 분포를 베이지안으로 추정.
    - NMF(Non-negative Matrix Factorization): 문서-단어 행렬의 비음수 분해로 토픽 추출.
    - 시맨틱/임베딩 기반: BERTopic(문장임베딩 + 클러스터링 + 토픽 추출), Top2Vec 등.
  - 절차: 전처리 → 단어행렬(BOW/TF-IDF) 구성 또는 문장 임베딩 → 모델 학습(토픽수 k 설정 필요) → 토픽 해석(상위 단어, 대표 문서) → 평가(퍼플렉서티, 토픽 응집도(C_v, UMass) 등)
  - 장단점: 대량 문서에서 주제 구조 발견에 강함. 토픽 수 선정, 해석(주관성), 짧은 문서 처리(트위터 등)에서 성능 문제.
  - 활용: 문서 분류 보조, 콘텐츠 분석, 트렌드 탐지, 추천시스템의 주제 피처

  감성 분석(Sentiment Analysis / Opinion Mining)
  - 정의/목적: 문장·문서에서 감정(긍정/부정/중립) 또는 더 세부적인 감정(기쁨·슬픔·분노 등)을 자동 분류 또는 수치화.
  - 접근법
    - 룰/사전 기반: 감성사전(lexicon)과 규칙(부정어 처리, 강조부사). 간단하고 라벨이 없어도 사용 가능.
    - 지도학습 기반: 전통 ML(SVM, Logistic Regression) 혹은 딥러닝(RNN, CNN, Transformer)으로 문장 레이블 학습.
    - 하이브리드: 사전 기반 + 머신러닝
  - 전처리·문맥 고려: 부정어 역전(“not good”), 이모티콘/이모지, 문장 연결, 어조(강조·비꼼) 처리 필요.
  - 평가 지표: Accuracy, Precision/Recall/F1, ROC-AUC(다중 클래스에선 매크로/마이크로 F1).
  - 장단점: 사전 기반은 라벨 불필요하지만 도메인 적응성 낮음. 딥러닝은 정확도 높지만 데이터·자원 필요.
  - 활용: 고객 리뷰 분석, 소셜 미디어 모니터링, 브랜드 감정 추이 분석
]

\

2. 텍스트마이닝의 자연어 처리 기술에 대하여 설명하시오.

#ans[
  - 토큰화(Tokenization)
  
    영어: 공백·구두점 기준; 한국어: 형태소 기반 토큰화(어간·어미 분리) 필요(예: Mecab, Kkma, Okt).
    
  - 형태소 분석(Morphological analysis)

    교착어(한국어 등)는 어근·접사 분리, 품사(POS) 태깅이 중요. 의미 추출·어간 통일에 필수.

  - 품사 태깅(POS tagging) 및 구문 분석(Parsing)
  
    품사 필터링(명사·동사 등), 의존구문 분석으로 관계 추출(주어-목적어 등).

  - 정규화(Normalization) 및 텍스트 클린징
  
    소문자화, 조사·특수문자 제거, 영어 약어 정리, 오타 교정 등.

  - 불용어 제거(Stopword removal), 어간 추출(Stemming) 및 표제어 추출(Lemmatization)

    불필요한 빈도 높은 단어 제거, 표제어로 통일해 희소성 감소.

  - NER(명명 엔터티 인식)
  
    인물·조직·장소·수치 등 추출 → 정보 추출·관계 분석에 사용.

  - 문장 분할(Sentence segmentation) 및 문장 임베딩
  
    문장 단위 분석을 위해 필수. 문장 임베딩은 문장 수준 의미를 보존(예: SBERT).

  - 단어·문장 임베딩(Representation)
  
    희소표현(BOW, TF-IDF)과 밀집임베딩(Word2Vec, GloVe, FastText, contextual BERT 계열).
    
  - 의미중심 기법: Word sense disambiguation, coreference resolution
  
    다의어 해소, 지시대명사 해석으로 정확도 개선.

  - 토픽·요약·관계추출 관련 기법
  
    토픽 모델링, 추출적/추상적 요약, 관계 추출(정보 추출).

  - 전이학습(Pretrained language models)
  
    BERT, RoBERTa, 한국어 전용 모델(한국어 BERT/KcBERT 등)로 하위 태스크(감성, NER 등) 미세조정(fine-tuning).
]

\

3. 공간 벡터 모델링 기술에 대하여 설명하시오.

#ans[
  문서/문장/단어를 수치 벡터로 변환해서 수학적·기하학적으로 다루는 기술로, 벡터 공간에서의 거리·유사도를 통해 의미 유사성·클러스터링·검색 등을 수행할 수 있다.
]

\

4. 행정안전부 국가기록원 대통령기록관(http://pa.go.kr/research/contents/speech/index.jsp)에서 초대 대통령인 이승만 대통령의 취임사를 가지고 주제어 분석을 수행하시오.

#ans[
  ```R
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
  ```

  #align(center)[
    #image("images/fig1.png", width: 60%)
    #image("images/fig2.png", width: 60%)
    #image("images/fig3.png", width: 60%)
    #image("images/fig4.png", width: 60%)
    #image("images/fig5.png", width: 60%)
    #image("images/fig6.png", width: 60%)
  ]

  ```
  # A tibble: 30 × 2
     word  frequency
     <chr>     <int>
   1 자리          7
   2 사람          6
   3 친선          6
   4 해서          6
   5 나라          5
   6 세계          5
   7 눈물          4
   8 대우          4
   9 동포          4
  10 정부          4
  # ℹ 20 more rows
  # ℹ Use `print(n = ...)` to see more rows
  ```

  ```
  # A tibble: 48 × 3
  # Groups:   topic [3]
     topic term    beta
     <int> <chr>  <dbl>
   1     1 눈물  0.0385
   2     1 동포  0.0385
   3     1 남여  0.0288
   4     1 직책  0.0288
   5     1 마음  0.0192
   6     1 사람  0.0192
   7     1 영광  0.0192
   8     1 오늘  0.0192
   9     1 책임  0.0192
  10     1 맹서  0.0192
  # ℹ 38 more rows
  # ℹ Use `print(n = ...)` to see more rows
  ```

  ```
  # A tibble: 18 × 3
     document topic    gamma
     <chr>    <int>    <dbl>
   1 1            1 0.999   
   2 2            1 0.999   
   3 3            1 0.994   
   4 4            1 0.000314
   5 5            1 0.000393
   6 6            1 0.000178
   7 1            2 0.000579
   8 2            2 0.000373
   9 3            2 0.00312 
  10 4            2 0.000314
  11 5            2 0.000393
  12 6            2 1.000   
  13 1            3 0.000579
  14 2            3 0.000373
  15 3            3 0.00312 
  16 4            3 0.999   
  17 5            3 0.999   
  18 6            3 0.000178
  ```

  ```
  전체 행 수: 288 
    tf_idf > 0 행 수: 288
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00559 0.01445 0.02560 0.03226 0.03200 0.25597 
    ```
  
    ```
    # A tibble: 10 × 6
     doc_id word       count     tf   idf tf_idf
      <int> <chr>      <int>  <dbl> <dbl>  <dbl>
   1      3 것입니         1 0.143  1.79  0.256 
   2      3 대의원         1 0.143  1.79  0.256 
   3      3 대표           1 0.143  1.79  0.256 
   4      3 무소속         1 0.143  1.79  0.256 
   5      3 좌익색태로     1 0.143  1.79  0.256 
   6      3 주목           1 0.143  1.79  0.256 
   7      1 눈물           4 0.105  1.79  0.189 
   8      3 정당           1 0.143  0.693 0.0990
   9      5 기관           3 0.0536 1.79  0.0960
  10      2 직책           3 0.0508 1.79  0.0911
  ```

  ```
  # A tibble: 20 × 6
     doc_id word       count     tf   idf tf_idf
      <int> <chr>      <int>  <dbl> <dbl>  <dbl>
   1      3 것입니         1 0.143  1.79  0.256 
   2      3 대의원         1 0.143  1.79  0.256 
   3      3 대표           1 0.143  1.79  0.256 
   4      3 무소속         1 0.143  1.79  0.256 
   5      3 좌익색태로     1 0.143  1.79  0.256 
   6      3 주목           1 0.143  1.79  0.256 
   7      1 눈물           4 0.105  1.79  0.189 
   8      3 정당           1 0.143  0.693 0.0990
   9      5 기관           3 0.0536 1.79  0.0960
  10      2 직책           3 0.0508 1.79  0.0911
  11      6 친선           6 0.0484 1.79  0.0867
  12      4 국회의원       3 0.0429 1.79  0.0768
  13      4 의장           3 0.0429 1.79  0.0768
  14      6 세계           5 0.0403 1.79  0.0722
  15      5 가지           2 0.0357 1.79  0.0640
  16      5 낭설           2 0.0357 1.79  0.0640
  17      5 조직           2 0.0357 1.79  0.0640
  18      5 자리           5 0.0893 0.693 0.0619
  19      2 맹서           2 0.0339 1.79  0.0607
  20      2 하기           2 0.0339 1.79  0.0607
  ```

  ```
  # A tibble: 3 × 2
    sentiment count
    <chr>     <int>
  1 긍정         24
  2 부정          5
  3 중립        325
  ```

  ```
  총 단어수: 354 
  고유 단어수: 246 
  상위 5개 핵심 키워드: 자리, 사람, 친선, 해서, 나라 
  ```
]

\

5. RISS 학술연구정보서비스(http://www.riss.kr/)에서 '빅데이터 분석'을 키워드로 검색을 수행하여 관련 논문 제목들을 수집한 후, 논문 제목에서 동시 출현 단어 분석을 수행하시오.

#ans[
  ```js
  const arr = []; for (const each of document.querySelectorAll(".srchResultListW li p.title")) { arr.push(each.textContent) }
  ```
  
  ```js
  ['[07 부산광역시 수영구] 읍면동 단위 빅데이터 분석을 통한 체계적 복지행정 구현', '[04 서울특별시 광진구] 해충발생 예측 및 방역 최적화 빅데이터 분석', '[05 강원도 춘천시] 빅데이터로 본 코로나19 발생 전후 주요 지역 상권 분석', '[06 충청남도 당진시] 버스정류장 승하차 현황 및 노선최적화 빅데이터 분석', '[08 경기도 가평군] 수난 사고 현황 빅데이터 분석', '2021 지방자치단체 빅데이터 분석 자료집 목차', '[05 서울특별시 동대문구] 1인 가구 빅데이터 분석', '[02 대전광역시] 임신·출산 정책 수립을 위한 빅데이터 분석', '[01 서울특별시 광진구] 바닥형 보행신호등 최적입지 선정 빅데이터 분석', '[05 서울특별시 광진구] 길고양이 민원 빅데이터 분석', '[07 충청남도 당진시] 종자 신청·공급 빅데이터 분석', '[02 경상북도] 경상북도 지역화폐 빅데이터 분석', '[03 서울특별시 성동구] 성동형 15분 도시 데이터 분석', '[09 경기도 하남시] 하남시 공공도서관 데이터 분석', '[03 서울특별시 종로구] 데이터기반 종로구 1인가구 분석', '[08 경상남도 양산시] 인공지능 및 민간 클라우드 데이터를 융합한 지역축제 분석', '소셜 빅데이터 분석 서비스 : 비정형 텍스트 빅데이터 분석과 응용 서비스', '모빌리티 빅데이터 가상결합 분석방법론 연구', '그래프 구조를 갖는 서지 빅데이터의 효율적인 온라인 탐색 및 분석을 지원하는 그래픽 인터페이스 개발', '빅데이터 분석을 위한 파티션 기반 시각화 알고리즘', '정책 분석 및 평가의 일관성 제고를 위한 빅데이터 분석 기반 지속가능발전의 현상학적 정의', '워게임 시뮬레이션 환경에 맞는 빅데이터 분석을 위한 분산처리기술', '특허분석을 통한 빅데이터 기술개발 동향', '빅데이터 환경에서 분석 자원이 기업 성과에 미치는 영향', '빅데이터 분석을 통한 기온 변화에 따른 상품의 판매량 분석', '빅데이터 분석을 이용한 기온 변화에 대한 판매량 예측 모델', '코로나로 인한 관광분야 대응을 위한 시사점 고찰 : 연구동향과 언론기사 빅데이터 분석을 중심으로', '유네스코학교 세계시민교육 우수사례 빅데이터 분석', '네이버 스마트스토어에 대한 빅데이터 분석 및소상공인 온라인쇼핑몰 지속성장 방안 제안', '데이터베이스 연동을 통한 빅데이터 분석결과 가시화', '소셜 빅데이터 이슈 탐지 및 예측분석 기술 동향', '빅데이터 분석을 활용한 서울시 D구의  문화다양성 인식 연구', '디지털 오일필드에서 빅데이터 분석기반 IT 융합 기술 동향', '빅데이터를 활용한 공공계약의 입찰참가자수 영향요인 분석', '영상 빅데이터 분석기술 동향', '하이브리드 빅데이터 분석을 통한 홍수 재해 예측 및 예방', '공공연구성과 실용화를 위한 데이터 기반의 기술 포트폴리오 분석: 빅데이터 및 인공지능 분야를 중심으로', '빅데이터 기반의 모빌리티 분석', 'Visual Cell : 바이오세포 이미지 빅데이터를 위한 이미지 분석 및 시각적 검색 시스템', 'A 은행 사례 분석을 통한 빅데이터 기반 자금세탁방지 시스템 설계', '제조 공정 분석을 위한 빅데이터 클라우드 서비스', '빅데이터 기반 산학협력 네트워크 분석', '교육종단연구 분석을 위한 빅데이터 플랫폼 개발 및 적용', '재난 위험신고 빅데이터를 활용한 사회연결망 분석', '빅데이터 분석을 통한 천만 관객 영화 예측 모델', '빅데이터 분석을 통한 영화 관객수, 매출액 예측 모델', '정신분석과 빅데이터와의 대화 가능성 : 감정을 어떻게 처리할 것인가?에 관한 토론문', '빅데이터 분석 교육 프로그램을 통한 대학 교육 가치 창출', '빅데이터 기반의 화물운송 효율성 분석 방법론 개발', '의료기관 빅데이터 품질관리의 필요성과 사례 분석']
  ```

  ```R
  library(tidyverse)
  library(KoNLP)
  library(igraph)
  library(ggraph)
  library(tidygraph)
  library(showtext)
  
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
  ```

  ```
  수집된 논문 수: 50 
  추출된 단어 수: 211 
  고유 단어 수: 174 
  ```

  ```
         word n
  1      예측 6
  2      기술 5
  3    데이터 5
  4      교육 4
  5      사례 3
  6      가구 2
  7      관객 2
  8      기온 2
  9  모빌리티 2
  10     발생 2
  11   방법론 2
  12     변화 2
  13     분야 2
  14     소셜 2
  15     영화 2
  16     융합 2
  17   이미지 2
  18 인공지능 2
  19     정책 2
  20     지역 2
  ```

  ```
  상위 동시 출현 단어 쌍:
  # A tibble: 411 × 3
     V1     V2           count
     <chr>  <chr>        <int>
   1 관객   영화             2
   2 관객   예측             2
   3 기온   변화             2
   4 기온   판매량           2
   5 데이터 인공지능         2
   6 변화   판매량           2
   7 영화   예측             2
   8 가구   데이터           1
   9 가구   종로구           1
  10 가능성 감정             1
  11 가능성 것인가에         1
  12 가능성 대화             1
  13 가능성 정신             1
  14 가능성 처리             1
  15 가능성 토론             1
  16 가상   결합             1
  17 가상   모빌리티         1
  18 가상   방법론           1
  19 가시   데이터베이스     1
  20 가시   연동             1
  # ℹ 391 more rows
  # ℹ Use `print(n = ...)` to see more rows
  ```

  ```
  네트워크 엣지 수: 7 
  ```

  #align(center)[
    #image("images/fig7.png", width: 60%)
    #image("images/fig8.png", width: 60%)
  ]
]

\

6. 5번에서 수집한 자료에 대하여 토픽 모델링을 수행하시오.

#ans[
  ```R
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
  ```

  ```
  사용 문서 수: 50 
  사용 단어 수: 211 
  DTM 행(문서) 수: 50 
  DTM 열(단어) 수: 174 
  DTM 희소성: 0.976 
  정제 후 문서 수: 50 
  ```

  ```
  fit models... done.
  calculate metrics:
    Griffiths2004... done.
    CaoJuan2009... done.
    Arun2010... done.
    Deveaud2014... done.
  ```

  ```
  토픽 수: 4
  로그 우도: -1167.03 
  ```

  ```
     document   topic     gamma doc_id
  1         1 Topic 1 0.2500000      1
  2        10 Topic 1 0.2596154     10
  3        11 Topic 2 0.2735849     11
  4        12 Topic 1 0.2596154     12
  5        13 Topic 1 0.2547170     13
  6        14 Topic 3 0.2735849     14
  7        15 Topic 2 0.2735849     15
  8        16 Topic 4 0.2719298     16
  9        17 Topic 1 0.2636364     17
  10       18 Topic 4 0.2685185     18
  11       19 Topic 1 0.2844828     19
  12        2 Topic 2 0.2636364      2
  13       20 Topic 2 0.2735849     20
  14       21 Topic 3 0.2767857     21
  15       22 Topic 1 0.2924528     22
  16       23 Topic 2 0.2596154     23
  17       24 Topic 2 0.2685185     24
  18       25 Topic 1 0.2500000     25
  19       26 Topic 2 0.2685185     26
  20       27 Topic 3 0.3135593     27
  21       28 Topic 2 0.2719298     28
  22       29 Topic 1 0.2543860     29
  23        3 Topic 4 0.2818182      3
  24       30 Topic 4 0.2735849     30
  25       31 Topic 1 0.2636364     31
  26       32 Topic 4 0.2636364     32
  27       33 Topic 3 0.2636364     33
  28       34 Topic 4 0.2636364     34
  29       35 Topic 3 0.2596154     35
  30       36 Topic 1 0.2500000     36
  31       37 Topic 2 0.2672414     37
  32       38 Topic 4 0.2647059     38
  33       39 Topic 3 0.2946429     39
  34        4 Topic 1 0.2818182      4
  35       40 Topic 3 0.2636364     40
  36       41 Topic 1 0.2547170     41
  37       42 Topic 2 0.2735849     42
  38       43 Topic 3 0.2735849     43
  39       44 Topic 1 0.2636364     44
  40       45 Topic 2 0.2547170     45
  41       46 Topic 2 0.2685185     46
  42       47 Topic 2 0.2543860     47
  43       48 Topic 4 0.2636364     48
  44       49 Topic 2 0.2735849     49
  45        5 Topic 2 0.2647059      5
  46       50 Topic 1 0.2636364     50
  47        6 Topic 4 0.2788462      6
  48        7 Topic 2 0.2647059      7
  49        8 Topic 2 0.2735849      8
  50        9 Topic 1 0.2589286      9
  ```

  #align(center)[
    #image("images/fig9.png")
    #image("images/fig10.png")
    #image("images/fig11.png")
    #image("images/fig12.png")
  ]
]
