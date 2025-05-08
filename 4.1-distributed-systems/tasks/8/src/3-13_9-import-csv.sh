hdfs dfs -put ./emp.csv /output
echo 'create `employees`, `personal`, `department`' | hbase shell

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator="," -Dimporttsv.columns=HBASE_ROW_KEY,personal:name,department:role employees /output/emp.csv


# Page 10
echo 'create `employees_copy`, `personal`, `department`' | hbase shell
hbase org.apache.hadoop.hbase.mapreduce.CopyTable -new.name=employees_copy employees


# Page 11
hbase org.apache.hadoop.hbase.mapreduce.Export employees /output/employees
echo 'create `employees_import`, `personal`, `department`' | hbase shell
hbase org.apache.hadoop.hbase.mapreduce.Import employees_import /output/employees
