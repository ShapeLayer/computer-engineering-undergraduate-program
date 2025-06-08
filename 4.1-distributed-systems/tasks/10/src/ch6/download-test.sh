wget https://github.com/kyungbaekkim/bigdata_training/raw/refs/heads/main/sample_data/dewiki-sample.txt.gz
hdfs dfs -put dewiki-sample.txt.gz /input
hadoop jar path_of_example.jar wordcount /input /output
