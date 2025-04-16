javac-classpath $(hadoop classpath) -d bin src/*.java
jar -cvf joinidtitle.jar -C bin .

hadoop jar joinidtitle.jar JoinIDTitle input/2M.TITLE.ID cc_out_auth1/topN1/part-r-00000 join_out1

hdfs dfs-ls join_out1
hdfs dfs-cat join_out1/part-r-00000
