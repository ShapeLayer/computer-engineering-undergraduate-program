package io.github.shapelayer;

import io.github.shapelayer.controllers.ElectionResultAnalyzer;

import java.io.IOException;
import java.nio.file.Paths;

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
}

public class Main {
  public static void main(String[] args) {
    MainArgs mainArgs = MainArgs.parse(args);
    if (mainArgs.inputPath == null || mainArgs.outputPath == null) {
      System.out.println("Usage: java -jar ElectionResultAnalyzer.jar --input=<input_file> --output=<output_file>");
      System.exit(1);
    }

    ElectionResultAnalyzer analyzer = new ElectionResultAnalyzer();
    try {
      analyzer.processResults(Paths.get(mainArgs.inputPath), Paths.get(mainArgs.outputPath));
      System.out.println("Election results processed successfully. Output saved to: " + mainArgs.outputPath);
    } catch (IOException e) {
      System.err.println("Error processing election results: " + e.getMessage());
      e.printStackTrace();
      System.exit(1);
    }
  }
}