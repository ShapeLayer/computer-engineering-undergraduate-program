x <- c(1, 2, 3, 4)
y <- c("red", "white", "blue", "yellow")
z <- c(TRUE, TRUE, TRUE, FALSE)

df <- data.frame(x = x, y = y, z = z)
df


mean(df$x)
sum(df$x)


colnames(df) <- c("숫자", "색상", "논릿값")
df
