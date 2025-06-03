val flightData = spark.read.option("inferSchema", "true").option("header", "true").csv("./2015-summary.csv")
flightData.take(3)

flightData.sort("count").take(3)
flightData.orderBy(desc("count")).take(3)
flightData.sort("count").explain()
flightData.orderBy(desc("count")).explain()
