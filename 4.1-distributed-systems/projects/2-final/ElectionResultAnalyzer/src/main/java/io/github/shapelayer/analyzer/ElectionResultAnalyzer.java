package io.github.shapelayer.analyzer;

import io.github.shapelayer.model.ElectionResult;
import io.github.shapelayer.model.PartyRegionResult;
import io.github.shapelayer.util.CSVElectionReader;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Main analyzer class for processing election results
 */
public class ElectionResultAnalyzer {
    
    // Define target parties to analyze
    private static final Set<String> TARGET_PARTIES = Set.of(
            "더불어시민당", "미래한국당", "정의당", "국민의당", 
            "민생당", "우리공화당", "한국경제당", "민중당"
    );
    
    private final String csvDirectory;
    private final String outputDirectory;
    
    public ElectionResultAnalyzer(String csvDirectory, String outputDirectory) {
        this.csvDirectory = csvDirectory;
        this.outputDirectory = outputDirectory;
    }
    
    /**
     * Main analysis method
     */
    public void analyzeElectionResults() throws IOException {
        System.out.println("Starting election result analysis...");
        
        // Step 1: Read all CSV files
        List<ElectionResult> allResults = readAllCSVFiles();
        System.out.printf("Read %d CSV files successfully.%n", allResults.size());
        
        // Step 2: Filter and process target parties
        Map<String, Map<String, PartyRegionResult>> partyRegionData = processTargetParties(allResults);
        System.out.printf("Processed data for %d target parties.%n", partyRegionData.size());
        
        // Step 3: Save results to file
        saveResults(partyRegionData);
        System.out.println("Analysis complete! Results saved to output files.");
    }
    
    /**
     * Reads all CSV files from the specified directory
     */
    private List<ElectionResult> readAllCSVFiles() throws IOException {
        Path csvPath = Paths.get(csvDirectory);
        
        if (!Files.exists(csvPath) || !Files.isDirectory(csvPath)) {
            throw new IOException("CSV directory not found: " + csvDirectory);
        }
        
        try (Stream<Path> paths = Files.walk(csvPath)) {
            return paths
                    .filter(Files::isRegularFile)
                    .filter(path -> path.toString().endsWith(".csv"))
                    .map(path -> {
                        try {
                            return CSVElectionReader.readElectionData(path.toString());
                        } catch (IOException e) {
                            System.err.println("Error reading file: " + path + " - " + e.getMessage());
                            return null;
                        }
                    })
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
        }
    }
    
    /**
     * Processes election results for target parties
     */
    private Map<String, Map<String, PartyRegionResult>> processTargetParties(List<ElectionResult> results) {
        Map<String, Map<String, PartyRegionResult>> partyRegionData = new HashMap<>();
        
        for (ElectionResult result : results) {
            for (Map.Entry<String, Long> partyEntry : result.getPartyVotes().entrySet()) {
                String party = partyEntry.getKey();
                Long votes = partyEntry.getValue();
                
                // Check if this party is in our target list
                if (TARGET_PARTIES.contains(party) && votes > 0) {
                    String region = result.getRegion();
                    
                    // Get or create party map
                    Map<String, PartyRegionResult> regionMap = partyRegionData.computeIfAbsent(
                            party, k -> new HashMap<>());
                    
                    // Get or create region result
                    PartyRegionResult regionResult = regionMap.computeIfAbsent(
                            region, k -> new PartyRegionResult(party, region, 0, 0));
                    
                    // Add votes and increment district count
                    regionResult.addVotes(votes);
                    regionResult.incrementDistrictCount();
                }
            }
        }
        
        return partyRegionData;
    }
    
    /**
     * Saves analysis results to files
     */
    private void saveResults(Map<String, Map<String, PartyRegionResult>> partyRegionData) throws IOException {
        // Create output directory if it doesn't exist
        Path outputPath = Paths.get(outputDirectory);
        Files.createDirectories(outputPath);
        
        // Save comprehensive results
        saveComprehensiveResults(partyRegionData, outputPath);
        
        // Save summary by party
        savePartySummary(partyRegionData, outputPath);
        
        // Save summary by region
        saveRegionSummary(partyRegionData, outputPath);
    }
    
    /**
     * Saves comprehensive results to a single file
     */
    private void saveComprehensiveResults(Map<String, Map<String, PartyRegionResult>> data, Path outputPath) 
            throws IOException {
        
        String fileName = outputPath.resolve("comprehensive_election_results.csv").toString();
        
        try (FileWriter writer = new FileWriter(fileName)) {
            // Write header
            writer.write("Party,Region,TotalVotes,DistrictCount\n");
            
            // Sort parties alphabetically and write data
            data.entrySet().stream()
                    .sorted(Map.Entry.comparingByKey())
                    .forEach(partyEntry -> {
                        String party = partyEntry.getKey();
                        Map<String, PartyRegionResult> regionMap = partyEntry.getValue();
                        
                        // Sort regions by total votes (descending)
                        regionMap.values().stream()
                                .sorted((a, b) -> Long.compare(b.getTotalVotes(), a.getTotalVotes()))
                                .forEach(result -> {
                                    try {
                                        writer.write(result.toString() + "\n");
                                    } catch (IOException e) {
                                        throw new RuntimeException(e);
                                    }
                                });
                    });
        }
        
        System.out.println("Comprehensive results saved to: " + fileName);
    }
    
    /**
     * Saves party summary (total votes per party across all regions)
     */
    private void savePartySummary(Map<String, Map<String, PartyRegionResult>> data, Path outputPath) 
            throws IOException {
        
        String fileName = outputPath.resolve("party_summary.csv").toString();
        
        try (FileWriter writer = new FileWriter(fileName)) {
            writer.write("Party,TotalVotes,TotalDistricts,RegionCount\n");
            
            data.entrySet().stream()
                    .sorted(Map.Entry.comparingByKey())
                    .forEach(partyEntry -> {
                        String party = partyEntry.getKey();
                        Map<String, PartyRegionResult> regionMap = partyEntry.getValue();
                        
                        long totalVotes = regionMap.values().stream()
                                .mapToLong(PartyRegionResult::getTotalVotes)
                                .sum();
                        
                        int totalDistricts = regionMap.values().stream()
                                .mapToInt(PartyRegionResult::getDistrictCount)
                                .sum();
                        
                        int regionCount = regionMap.size();
                        
                        try {
                            writer.write(String.format("%s,%d,%d,%d\n", 
                                    party, totalVotes, totalDistricts, regionCount));
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                    });
        }
        
        System.out.println("Party summary saved to: " + fileName);
    }
    
    /**
     * Saves region summary (total votes per region across all parties)
     */
    private void saveRegionSummary(Map<String, Map<String, PartyRegionResult>> data, Path outputPath) 
            throws IOException {
        
        String fileName = outputPath.resolve("region_summary.csv").toString();
        
        // Aggregate by region
        Map<String, Long> regionTotals = new HashMap<>();
        Map<String, Integer> regionPartyCounts = new HashMap<>();
        
        data.values().forEach(regionMap -> 
            regionMap.values().forEach(result -> {
                String region = result.getRegion();
                regionTotals.merge(region, result.getTotalVotes(), Long::sum);
                regionPartyCounts.merge(region, 1, Integer::sum);
            })
        );
        
        try (FileWriter writer = new FileWriter(fileName)) {
            writer.write("Region,TotalVotes,PartyCount\n");
            
            regionTotals.entrySet().stream()
                    .sorted((a, b) -> Long.compare(b.getValue(), a.getValue()))
                    .forEach(entry -> {
                        String region = entry.getKey();
                        long totalVotes = entry.getValue();
                        int partyCount = regionPartyCounts.get(region);
                        
                        try {
                            writer.write(String.format("%s,%d,%d\n", region, totalVotes, partyCount));
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                    });
        }
        
        System.out.println("Region summary saved to: " + fileName);
    }
}
