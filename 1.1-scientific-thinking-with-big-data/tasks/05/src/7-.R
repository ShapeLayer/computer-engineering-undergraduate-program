par(family="Noto Sans KR")

manufacturers <- c("Samsung", "Huawei", "Apple", "Xiaomi", "OPPO", "Other")
quantities <- c(2090, 0.158, 0.121, 0.093, 0.086, 0.332)

barplot(quantities, names.arg = manufacturers, 
        main = "세계 스마트폰 판매 현황", 
        col = "skyblue", 
        ylab = "수량",
        cex.names = 0.8)

plot(quantities, type = "o", col = "red", 
      xaxt = "n", # 기본 x축 숨김
      main = "세계 스마트폰 판매 현황", 
      xlab = "제조사", ylab = "수량")
  
axis(1, at = 1:6, labels = manufacturers)

pie(quantities, labels = manufacturers, 
    main = "세계 스마트폰 판매 현황", 
    col = rainbow(length(quantities)))
