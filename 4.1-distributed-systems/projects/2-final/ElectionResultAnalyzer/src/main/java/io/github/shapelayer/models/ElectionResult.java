package io.github.shapelayer.model;

import java.util.Map;

/**
 * Represents election results for a specific region
 */
public class ElectionResult {
    private String region;
    private String district;
    private Map<String, Long> partyVotes;
    private long totalVotes;
    private long invalidVotes;
    private long abstentionVotes;

    public ElectionResult(String region, String district, Map<String, Long> partyVotes, 
                         long totalVotes, long invalidVotes, long abstentionVotes) {
        this.region = region;
        this.district = district;
        this.partyVotes = partyVotes;
        this.totalVotes = totalVotes;
        this.invalidVotes = invalidVotes;
        this.abstentionVotes = abstentionVotes;
    }

    // Getters
    public String getRegion() { return region; }
    public String getDistrict() { return district; }
    public Map<String, Long> getPartyVotes() { return partyVotes; }
    public long getTotalVotes() { return totalVotes; }
    public long getInvalidVotes() { return invalidVotes; }
    public long getAbstentionVotes() { return abstentionVotes; }

    public long getVotesForParty(String party) {
        return partyVotes.getOrDefault(party, 0L);
    }

    @Override
    public String toString() {
        return String.format("ElectionResult{region='%s', district='%s', totalVotes=%d, partyVotes=%s}", 
                           region, district, totalVotes, partyVotes);
    }
}
