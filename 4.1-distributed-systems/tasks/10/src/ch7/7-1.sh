# Page 15
spark-submit --master yarn --class org.apache.spark.examples.SparkPi --deploy-mode client $SPARK_HOME/examples/jars/spark-examples_2.12-3.5.5.jar 100
spark-submit --master yarn --class org.apache.spark.examples.SparkPi --num-executors 3 --deploy-mode client $SPARK_HOME/examples/jars/spark-examples_2.12-3.5.5.jar 100

# Page 20
spark-submit --master yarn --num-executors 3 --class org.apache.spark.examples.JavaWordCount $SPARK_HOME/examples/jars/spark-examples_2.12-3.5.5.jar /input > out_wordcount
