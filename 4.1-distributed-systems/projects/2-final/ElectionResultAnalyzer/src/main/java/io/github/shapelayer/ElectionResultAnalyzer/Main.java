package io.github.shapelayer.ElectionResultAnalyzer;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import io.github.shapelayer.ElectionResultAnalyzer.controllers.CSVFeeder;
import io.github.shapelayer.ElectionResultAnalyzer.controllers.ElectionResultAnalyzer;
import io.github.shapelayer.ElectionResultAnalyzer.controllers.LocalFileReader;

/**
 * Main class for Election Result Analyzer
 * 
 * This program reads CSV files containing election results, processes them to extract
 * vote data for specific political parties, and generates summary reports by party and region.
 */
class MainArgs {
  String inputPath;
  String outputPath;

  public static MainArgs parse(String[] args) {
    MainArgs mainArgs = new MainArgs();
    for (String arg : args) {
      if (arg.startsWith("--input=")) {
        mainArgs.inputPath = arg.split("=")[1];
      } else if (arg.startsWith("--output=")) {
        mainArgs.outputPath = arg.split("=")[1];
      }
    }
    return mainArgs;
  }

  public boolean validateValues() {
    boolean isValid = true;
    isValid &= (inputPath != null && outputPath != null);

    if (!isValid) return false;

    // Check path is exists
    File inputFile = new File(inputPath);
    if (!inputFile.exists() || !inputFile.isFile()) {
      System.err.println("Input file does not exist or is not a valid file: " + inputPath);
      isValid = false;
    }

    File outputFile = new File(outputPath);
    if (outputFile.exists()) {
      if (!outputFile.isFile()) {
        System.err.println("Output path exists but is not a valid file: " + outputPath);
        isValid = false;
      }
    } else {
      // Create parent directories if they do not exist
      File parentDir = outputFile.getParentFile();
      if (parentDir != null && !parentDir.exists()) {
        if (!parentDir.mkdirs()) {
          System.err.println("Failed to create output directory: " + parentDir.getAbsolutePath());
          isValid = false;
        }
      }
    }

    return isValid;
  }
}

public class Main {
  public static void main(String[] args) {
    MainArgs mainArgs = MainArgs.parse(args);
    if (mainArgs.inputPath == null || mainArgs.outputPath == null) {
      System.out.println("Usage: java -jar ElectionResultAnalyzer.jar --input=<input_file> --output=<output_file>");
      System.exit(1);
    }

    String[] inputPaths = queryInputPath(mainArgs.inputPath);
    ElectionResultAnalyzer analyzer = new ElectionResultAnalyzer();
    CSVFeeder feeder = new CSVFeeder(inputPaths, analyzer);
    LocalFileReader fileIO = new LocalFileReader();
    feeder.feed(fileIO);

    System.out.println(analyzer.toString());
  }

  static String[] queryInputPath(String inputPath) {
    List<String> paths = new ArrayList<String>();
    String[] _paths = inputPath.split(",");
    for (String each : _paths) {
      File file = new File(each);
      if (!file.exists()) {
        System.err.println("Input file does not exist or is not a valid file: " + each);
        continue;
      }
      if (file.isFile()) {
        if (each.endsWith(".csv")) {
          paths.add(file.getAbsolutePath());
        } else {
          System.err.println("Input file is not a CSV file: " + each);
        }
      } else if (file.isDirectory()) {
        File[] files = file.listFiles((dir, name) -> name.endsWith(".csv"));
        if (files != null) {
          for (File f : files) {
            paths.add(f.getAbsolutePath());
          }
        } else {
          System.err.println("No CSV files found in directory: " + each);
        }
      } else {
        System.err.println("Input path is neither a file nor a directory: " + each);
      }
    }

      return paths.toArray(new String[0]);
  }
}