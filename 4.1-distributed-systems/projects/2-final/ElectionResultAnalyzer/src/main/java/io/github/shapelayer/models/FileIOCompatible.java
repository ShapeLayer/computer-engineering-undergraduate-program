package io.github.shapelayer.models;

public interface FileIOCompatible {
  List<String[]> readCSV(String filePath) throws IOException;
}
