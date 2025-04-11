ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

cp ./etc/core-site.xml /home/hduser/hadoop_test/hadoop-3.4.0/etc/hadoop
cp ./etc/hdfs-site.xml /home/hduser/hadoop_test/hadoop-3.4.0/etc/hadoop
cp ./etc/hadoop-env.sh /home/hduser/hadoop_test/hadoop-3.4.0/etc/hadoop

hdfs namenode -format
start-dfs.sh
jps
ss -lt

cp ./etc/mapred-site.xml /home/hduser/hadoop_test/hadoop-3.4.0/etc/hadoop
cp ./etc/yarn-site.xml /home/hduser/hadoop_test/hadoop-3.4.0/etc/hadoop
start-yarn.sh
jps
ss -lt

hdfs dfs -mkdir -p user/hduser

hdfs dfs -mkdir input
hdfs dfs -put ~/hadoop_test/test01/input/* input

hdfs dfs -ls
hdfs dfs -ls input
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar wordcount input output

hdfs dfs -ls output
hdfs dfs -get output output1
