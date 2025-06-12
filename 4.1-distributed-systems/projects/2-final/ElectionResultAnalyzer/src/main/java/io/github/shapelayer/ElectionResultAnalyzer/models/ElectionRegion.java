package io.github.shapelayer.ElectionResultAnalyzer.models;

import java.util.HashMap;
import java.util.Map;

public class ElectionRegion {
  // Region, <Party, Votes>
  public Map<String, ElectionResult> results = new HashMap<>();

  public void appendResult(String region, Party party, long votes) {
    results.putIfAbsent(region, new ElectionResult());
    
    ElectionResult electionResult = results.get(region);
    electionResult.append(party, votes);
  }

  public ElectionResult get(String region) {
    return results.getOrDefault(region, new ElectionResult());
  }

  public Map<String, ElectionResult> toMap() {
    return results;
  }

  public ElectionRegion add(ElectionRegion other) {
    ElectionRegion result = new ElectionRegion();
    for (String region : results.keySet()) {
      ElectionResult combinedResult = this.get(region).add(other.get(region));
      result.results.put(region, combinedResult);
    }
    return result;
  }

  public ElectionRegion sub(ElectionRegion other) {
    ElectionRegion result = new ElectionRegion();
    for (String region : results.keySet()) {
      ElectionResult combinedResult = this.get(region).sub(other.get(region));
      result.results.put(region, combinedResult);
    }
    return result;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    for (Map.Entry<String, ElectionResult> entry : results.entrySet()) {
      sb.append(entry.getKey()).append(": ").append(entry.getValue().toString()).append("\n");
    }
    return sb.toString();
  }
}
