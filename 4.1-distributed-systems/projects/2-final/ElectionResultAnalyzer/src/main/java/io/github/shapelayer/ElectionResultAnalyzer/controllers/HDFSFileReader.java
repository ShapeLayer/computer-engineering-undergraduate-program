package io.github.shapelayer.ElectionResultAnalyzer.controllers;

import io.github.shapelayer.ElectionResultAnalyzer.commons.Defaults;
import io.github.shapelayer.ElectionResultAnalyzer.models.FileIOCompatible;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
/*
public class HDFSFileReader implements FileIOCompatible {
  private Configuration conf;
  private FileSystem fs;
  
  public HDFSFileReader() throws IOException {
    this.conf = new Configuration();

    conf.set("fs.defaultFS", Defaults.HADOOP_CONFIG_FS_DEFAULT_FS);
    this.fs = FileSystem.get(conf);
  }
  
  public HDFSFileReader(Configuration configuration) throws IOException {
      this.conf = configuration;
      this.fs = FileSystem.get(conf);
  }
  
  @Override
  public List<String[]> readCSV(String filePath) {
    List<String[]> result = new ArrayList<>();
    Path path = new Path(filePath);
    
    try (BufferedReader reader = new BufferedReader(
      new InputStreamReader(fs.open(path)))) {

      String line;
      while ((line = reader.readLine()) != null) {
        String[] fields = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");

        for (int i = 0; i < fields.length; i++) {
          fields[i] = fields[i].trim().replaceAll("^\"|\"$", "");
        }
        
        result.add(fields);
      }
    }
    
    return result;
  }
  
  public void close() throws IOException {
    if (fs != null) {
      fs.close();
    }
  }
}
*/