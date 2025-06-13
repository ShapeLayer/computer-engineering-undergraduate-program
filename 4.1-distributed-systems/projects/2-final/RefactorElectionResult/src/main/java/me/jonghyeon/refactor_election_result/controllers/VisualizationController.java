package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.models.VoteCounted;

import javax.swing.*;
import java.awt.*;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class VisualizationController {
  private Map<String, List<VoteCounted>> electionData;

  public VisualizationController(List<List<VoteCounted>> parsedData) {
    // Group data by region
    this.electionData = parsedData.stream()
        .flatMap(List::stream)
        .collect(Collectors.groupingBy(VoteCounted::getRegionName));
  }

  public void showVisualization() {
    SwingUtilities.invokeLater(() -> {
      JFrame frame = new JFrame("Election Results Visualization");
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      frame.setLayout(new BorderLayout());

      // Create tabbed pane for different visualizations
      JTabbedPane tabbedPane = new JTabbedPane();

      // Add map visualization
      try {
        ElectionMapVisualizer mapViz = new ElectionMapVisualizer();
        mapViz.loadGeoData("southkorea-maps/popong/precinct/assembly-precinct-20-geo.json");
        mapViz.setElectionData(electionData);
        tabbedPane.addTab("Map View", new JScrollPane(mapViz));
      } catch (Exception e) {
        System.err.println("Could not load map visualization: " + e.getMessage());
      }

      // Add chart visualizations
      tabbedPane.addTab("Party Results",
          ElectionChartVisualizer.createBarChart(electionData, "Election Results by Party"));

      tabbedPane.addTab("Vote Distribution",
          ElectionChartVisualizer.createPieChart(electionData, "Vote Share by Party"));

      tabbedPane.addTab("Regional Comparison",
          ElectionChartVisualizer.createRegionalComparisonChart(electionData));

      frame.add(tabbedPane, BorderLayout.CENTER);
      frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
      frame.setVisible(true);
    });
  }
}
