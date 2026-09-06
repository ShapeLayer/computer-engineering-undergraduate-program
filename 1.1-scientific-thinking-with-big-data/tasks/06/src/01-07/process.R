# 01
data <- read.csv("data.csv", header=T)

# 02
data["합계"] <- data["품질"] + data["가격"] + data["서비스"] + data["배송"]
write.csv(data, "02.csv")

# 03
dataSmallCity <- data[data$주거지역 == "소도시", ]
dataMiddleCity <- data[data$주거지역 == "중도시", ]
dataBigCity <- data[data$주거지역 == "대도시", ]
write.csv(dataSmallCity, "03-small.csv")
write.csv(dataMiddleCity, "03-middle.csv")
write.csv(dataBigCity, "03-big.csv")

# 04
dataGen04 <- data.frame(
  품질 = data$품질,
  가격 = data$가격,
  서비스 = data$서비스,
  배송 = data$배송
)
write.csv(dataGen04, "04.csv")

# 05
dataMerged <- rbind(dataSmallCity, dataMiddleCity, dataBigCity)
write.csv(dataMerged, "05.csv")

# 06
dataMerged <- dataMerged[order(-dataMerged$소득), ]
write.csv(dataMerged, "06.csv")

# 07
apply(data[, c("품질", "가격", "서비스", "배송")], 2, mean)
