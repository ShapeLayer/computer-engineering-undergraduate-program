wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/wordcount2.tar.gz
tar xvfz wordcount2.tar.gz
cd wordcount2

wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/10K.ID.CONTENTS
hdfs dfs -copyFromLocal 10K.ID.CONTENTS input



javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf wordcount2.jar -C bin .

hadoop jar wordcount2.jar WordCount2 input/10K.ID.CONTENTS wc_out2

hdfs dfs -ls wc_out2
hdfs dfs -cat wc_out2/part-r-00000 | more



javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf wordcount2c.jar -C bin .
hadoop jar wordcount2c.jar WordCount2 input/10K.ID.CONTENTS wc_out2c

hdfs dfs -ls wc_out2c
hdfs dfs -get wc_out2c/part-r-00000 .



wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/topn.tar.gz
tar xvfz topn.tar.gz
cd topn

hdfs dfs -ls wc_out1
hdfs dfs -ls wc_out2



javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf topn.jar -C bin .
hadoop jar topn.jar TopN wc_out1/part-r-00000 wc_out1/topn1 15
hadoop jar topn.jar TopN wc_out2/part-r-00000 wc_out2/topn1 15

hdfs dfs -ls wc_out1
hdfs dfs -cat wc_out1/topn1/part-r-00000
hdfs dfs -ls wc_out1
hdfs dfs -cat wc_out1/topn1/part-r-00000
