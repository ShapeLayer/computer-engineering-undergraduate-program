package io.github.shapelayer.model;

/**
 * Aggregated election results for a party in a specific region
 */
public class PartyRegionResult {
    private String party;
    private String region;
    private long totalVotes;
    private int districtCount;

    public PartyRegionResult(String party, String region, long totalVotes, int districtCount) {
        this.party = party;
        this.region = region;
        this.totalVotes = totalVotes;
        this.districtCount = districtCount;
    }

    // Getters
    public String getParty() { return party; }
    public String getRegion() { return region; }
    public long getTotalVotes() { return totalVotes; }
    public int getDistrictCount() { return districtCount; }

    // Methods to add votes and districts
    public void addVotes(long votes) {
        this.totalVotes += votes;
    }

    public void incrementDistrictCount() {
        this.districtCount++;
    }

    @Override
    public String toString() {
        return String.format("%s,%s,%d,%d", party, region, totalVotes, districtCount);
    }

    public String toDetailedString() {
        return String.format("Party: %s, Region: %s, Total Votes: %,d, Districts: %d", 
                           party, region, totalVotes, districtCount);
    }
}
