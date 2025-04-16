wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/invertedindex2.tar.gz

tar xvfz invertedindex2.tar.gz

javac-classpath $(Hadoop classpath) -d bin src/*.java
jar -cvf invertedindex2.jar -C bin .
hadoop jar invertedindex2.jar InvertedIndex2 input/10K.ID.CONTENTS ii2_out1

hdfs dfs-ls ii2_out1
hdfs dfs-cat ii2_out1/part-r-00000
