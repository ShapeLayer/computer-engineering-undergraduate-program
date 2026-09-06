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
