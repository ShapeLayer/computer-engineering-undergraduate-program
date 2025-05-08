javac -cp ".:$HBASE_HOME/lib/*" target.java
java -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" target

wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/filter/HBaseHelper.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/filter/RandomTableCreate.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/filter/RowFilterExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/filter/FamilyFilterExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/filter/QualifierFilterExample.java
wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/hbase/filter/ValueFilterExample.java
