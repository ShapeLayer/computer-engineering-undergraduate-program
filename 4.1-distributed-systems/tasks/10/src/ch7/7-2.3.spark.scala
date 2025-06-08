import org.apache.spark.sql.SparkSession;

val spark = SparkSession.builder().appName("Spark Hive Example").config("spark.sql.warehouse.dir", "hdfs://localhost/user/hive/warehouse").enableHiveSupport().getOrCreate();

spark.sql("show tables").show();
