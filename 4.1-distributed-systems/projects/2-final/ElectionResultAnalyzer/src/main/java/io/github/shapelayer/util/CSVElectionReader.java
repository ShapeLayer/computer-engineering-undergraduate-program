package io.github.shapelayer.util;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;
import io.github.shapelayer.model.ElectionResult;

import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.IntStream;

/**
 * Utility class for reading and parsing CSV files containing election results
 */
public class CSVElectionReader {
    
    /**
     * Reads election results from a CSV file
     * @param filePath Path to the CSV file
     * @return ElectionResult object containing parsed data
     * @throws IOException if file reading fails
     */
    public static ElectionResult readElectionData(String filePath) throws IOException {
        try (CSVReader reader = new CSVReader(new FileReader(filePath, StandardCharsets.UTF_8))) {
            List<String[]> allData = reader.readAll();
            
            if (allData.size() < 6) {
                throw new IllegalArgumentException("Invalid CSV format: insufficient rows");
            }

            // Extract region and district information from the file path
            String fileName = filePath.substring(filePath.lastIndexOf('/') + 1);
            String[] parts = fileName.split("_");
            String region = parts.length > 1 ? parts[1] : "Unknown";
            String district = extractDistrict(allData);

            // Find the header row with party names (row 4, index 3)
            String[] partyHeaders = allData.get(4);
            
            // Find the data row with totals (row 5, index 5)
            String[] totalRow = allData.get(5);
            
            // Parse party votes
            Map<String, Long> partyVotes = parsePartyVotes(partyHeaders, totalRow);
            
            // Extract summary statistics
            long totalVotes = parseLong(totalRow[totalRow.length - 3]); // Total votes column
            long invalidVotes = parseLong(totalRow[totalRow.length - 2]); // Invalid votes
            long abstentionVotes = parseLong(totalRow[totalRow.length - 1]); // Abstention
            
            return new ElectionResult(region, district, partyVotes, totalVotes, invalidVotes, abstentionVotes);
            
        } catch (CsvException e) {
            throw new IOException("Error parsing CSV file: " + filePath, e);
        }
    }

    /**
     * Extracts district information from CSV data
     */
    private static String extractDistrict(List<String[]> allData) {
        if (allData.size() > 2) {
            String titleRow = allData.get(2)[0];
            if (titleRow != null && titleRow.contains("][")) {
                String[] parts = titleRow.split("\\]\\[");
                if (parts.length >= 3) {
                    return parts[2].replace("]", "");
                }
            }
        }
        return "Unknown";
    }

    /**
     * Parses party votes from header and data rows
     */
    private static Map<String, Long> parsePartyVotes(String[] headers, String[] dataRow) {
        Map<String, Long> partyVotes = new HashMap<>();
        
        // Start from index 4 (after basic info columns) and skip last 3 columns (totals)
        int startIndex = 4;
        int endIndex = Math.min(headers.length, dataRow.length) - 3;
        
        for (int i = startIndex; i < endIndex; i++) {
            if (i < headers.length && i < dataRow.length) {
                String party = headers[i];
                String voteStr = dataRow[i];
                
                if (party != null && !party.trim().isEmpty() && 
                    voteStr != null && !voteStr.trim().isEmpty()) {
                    
                    long votes = parseLong(voteStr);
                    if (votes > 0) {
                        partyVotes.put(party.trim(), votes);
                    }
                }
            }
        }
        
        return partyVotes;
    }

    /**
     * Safely parses a string to long, returning 0 if parsing fails
     */
    private static long parseLong(String value) {
        if (value == null || value.trim().isEmpty()) {
            return 0;
        }
        
        try {
            // Remove any decimal points and parse as long
            String cleanValue = value.trim().replace(".0", "");
            return Long.parseLong(cleanValue);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
