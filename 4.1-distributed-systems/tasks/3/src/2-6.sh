wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/wordcount.tar.gz
tar -xvf wordcount.tar.gz
cd wordcount

javac -classpath $(hadoop classpath) -d bin src/WordCount.java
jar -cvf wordcount.jar -C bin .

wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/under_sea
hdfs dfs -put under_sea input
hadoop jar wordcount.jar WordCount input/under_sea wc_out1

hdfs dfs -ls wc_out1
hdfs dfs -cat wc_out1/part-r-00000 | more
