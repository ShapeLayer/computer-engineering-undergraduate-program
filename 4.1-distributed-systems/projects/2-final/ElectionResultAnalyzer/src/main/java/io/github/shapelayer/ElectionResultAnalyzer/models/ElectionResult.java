package io.github.shapelayer.ElectionResultAnalyzer.models;

import java.util.HashMap;
import java.util.Map;

public class ElectionResult {
  private Map<Party, Long> votes = new HashMap<>();

  public void append(Party party, long votes) {
    if (this.votes.containsKey(party)) {
      this.votes.put(party, this.votes.get(party) + votes);
    } else {
      this.votes.put(party, votes);
    }
  }

  public long get(Party party) {
    return this.votes.getOrDefault(party, 0L);
  }

  public Map<Party, Long> toMap() {
    return votes;
  }

  public ElectionResult add(ElectionResult other) {
    ElectionResult result = new ElectionResult();
    for (Party party : Party.values()) {
      long totalVotes = this.get(party) + other.get(party);
      result.append(party, totalVotes);
    }
    return result;
  }

  public ElectionResult sub(ElectionResult other) {
    ElectionResult result = new ElectionResult();
    for (Party party : Party.values()) {
      long totalVotes = this.get(party) - other.get(party);
      result.append(party, totalVotes);
    }
    return result;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    for (Map.Entry<Party, Long> entry : votes.entrySet()) {
      sb.append(entry.getKey().name()).append(": ").append(entry.getValue()).append("\n");
    }
    return sb.toString();
  }
}
