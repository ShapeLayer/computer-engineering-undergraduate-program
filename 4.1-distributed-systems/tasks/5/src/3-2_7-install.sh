mkdir ~/hive_test
cd ~/hive_test

wget https://archive.apache.org/dist/hive/hive-4.0.0/apache-hive-4.0.0-bin.tar.gz
tar xvfz apache-hive-4.0.0-bin.tar.gz

echo 'export HIVE_HOME=/home/hduser/hive_test/apache-hive-4.0.0-bin' >> ~/.bashrc
echo 'export PATH=$HIVE_HOME/bin:$PATH' >> ~/.bashrc

source ~/.bashrc
echo $HIVE_HOME
