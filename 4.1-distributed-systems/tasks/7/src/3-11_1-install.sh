mkdir ~/hbase_test
cd ~/hbase_test
wget https://dlcdn.apache.org/hbase/2.6.1/hbase-2.6.1-bin.tar.gz
tar xvfz hbase-2.6.1-bin.tar.gz



echo 'export HBASE_HOME=/home/hduser/hbase_test/hbase-2.6.1' >> ~/.bashrc
echo 'PATH=$HBASE_HOME/bin:$PATH' >> ~/.bashrc

echo 'export JAVA_HOME=$(readlink -f /usr/bin/java | sed"s:bin/java::")' >> $HBASE_HOME/conf/hbase-env.sh



mv ~/hadoop_test ~/hadoop_test_1



cd ~/hbase_test/hbase-2.6.1
./bin/start-hbase.sh

jps | grep HMaster

ss -ltn | grep -E '16010|16030|2181'

# open http://localhost:16010

~/hbase_test/hbase-2.6.1/bin/hbase shell
