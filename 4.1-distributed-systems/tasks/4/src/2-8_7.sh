wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/trigramcount.tar.gz
tar xvfz trigramcount.tar.gz

javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf trigramcount.jar -C bin .
hadoop jar trigramcount.jar CountTrigram input/under_sea tc_out1

hdfs dfs -ls tc_out1
hdfs dfs -ls tc_out1/topN
hdfs dfs -cat wc_out2/part-r-00000 | more
