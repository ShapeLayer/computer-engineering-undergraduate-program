package io.github.shapelayer;

import io.github.shapelayer.analyzer.ElectionResultAnalyzer;

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
}

public class Main {
    public static void main(String[] args) {
        try {
            // Get the current working directory and construct paths
            String currentDir = System.getProperty("user.dir");
            String csvDirectory = Paths.get(currentDir, "csv").toString();
            String outputDirectory = Paths.get(currentDir, "output").toString();
            
            System.out.println("Election Result Analyzer");
            System.out.println("========================");
            System.out.printf("CSV Directory: %s%n", csvDirectory);
            System.out.printf("Output Directory: %s%n", outputDirectory);
            System.out.println();
            
            // Create and run the analyzer
            ElectionResultAnalyzer analyzer = new ElectionResultAnalyzer(csvDirectory, outputDirectory);
            analyzer.analyzeElectionResults();
            
        } catch (IOException e) {
            System.err.println("Error during analysis: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}