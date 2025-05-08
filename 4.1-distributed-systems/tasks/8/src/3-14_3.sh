hbase org.apache.hadoop.hbase.mapreduce.RowCounter employees
hbase org.apache.hadoop.hbase.mapreduce.CellCounter employees /output/emp_cells
hdfs dfs -cal /output/emp_cells/part-r-00000

# javac -cp "$HBASE_HOME/lib/*" *.java
# java  -cp ".:$HBASE_HOME/lib/*:$(hadoop classpath)" program_name
