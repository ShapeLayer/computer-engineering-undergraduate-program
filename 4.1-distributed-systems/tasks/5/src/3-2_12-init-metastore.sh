cd $HIVE_HOME
schematool -dbType derby -initSchema

ls metastore_db

stop-dfs.sh && stop-yarn.sh
start-dfs.sh && start-yarn.sh

hiveserver2

# at another terminal
ss -ltn | grep "10000\|10002"

cd ~/hive_test
beeline -n hduser -u jdbc:hive2://localhost:10000
# or
# beeline
# !connect jdbc:hive2://localhost:10000

!table
!sh ls
dfs -ls / ;
!quit