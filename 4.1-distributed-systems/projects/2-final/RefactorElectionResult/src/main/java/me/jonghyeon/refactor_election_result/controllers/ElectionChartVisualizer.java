package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.models.VoteCounted;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import javax.swing.*;
import java.awt.*;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ElectionChartVisualizer {

  public static JPanel createBarChart(Map<String, List<VoteCounted>> electionData, String title) {
    DefaultCategoryDataset dataset = new DefaultCategoryDataset();

    // Aggregate data by party
    Map<String, Long> partyVotes = electionData.values().stream()
        .flatMap(List::stream)
        .collect(Collectors.groupingBy(
            VoteCounted::getCandidate,
            Collectors.summingLong(VoteCounted::getCount)
        ));

    partyVotes.forEach((party, votes) ->
        dataset.addValue(votes, "Votes", party));

    JFreeChart chart = ChartFactory.createBarChart(
        title,
        "Political Party",
        "Vote Count",
        dataset,
        PlotOrientation.VERTICAL,
        true, true, false
    );

    return new ChartPanel(chart);
  }

  public static JPanel createPieChart(Map<String, List<VoteCounted>> electionData, String title) {
    DefaultPieDataset<String> dataset = new DefaultPieDataset<>();

    Map<String, Long> partyVotes = electionData.values().stream()
        .flatMap(List::stream)
        .collect(Collectors.groupingBy(
            VoteCounted::getCandidate,
            Collectors.summingLong(VoteCounted::getCount)
        ));

    partyVotes.forEach(dataset::setValue);

    JFreeChart chart = ChartFactory.createPieChart(
        title,
        dataset,
        true, true, false
    );

    return new ChartPanel(chart);
  }

  public static JPanel createRegionalComparisonChart(Map<String, List<VoteCounted>> electionData) {
    DefaultCategoryDataset dataset = new DefaultCategoryDataset();

    electionData.forEach((region, votes) -> {
      long totalVotes = votes.stream()
          .mapToLong(VoteCounted::getCount)
          .sum();
      dataset.addValue(totalVotes, "Total Votes", region);
    });

    JFreeChart chart = ChartFactory.createBarChart(
        "Votes by Region",
        "Region",
        "Vote Count",
        dataset,
        PlotOrientation.VERTICAL,
        true, true, false
    );

    return new ChartPanel(chart);
  }
}
