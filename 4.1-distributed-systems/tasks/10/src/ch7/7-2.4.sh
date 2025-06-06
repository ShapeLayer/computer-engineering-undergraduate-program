# Page 15
spark-submit --master yarn --num-executors 3 --class org.apache.spark.examples.ml.JavaRandomForestClassifierExample $SPARK_HOME/examples/jars/spark-examples_2.12-3.5.5.jar

# Page 17
spark-submit --master yarn --num-executors 3 --class org.apache.spark.examples.ml.JavaALSExample $SPARK_HOME/examples/jars/spark-examples_2.12-3.5.5.jar > out_als
