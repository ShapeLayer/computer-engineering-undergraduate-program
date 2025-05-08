wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/crud_example/CreateExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/crud_example/PutExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/crud_example/ScanGetExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/crud_example/UpdateExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/crud_example/DeleteExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/crud_example/DisableDropExample.java

javac -cp "$HBASE_HOME/lib/*" *.java
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" CreateExample
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" PutExample
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" ScanGetExample
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" UpdateExample
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" DeleteExample
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" DisableDropExample
