wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/invertedindex.tar.gz
tar xvfz invertedindex.tar.gz

javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf invertedindex.jar -C bin .

hadoop jar invertedindex.jar InvertedIndex input/10K.ID.CONTENTS ii_out1

hdfs dfs -ls ii_out1
hdfs dfs -cat ii_out1/part-r-00000 | more
