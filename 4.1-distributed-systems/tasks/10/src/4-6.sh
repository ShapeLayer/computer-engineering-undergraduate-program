# page 8
run-example streaming.NetworkWordCount localhost 9999

# page 9
ls $SPARK_HOME/examples/src/main/scala/org/apache/spark/examples/streaming

# page 11
mkdir streaming_test
cd streaming_test
run-example streaming.HdfsWordCount streaming_test

# page 17
nc -lk 9999
run-example sql.streaming.StructuredNetworkWordCount localhost 9999
