setwd("~/Documents/GitHub/ShapeLayer/univ-lectures-private/26-1-ge-scientific-thinking-with-big-data/tasks/06/src/10-property-selling")
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
