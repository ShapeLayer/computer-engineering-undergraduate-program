// 4
val df = spark.read.format("json").load("./2015-summary.json")
df.printSchema()
df.schema

// 5
df.columns

// 6
df.first()
df.collect()

// 7
df.select("DEST_COUNTRY_NAME").show(2)
df.select("DEST_COUNTRY_NAME", "ORIGIN_COUNTRY_NAME").show(2)
df.select(df.col("DEST_COUNTRY_NAME"), "DEST_COUNTRY_NAME")
df.select(df.col("DEST_COUNTRY_NAME"),col("DEST_COUNTRY_NAME"),'DEST_COUNTRY_NAME,$"DEST_COUNTRY_NAME").show(2)

// 8
df.select(expr("DEST_COUNTRY_NAME AS destination")).show(2)
df.selectExpr("*", "(DEST_COUNTRY_NAME = ORIGIN_COUNTRY_NAME) as withinCountry").show(2)
val df1 = df.selectExpr("*", "(DEST_COUNTRY_NAME = ORIGIN_COUNTRY_NAME) as withinCountry")
df1.schema
df1.show(2)

// 9
df.withColumn("numberOne", lit(1)).show(2)
df.withColumn("withinCountry", expr("ORIGIN_COUNTRY_NAME == DEST_COUNTRY_NAME")).show(2)
df.withColumnRenamed("DEST_COUNTRY_NAME", "dest").columns
df.drop("ORIGIN_COUNTRY_NAME").columns
df.withColumn("count2", col("count").cast("string"))

// 10
df.filter(col("count") < 2 ).show(2)
df.where ("count < 2").show(2)
df.where(col("count") < 2).where(col("ORIGIN_COUNTRY_NAME") =!= "Croatia").show(2)

// 11
df.select("ORIGIN_COUNTRY_NAME", "DEST_COUNTRY_NAME").distinct().count()

// 12
val seed = 5
val withReplacement = false
val fraction = 0.5
df.sample(withReplacement, fraction, seed).count()
seed = 100
df.sample(withReplacement, fraction, seed).show()

// 13
val dataFrames = df.randomSplit(Array(0.25, 0.75), seed)
dataFrames(0).count()
dataFrames(1).count()
df.count()
val dataFrames = df.randomSplit(Array(0.1, 0.2, 0.7), seed)
dataFrames(0).count()
dataFrames(1).count()
dataFrames(2).count()
df.count()

// 14
df.sort("count").show(5)
df.orderBy("count", "DEST_COUNTRY_NAME").show(5)
df.orderBy(expr("count").desc).show(5)
df.orderBy(desc("count"), asc("DEST_COUNTRY_NAME")).show(5)

// 15
df.rdd.getNumPartitions
df.repartition(5)
df.repartition(5, col("DEST_COUNTRY_NAME"))
