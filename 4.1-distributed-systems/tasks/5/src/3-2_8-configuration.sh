start-dfs.sh
start-yarn.sh

hdfs dfs -mkdir /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse

hdfs dfs -ls /
hdfs dfs -ls /user/hive

cd $HIVE_HOME/conf
cp hive-env.sh.template hive-env.sh

echo 'HADOOP_HOME=${HADOOP_HOME}' >> hive-env.sh
echo 'export HIVE_CONF_DIR=${HIVE_HOME}/conf' >> hive-env.sh

cd $HADOOP_HOME/etc/hadoop

cat ./core-site.diff.xml >> core-site.xml
# modify core-site.xml additionally required. (place content inside <configuration> tag)


cd $HIVE_HOME/conf
cp hive-default.xml.template hive-site.xml

cat ./hive-site.diff.xml >> hive-site.xml
# modify hive-site.xml additionally required. (place content inside <configuration> tag)
