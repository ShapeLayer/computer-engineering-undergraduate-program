package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.commons.Defaults;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;

import java.io.IOException;

public class HdfsConfig {
  public static Configuration createConfiguration(String nameNode) {
    Configuration conf = new Configuration();
    
    if (nameNode != null) {
      conf.set("fs.defaultFS", nameNode);
    } else {
      conf.set("fs.defaultFS", Defaults.DEFAULT_HDFS_NAMENODE);
    }
    
    conf.set("dfs.client.use.datanode.hostname", "true");
    conf.set("dfs.datanode.use.datanode.hostname", "true");
    
    return conf;
  }
  
  public static FileSystem getFileSystem(String nameNode) throws IOException {
    Configuration conf = createConfiguration(nameNode);
    return FileSystem.get(conf);
  }
}
