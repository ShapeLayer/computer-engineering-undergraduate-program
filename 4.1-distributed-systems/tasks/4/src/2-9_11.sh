wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/joinidtitle.tar.gz
tar xvfz joinidtitle.tar.gz

cd jointitle

wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/title.tar.gz
tar xvfz title.tar.gz
hdfs dfs -copyFromLocal 2M.TITLE.ID input

javac -classpath $(hadoop classpath) -d bin src/*.java
jar -cvf joinidtitle.jar -C bin .

# hadoop jar joinidtitle.jar JoinIDTitle input/2M.TITLE.ID cc_out_auth1/topN1/part-r-00000 join_out1
hadoop jar joinidtitle.jar JoinIDTitle input/2M.TITLE.ID cc_out_auth1/part-r-00000 join_out1

hdfs dfs -ls join_out1
hdfs dfs -cat join_out1/part-r-00000
