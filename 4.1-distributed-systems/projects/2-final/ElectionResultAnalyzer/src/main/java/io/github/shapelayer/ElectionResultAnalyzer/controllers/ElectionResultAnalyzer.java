package io.github.shapelayer.ElectionResultAnalyzer.controllers;

import io.github.shapelayer.ElectionResultAnalyzer.commons.PartySupport;
import io.github.shapelayer.ElectionResultAnalyzer.models.ElectionRegion;
import io.github.shapelayer.ElectionResultAnalyzer.models.ElectionResult;
import io.github.shapelayer.ElectionResultAnalyzer.models.Party;
import io.github.shapelayer.ElectionResultAnalyzer.models.Struct8Values;

import java.util.Map;

public class ElectionResultAnalyzer {
  ElectionRegion electionRegion = new ElectionRegion();
  Map<String, Struct8Values> cached8Values = new java.util.HashMap<>();

  public void appendData(String region, Party party, int votes) {
    electionRegion.appendResult(region, party, votes);
  }

  public ElectionResult getResult(String region) {
    return electionRegion.get(region);
  }

  public Map<String, Struct8Values> getResultsAs8Values() {
    Map<String, ElectionResult> results = electionRegion.toMap();
    this.cached8Values.clear();

    for (Map.Entry<String, ElectionResult> entry : results.entrySet()) {
      String region = entry.getKey();
      ElectionResult electionResult = entry.getValue();
      Struct8Values s8vals = compute8Values(electionResult);
      this.cached8Values.put(region, s8vals);
    }

    return this.cached8Values;
  }

  public static Struct8Values compute8Values(ElectionResult electionResult) {
    Map<Party, Long> result = electionResult.toMap();
    Struct8Values s8vals = new Struct8Values();
    long total = 0;
    for (Long votes : result.values()) {
      total += votes;
    }

    for (Map.Entry<Party, Long> each : result.entrySet()) {
      Party party = each.getKey();
      long votes = each.getValue();
      Struct8Values partyValue = PartySupport.to8Values(party);
      s8vals.add(partyValue.mul((float) votes / total));
    }

    return s8vals;
  }

  @Override
  public String toString() {
    return electionRegion.toString();
  }
}
