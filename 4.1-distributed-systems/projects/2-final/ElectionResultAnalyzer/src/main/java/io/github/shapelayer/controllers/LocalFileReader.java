package io.github.shapelayer.models;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LocalFileReader implements FileIOCompatible {
  @Override
  public List<String[]> readCSV(String filePath) throws IOException {
    List<String[]> result = new ArrayList<>();
    
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
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
}
