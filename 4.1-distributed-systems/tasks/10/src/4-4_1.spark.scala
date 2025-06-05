val df = spark.read.format("json").load("./2015-summary.json")

// Page 4
df.select(count("DEST_COUNTRY_NAME"), countDistinct("DEST_COUNTRY_NAME")).show()
df.select(min("count"), max("count"), sum("count"), sumDistinct("count"),avg("count")).show()
df.select(var_pop("count"),var_samp("count"),stddev_pop("count"),stddev_samp("count")).show()

// Page 5
df.groupBy("DEST_COUNTRY_NAME").agg(sum("count").alias("sum_count")).show()
df.groupBy("DEST_COUNTRY_NAME").agg(sum("count").alias("sum_count")).orderBy(col("sum_count").desc).show()
df.groupBy("DEST_COUNTRY_NAME").agg(sum("count").alias("sum_count"),avg("count").alias("avg_count")).orderBy(col("sum_count").desc).show()
