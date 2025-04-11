cd ~/hadoop_test
mkdir -p test01
cd test01
mkdir -p input
cp $HADOOP_HOME/etc/hadoop/*.xml input/.
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar wordcount input output
ls output
cat output/part-r-00000
