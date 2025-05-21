wget https://dlcdn.apache.org/hbase/2.6.1/hbase-2.6.1-hadoop3-bin.tar.gz
tar xvfz hbase-2.6.1-hadoop3-bin.tar.gz
mv hbase-2.6.1-hadoop3-bin hbase

# Reconfigure HBase
echo "export HBASE_HOME=$(pwd)/hbase" >> ~/.bashrc

cp ./hbase-site.xml $HBASE_HOME/conf/hbase-site.xml


start-hbase.sh

jps | grep -E 'HMaster|HRegionServer'
ss -ltn | grep -E '16010|16030|2181'
hdfs dfs -ls /hbase

# execute table commands

stop-hbase.sh
