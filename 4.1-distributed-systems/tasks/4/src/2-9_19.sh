wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hadoop/joinidtitle2.tar.gz
tar xvfz joinidtitle2.tar.gz

javac-classpath $(Hadoop classpath) -d bin src/*.java
jar -cvf joinidtitle2.jar -C bin .

hadoop jar joinidtitle.jar JoinIDTitle input/2M.TITLE.ID cc_out_auth1/topN1/part-r-00000 join_out2

hdfs dfs-ls join_out2
hdfs dfs-cat join_out2/part-r-00000
