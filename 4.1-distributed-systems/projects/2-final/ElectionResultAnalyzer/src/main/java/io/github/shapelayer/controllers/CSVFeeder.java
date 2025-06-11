package io.github.shapelayer.controllers;

import java.util.*;
import java.util.regex.Pattern;
import io.github.shapelayer.models.*;

public class CSVFeeder {
  List<String> paths;
  ElectionResultAnalyzer analyzer = new ElectionResultAnalyzer();

  public CSVFeeder(List<String> paths) {
    this.paths = paths;
  }

  void feed(String regionName, FileIOCompatible fileIO) {
    for (String path : paths) {
      try {
        List<String[]> data = fileIO.readCSV(path);
        
        // Find most detailed region from header
        String detailedRegion = extractDetailedRegion(data);
        
        // Find party column indices
        Map<String, Integer> partyColumns = findPartyColumns(data);
        
        // Parse voting data and feed to analyzer
        parseAndFeedVotingData(data, partyColumns, detailedRegion);
        
      } catch (Exception e) {
        System.err.println("Error processing file: " + path + " - " + e.getMessage());
      }
    }
  }
  
  private String extractDetailedRegion(List<String[]> data) {
    // Look for region in brackets format like [국회의원선거][충청남도][천안시병][천안시동남구]
    for (String[] row : data) {
      for (String cell : row) {
        if (cell != null && cell.contains("[") && cell.contains("]")) {
          // Extract the most detailed region (last bracket)
          String[] regions = cell.split("\\]\\[");
          if (regions.length > 0) {
            String lastRegion = regions[regions.length - 1];
            return lastRegion.replace("[", "").replace("]", "");
          }
        }
      }
    }
    return "Unknown Region";
  }
  
  private Map<String, Integer> findPartyColumns(List<String[]> data) {
    Map<String, Integer> partyColumns = new HashMap<>();
    
    // Look for party names in header rows (typically containing party names with newlines)
    for (String[] row : data) {
      for (int i = 0; i < row.length; i++) {
        String cell = row[i];
        if (cell != null && cell.contains("\n") && isPartyName(cell)) {
          // Extract party name (first line before newline)
          String partyName = cell.split("\n")[0].trim();
          if (!partyName.isEmpty() && !partyName.equals("")) {
            partyColumns.put(partyName, i);
          }
        }
      }
    }
    
    return partyColumns;
  }
  
  private boolean isPartyName(String cell) {
    // Check if cell contains typical party name patterns
    return cell.contains("민주당") || cell.contains("통합당") || 
           cell.contains("정의당") || cell.contains("무소속") ||
           cell.contains("당") || cell.contains("정당");
  }
  
  private void parseAndFeedVotingData(List<String[]> data, Map<String, Integer> partyColumns, String region) {
    boolean inDataSection = false;
    
    for (String[] row : data) {
      // Skip header rows until we reach actual voting data
      if (row.length > 0 && row[0] != null) {
        String firstCell = row[0].trim();
        
        // Start processing data after header rows
        if (firstCell.equals("합계") || firstCell.contains("면") || firstCell.contains("동") || 
            firstCell.equals("거소·선상투표") || firstCell.equals("관외사전투표")) {
          inDataSection = true;
        }
        
        if (inDataSection && !firstCell.isEmpty() && !firstCell.equals("")) {
          parseAndAddVotingRow(row, partyColumns, region);
        }
      }
    }
  }
  
  private void parseAndAddVotingRow(String[] row, Map<String, Integer> partyColumns, String region) {
    try {
      String votingArea = row[0] != null ? row[0].trim() : "";
      String subArea = row.length > 1 && row[1] != null ? row[1].trim() : "";
      
      // Skip empty rows or header-like rows
      if (votingArea.isEmpty() || votingArea.equals("읍면동명")) {
        return;
      }
      
      // Parse vote counts for each party
      Map<String, Integer> partyVotes = new HashMap<>();
      for (Map.Entry<String, Integer> entry : partyColumns.entrySet()) {
        String partyName = entry.getKey();
        int columnIndex = entry.getValue();
        
        if (columnIndex < row.length && row[columnIndex] != null) {
          try {
            String voteStr = row[columnIndex].trim();
            if (!voteStr.isEmpty() && !voteStr.equals("0.0")) {
              // Parse as double first, then convert to int
              double votes = Double.parseDouble(voteStr);
              partyVotes.put(partyName, (int) votes);
            }
          } catch (NumberFormatException e) {
            // Skip invalid numbers
          }
        }
      }
      
      // Parse total votes if available (usually in column 3)
      int totalVotes = 0;
      if (row.length > 3 && row[3] != null) {
        try {
          double totalVotesDouble = Double.parseDouble(row[3].trim());
          totalVotes = (int) totalVotesDouble;
        } catch (NumberFormatException e) {
          // Skip if not a valid number
        }
      }
      
      // Feed data to analyzer using existing methods
      analyzer.addVotingData(region, votingArea, subArea, partyVotes, totalVotes);
      
    } catch (Exception e) {
      // Skip problematic rows
    }
  }
}
