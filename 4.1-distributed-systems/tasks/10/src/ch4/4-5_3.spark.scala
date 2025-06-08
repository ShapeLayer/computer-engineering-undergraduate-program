// Page 13
val df = spark.sql("select * from flight");
df.show();

df.first();
df.collect();
df.filter(col("count") > 10).show(2);

df.groupBy("DEST_COUNTRY_NAME").agg(
  sum("count").alias("sum_count"),
  avg("count").alias("avg_count")
).orderBy(col("sum_count").desc).show();
