package io.github.shapelayer.ElectionResultAnalyzer.controllers;

import java.io.IOException;
import java.util.*;
import java.util.Map.Entry;

import io.github.shapelayer.ElectionResultAnalyzer.commons.Defaults;
import io.github.shapelayer.ElectionResultAnalyzer.commons.PartySupport;
import io.github.shapelayer.ElectionResultAnalyzer.models.FileIOCompatible;
import io.github.shapelayer.ElectionResultAnalyzer.models.Party;


public class CSVFeeder {
  String[] paths;
  ElectionResultAnalyzer analyzer;

  public CSVFeeder(String[] paths, ElectionResultAnalyzer analyzer) {
    this.paths = paths;
    this.analyzer = analyzer;
  }

  public void feed(FileIOCompatible fileIO) {
    for (String path : paths) {
      try {
        System.out.println("Processing file: " + path + " ... ");
        List<String[]> data = fileIO.readCSV(path);
        
        if (data == null || data.isEmpty()) {
          System.out.println("No data found in file: " + path);
          continue;
        }

        parse(data);
        
      } catch (Exception e) {
        System.err.println("Error processing file: " + path + " - " + e.getMessage());
      }
    }
  }

  void parse(List<String[]> data) {
    String region = Defaults.REGION_UNKNOWN_PLACEHOLDER;
    boolean regionFound = false;
    Map<Integer, Party> indexPartyMap = new HashMap<>();
    boolean partyRowFound = false;
    for (int i = 0; i < data.size(); i++) {
      String[] row = data.get(i);
      for (int j = 0; j < row.length; j++) {
        String cell = row[j];
        if (cell == null || cell.isEmpty()) { continue; }

        // Region
        if (!regionFound) {
          if (cell.contains("[")) {
            String[] electionInfo = cell.replace("[", " ").replace("]", " ").split(" ");
            if (electionInfo.length < 3) {
              region = String.join(" ", electionInfo);
            } else {
              region = String.join(" ", Arrays.copyOfRange(electionInfo, 1, electionInfo.length));
            }
            regionFound = true;
          }
        }

        // Party names - indices match
        if (!partyRowFound) {
          for (String partyName : PartySupport.partyEnumToString.values()) {
            if (cell.contains(partyName)) {
              partyRowFound = true;
              break;
            }
          }
        }

        if (!partyRowFound) { continue; }
        else { break; }
      }

      for (int j = 0; j < row.length; j++) {
        String cell = row[j];
        for (Entry<Party, String> entry : PartySupport.partyEnumToString.entrySet()) {
          Party party = entry.getKey();
          String partyName = entry.getValue();
          if (cell.contains(partyName)) {
            indexPartyMap.put(j, party);
          }
        }
      }

      // Voting data
      for (int j : indexPartyMap.keySet()) {
        if (j < row.length && row[j] != null && !row[j].isEmpty()) {
          try {
            int votes = (int) Double.parseDouble(row[j].trim());
            Party party = indexPartyMap.get(j);
            
            if (party != null) {
              analyzer.appendData(region, party, votes);
            }
          } catch (NumberFormatException e) { continue; }
        }
      }
    }
  }
}
