wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/citationcount.tar.gz
tar xvfz citationcount.tar.gz

wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/id.tar.gz
tar xvfz id.tar.gz
hdfs dfs -copyFromLocal 2M.SRCID.DSTID input

javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf citationcount_auth.jar -C bin .

hadoop jar citationcount_auth.jar CountCitation input/2M.SRCID.DSTID cc_out_auth1

hdfs dfs -ls cc_out_auth1
hdfs dfs -cat cc_out_auth1/part-r-00000 | more

# hub mapper
jar -cvf citationcount_hub.jar -C bin .
hadoop jar citationcount_hub.jar CountCitation input/2M.SRCID.DSTID cc_out_hub1
hdfs dfs -ls cc_out_hub1
hdfs dfs -cat cc_out_hub1/part-r-00000 | more
