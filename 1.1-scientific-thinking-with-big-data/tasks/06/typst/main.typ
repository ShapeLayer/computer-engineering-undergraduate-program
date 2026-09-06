#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제6차 리포트
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
      #align(left)[〈빅데이터의과학적탐구〉제6차 리포트]
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
#set page(columns: 2)

#show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 5pt), inset: (x: 5pt), text(fill: red, it))
#show raw.where(block: true): it => block(fill: rgb("f5f5f5"), outset: (y: 10pt), inset: (x: 10pt), width: 100%, it)

/**
 * Content Start
 */

#hero(
  [제6차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#6]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


#set table(stroke: 0.5pt + gray,)

1. http://ssra.or.kr.co.kr/bigdata/data.csv 에서 data.csv 파일을 다운로드하여 R로 불러들여 data라는 데이터프레임으로 생성하시오.

#ans([
  ```r
  data <- read.csv("data.csv", header=T)
  ```
])

\

2. 상기 데이터프레임에 품질, 가격, 서비스, 배송 값들의 합계 변수를 추가하시오.

#ans(
  [
    #table(
      columns: 6,
      align: center + horizon,
      stroke: 0.5pt + gray,
      
      [*\#*], [*고객번호*], [*성별*], [*연령대*], [*...*], [*합계*],
      
      [1], [190105], [남자], [45-49세], [...], [19],
      
      [2], [190106], [남자], [25-29세], [...], [25],
      
      [3], [190107], [남자], [50세 이상], [...], [14],
    
      table.cell(colspan: 6)[⋮]
    )

  ],
  desc: [
    ```r
    data["합계"] <- data["품질"] + data["가격"] + data["서비스"] + data["배송"]
    ```
  ]
)

\

3. 상기 데이터프레임을 거주 지역별(대도시, 중도시, 소도시)로 분리하여 3개의 데이터프레임을 생성하시오.

#ans(
  [
    소도시 테이블
    #table(
      columns: 6,
      align: center + horizon,
      stroke: 0.5pt + gray,
      // 헤더
      [*\#*], [*고객번호*], [*성별*], [*연령대*], [*...*], [*합계*],
      // 데이터
      [1], [190105], [남자], [45-49세], [...], [19],
      [2], [190106], [남자], [25-29세], [...], [25],
      [4], [190108], [남자], [50세 이상], [...], [16],
      // 세로 생략
      [⋮], [⋮], [⋮], [⋮], [⋮], [⋮],
    )

    \
    중도시 테이블
    #table(
      columns: 6,
      align: center + horizon,
      stroke: 0.5pt + gray,
      // 헤더
      [*\#*], [*고객번호*], [*성별*], [*연령대*], [*...*], [*합계*],
      // 데이터
      [3], [190107], [남자], [50세 이상], [...], [14],
      [5], [190109], [남자], [40-44세], [...], [21],
      [6], [190110], [남자], [45-49세], [...], [16],
      // 세로 생략
      [⋮], [⋮], [⋮], [⋮], [⋮], [⋮],
    )

    \
    대도시 테이블
    #table(
      columns: 6,
      align: center + horizon,
      stroke: 0.5pt + gray,
      // 헤더
      [*\#*], [*고객번호*], [*성별*], [*연령대*], [*...*], [*합계*],
      // 데이터
      [13], [190117], [남자], [35-39세], [...], [25],
      [16], [190120], [남자], [50세 이상], [...], [18],
      [18], [190122], [남자], [30-34세], [...], [16],
      // 세로 생략
      [⋮], [⋮], [⋮], [⋮], [⋮], [⋮],
    )
    
    #v(1em)
    
    // --- 2. 중도시 기준 테이블 ---
    
    
    #v(1em)
    
    // --- 3. 소도시 기준 테이블 ---
  ],
  desc: [
    ```r
    dataSmallCity <- data[data$주거지역 == "소도시", ]
    dataMiddleCity <- data[data$주거지역 == "중도시", ]
    dataBigCity <- data[data$주거지역 == "대도시", ]
    ```
  ]
)

\

4. 상기 데이터프레임에서 품질, 가격, 서비스, 배송 변수만 구성된 신규 데이터프레임을 생성하시오.

#ans(
  [
    #table(
      columns: 5,
      align: center + horizon,
      stroke: 0.5pt + gray,
      
      // 헤더
      table.header(
        [*\#*], [*품질*], [*가격*], [*서비스*], [*배송*],
      ),
      
      // 데이터
      [1], [7], [7], [1], [4],
      [2], [7], [4], [7], [7],
      [3], [4], [4], [3], [3],
      [4], [3], [3], [4], [6],
      [5], [6], [4], [7], [4],
    )
  ],
  desc: [
    ```r
    dataGen04 <- data.frame(
      품질 = data$품질,
      가격 = data$가격,
      서비스 = data$서비스,
      배송 = data$배송
    )
    ```
  ]
)

\

5. 3번에서 거주 지역별로 생성한 3개의 데이터프레임을 하나의 새로운 데이터프레임으로 결합하시오.

#ans(
  [
    #table(
      columns: 6,
      align: center + horizon,
      stroke: 0.5pt + gray,
      // 헤더
      [*\#*], [*고객번호*], [*성별*], [*연령대*], [*...*], [*합계*],
      // 데이터
      [1], [190105], [남자], [45-49세], [...], [19],
      [2], [190106], [남자], [25-29세], [...], [25],
      [4], [190108], [남자], [50세 이상], [...], [16],
      // 세로 생략
      table.cell(colspan: 6)[이하 87개 값 ...]
    )
  ],
  desc: [
    ```r
    dataMerged <- rbind(dataSmallCity, dataMiddleCity, dataBigCity)
    ```
  ]
)

\

6. 상기 데이터프레임을 소득에 대한 내림차순으로 정렬하시오.

#ans(
  [
    #table(
      columns: (auto, auto, auto, 1fr, auto, auto),
      align: center + horizon,
      stroke: 0.5pt + gray,
      
      // 헤더 (성별 열 삭제)
      [*\#*], [*고객번호*], [*연령대*], [*...*], [*소득*], [*합계*],
      
      // 데이터 행 1
      [64], [190168], [35-39세], [...], [9500], [21],
      
      // 데이터 행 2
      [20], [190124], [30-34세], [...], [9400], [23],
      
      // 데이터 행 3
      [18], [190122], [30-34세], [...], [9200], [16],
      
      // 데이터 행 4
      [13], [190117], [35-39세], [...], [8700], [25],
    
      // 세로 생략 표시 행
      [⋮], [⋮], [⋮], [⋮], [⋮], [⋮],
    )
  ],
  desc: [
    ```r
    dataMerged <- dataMerged[order(-dataMerged$소득), ]
    ```
  ]
)

\

7. 4번에서 생성한 데이터프레임에서 apply() 함수를 이용하여 품질 가격, 서비스, 배송값들에 대한 평균을 구하시오.

#ans(
  [
    #table(
      columns: (1fr, 1fr, 1fr, 1fr),
      align: center + horizon,
      stroke: 0.5pt + gray,
      [품질], [가격], [서비스], [배송],
      [$5.422222$], [$4.744444$], [$4.900000$], [$4.455556$]
    )
    \
  ],
  desc: [
    ```r
    > apply(data[, c("품질", "가격", "서비스", "배송")], 2, mean)
        품질     가격   서비스     배송 
    5.422222 4.744444 4.900000 4.455556 
    ```
  ]
)

\

8. 공공데이터포털에서 무료 와이파이 자료에 대한 파일 데이터 셋을 수집하시오.

#ans([
  #image("assets/free-wifi-location.png")

  공공데이터포털에서 `행정안전부_무료와이파이정보`를 획득하였다. 공공데이터포털에서 바로가기로 연결된 행정안전부 「업종별 인허가정보 및 생활편의정보」 공시에서 획득할 수 있었다.  

  #table(
    columns: 3,
    align: center,
    [\#],
    [설치시도명],
    [개수],
    [1],
    [경기도],
    [17966],
    [2],
    [서울특별시],
    [17084],
    [3],
    [전라남도],
    [6712],
    [4],
    [경상북도],
    [6508],
    [5],
    [경상남도],
    [5839],
    [6],
    [강원특별자치도],
    [4812],
    [7],
    [인천광역시],
    [3545],
    [8],
    [제주특별자치도],
    [3395],
    [9],
    [충청남도],
    [3150],
    [10],
    [부산광역시],
    [2629],
    [11],
    [충청북도],
    [2457],
    [12],
    [전북특별자치도],
    [2302],
    [13],
    [광주광역시],
    [1871],
    [14],
    [대전광역시],
    [1404],
    [15],
    [대구광역시],
    [787],
    [16],
    [세종특별자치시],
    [705],
    [17],
    [울산광역시],
    [690],
  )

  ```r
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

  ```
])

\

9. 네이버 블로그에서 맛집을 키워드로 실행한 후, 첫 화면에 대하여 웹 스크래핑하여 자료를 수집하시오.

#ans([
  - 네이버 블로그(`https://blog.naver.com`)에서 `맛집` 검색 시 url 엔드포인트:
    `https://section.blog.naver.com/Search/Post.naver?pageNo=1&rangeType=ALL&orderBy=sim&keyword=맛집`
    
  - 기준 작업 일자: 2025-03-31
  
  ```r
  library(chromote)
  library(rvest)
  
  endpoint <- "https://section.blog.naver.com/Search/Post.naver?pageNo=1&rangeType=ALL&orderBy=sim&keyword=맛집"
  
  b <- ChromoteSession$new()
  
  get_page_source <- function(url, wait = 5) {
    b$Page$navigate(url)
    Sys.sleep(wait)
    
    html <- b$Runtime$evaluate(
      "document.documentElement.outerHTML"
    )$result$value
    
    return(read_html(html))   # ← 여기서 이미 xml_document 반환
  }
  
  page <- get_page_source(endpoint)
  
  descs  <- page %>% html_elements("div.list_search_post div.item div.info_post div.desc")
  hrefs  <- descs %>% html_elements("a.desc_inner") %>% html_attr("href")
  titles <- descs %>% html_elements(".title_post") %>% html_text()
  
  cat("[ desc 노드 수 ]:", length(descs), "\n")
  cat("[ href 노드 수 ]:", length(hrefs), "\n")
  
  cat("\n[ hrefs ]\n")
  print(hrefs)
  
  cat("\n[ titles ]\n")
  print(titles)
  
  for (i in seq_along(titles)) {
    titles[i] <- trimws(titles[i])
  }
  
  result_df <- data.frame(
    title = titles,
    href  = hrefs,
    stringsAsFactors = FALSE
  )
  
  print(result_df)

  ```],
  desc: [#table(
    columns: 2,
    align: horizon,
    stroke: 0.5pt + rgb("#bdc3c7"),
    inset: 8pt,
    /* header */
    table.header(
      text(weight: "bold")[\#],
      text(weight: "bold")[제목],
    ),
  
    /* data */
    table.cell(rowspan: 2)[1],
    [인천 만수동 만수3지구 맛집 엄마네전이랑막걸리],
    [#link("https://blog.naver.com/nutsnim/223900604232")],
  
    table.cell(rowspan: 2)[2],
    [\[남대문 맛집\] 남대문 골목에서 우연히 찾은 숨은 맛집인 남대문 영도 국밥집 솔직 후기! ( 맛집 인정! )],
    [#link("https://blog.naver.com/madlion_93/224001948471")],
  
    table.cell(rowspan: 2)[3],
    [일본맛집/오코노미야끼 맛집/대마도 맛집/이즈하라 맛집/내돈내산 맛집/마메다 예약/마메다 2차\[마메다\]],
    [#link("https://blog.naver.com/mini_s__/224195585734")],
  
    table.cell(rowspan: 2)[4],
    [울산 옥동맛집 중국성에서 우육면 동파육덮밥 향라육 솔직후기],
    [#link("https://blog.naver.com/jaymiraclelife/224152351744")],
  
    table.cell(rowspan: 2)[5],
    [방콕 센터 포인트 호텔 실롬 주변 맛집은 어디? 센포실 주변 맛집 미슐랭 맛집 추천],
    [#link("https://blog.naver.com/dobbyjubby/224133667479")],
  
    table.cell(rowspan: 2)[6],
    [\[시흥/대야동\] 한신가든 (한우 정육식당 맛집 솔직한 후기)],
    [#link("https://blog.naver.com/kyuni0912/224186292182")],
  
    table.cell(rowspan: 2)[7],
    [전주 장수투가리 \| 전주 효자동 삼겹살 맛집 \| 전주 로컬 맛집 \| 전주 로컬 삼겹살 맛집 \| 전주 생삼겹살 \| 전주 동네 단골 많은 장수투가리 솔직 후기 \| 전주 현지인 맛집],
    [#link("https://blog.naver.com/gywls5507/224164810242")],
  )]
)

\

10. 공공데이터포털에서 오픈 API(국토교통부 실거래)를 통하여 2021년 1월 서울 강남구의 아파트 매매 실거래가 자료를 수집하시오.

#ans(
  [
    ```r
    library(dotenv)
    library(httr)
    
    load_dot_env(".env")
    query_key <- Sys.getenv("DATA_GO_KR_APT_SELL_QUERY_KEY")
    
    endpoint <- "https://apis.data.go.kr/1613000/RTMSDataSvcAptTrade/getRTMSDataSvcAptTrade"
    
    # LAWD_CD: 서울 강남구 (11680)
    # DEAL_YMD: 2021년 1월 (202101)
    lawd_cd <- "11680"
    deal_ymd <- "202101"
    num_of_rows <- "100" # 한 페이지에 출력할 결과 수
    
    query_url <- paste0(
      endpoint,
      "?serviceKey=", query_key,
      "&LAWD_CD=", lawd_cd,
      "&DEAL_YMD=", deal_ymd,
      "&numOfRows=", num_of_rows
    )
    
    res <- GET(query_url, add_headers("User-Agent" = "Mozilla/5.0"))
    print(paste("Response Status:", status_code(res)))
    
    resBody <- content(res, "text", encoding = "UTF-8")
    
    library(jsonlite)
    
    dataList <- fromJSON(resBody)
    tradeData <- dataList$response$body$items
    
    if (
      !is.null(tradeData)
    ) {
      if (is.list(tradeData) && "item" %in% names(tradeData)) {
        tradeData <- tradeData$item
      }
      
      View(tradeData)
      print(paste("Data fetched: ", nrow(tradeData), "rows."))
    } else {
      print("Error: Data is invalid or invalid data structure.")
      print(resBody)
    }

    ```
  ],
  desc: [
    #rotate(90deg, reflow: true)[
      #table(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
        inset: 5pt,
        align: horizon,
        
        // Header
        [*no*], [*aptNm*], [*buildYear*], [*dealAmount*], [*dealDay*], [*dealMonth*], [*dealYear*], [*excluUseAr*], [*floor*], [*jibun*], [*landLeaseholdGbn*], [*sggCd*], [*umdNm*],
      
        // Row 1
        [1], [개포래미안포레스트], [2020], [245,000], [17], [1], [2021], [74.66], [7], [1282], [N], [11680], [개포동],
        
        // Row 2
        [2], [성원대치2단지아파트], [1992], [111,000], [21], [1], [2021], [33.18], [12], [12], [N], [11680], [개포동],
        
        // Row 3
        [3], [쌍용플레티넘밸류], [2007], [149,000], [29], [1], [2021], [110.57], [8], [826-37], [N], [11680], [역삼동],
        
        // Row 4
        [4], [개포우성1], [1983], [285,000], [2], [1], [2021], [84.81], [12], [503], [N], [11680], [대치동],
      )
    ]
  ]
)
