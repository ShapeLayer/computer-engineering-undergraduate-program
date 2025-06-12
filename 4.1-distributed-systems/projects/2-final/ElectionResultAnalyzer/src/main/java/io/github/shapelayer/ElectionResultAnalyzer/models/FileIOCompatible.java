package io.github.shapelayer.ElectionResultAnalyzer.models;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public interface FileIOCompatible {
  List<String[]> readCSV(String filePath) throws IOException, FileNotFoundException;
}
