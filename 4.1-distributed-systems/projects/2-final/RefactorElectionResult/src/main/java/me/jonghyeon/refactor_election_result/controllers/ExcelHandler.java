package me.jonghyeon.refactor_election_result.models;

import me.jonghyeon.refactor_election_result.commons.PartySupports;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class ExcelHandler {
  public static List<VoteCounted> parse(InputStream is) throws IOException {
    List<VoteCounted> votesCounted = new ArrayList<>();
    Party[] parties = PartySupports.parties;
    try (Workbook workbook = new XSSFWorkbook(is)) {
        // A single sheet is expected.
        Sheet sheet = workbook.getSheetAt(0);
        StringBuilder sb = new StringBuilder();

        int currRow = 0;
        int currCol = 0;

        boolean regionFound = false;
        String[] region = {};

        PartyFounds partyFound = PartyFounds.NotFound;
        Map<Integer, Party> indexPartyMatched = new HashMap<>();

        for (Row row : sheet) {
          for (Cell cell : row) {
            String now = cell.toString();
            if (!regionFound) {
              // has region data
              if (now.contains("[")) {
                region = now
                    .replace("[", "")
                    .split("]");
                regionFound = true;
              }
            }

            if (partyFound != PartyFounds.Done) {
              boolean partyContains = false;
              for (Party party : parties) {
                String name = PartySupports.toString(party);
                if (now.contains(name)) {
                  partyContains = true;
                  indexPartyMatched.put(currCol, party);
                  break;
                }
              }
              if (partyContains) {
                partyFound = PartyFounds.Finding;
              } else {
                if (partyFound == PartyFounds.Finding) {
                  partyFound = PartyFounds.Done;
                }
              }
            }

            if (partyFound == PartyFounds.Done) {
              if (indexPartyMatched.containsKey(currCol)) {
                Party party = indexPartyMatched.get(currCol);
                if (cell.getCellType() != CellType.NUMERIC) { continue; }

                VoteCounted voteCounted = new VoteCounted(
                    region[0],
                    region[1],
                    region.length >= 3 ? (region.length >= 4 ? region[3] : region[2]) : region[1],
                    region.length >= 3 ? region[2] : region[1],
                    PartySupports.toString(party),
                    (long) cell.getNumericCellValue()
                );

                votesCounted.add(voteCounted);
              }
            }

            // finalize
            currCol++;
          }

          // finalize
          currRow++;
          currCol = 0;
        }
    }
    return votesCounted;
  }
}
