package me.jonghyeon.refactor_election_result.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import me.jonghyeon.refactor_election_result.models.VoteCounted;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.Path2D;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.List;

public class ElectionMapVisualizer extends JPanel {
  private Map<String, List<VoteCounted>> electionData;
  private Map<String, Color> regionColors;
  private List<Path2D> geoShapes;
  private Map<String, String> regionNames;

  public ElectionMapVisualizer() {
    this.electionData = new HashMap<>();
    this.regionColors = new HashMap<>();
    this.geoShapes = new ArrayList<>();
    this.regionNames = new HashMap<>();
    setPreferredSize(new Dimension(1000, 800));
  }

  public void loadGeoData(String geoJsonPath) throws IOException {
    ObjectMapper mapper = new ObjectMapper();
    JsonNode root = mapper.readTree(new File(geoJsonPath));

    JsonNode features = root.get("features");
    if (features != null && features.isArray()) {
      for (JsonNode feature : features) {
        processFeature(feature);
      }
    }
  }

  private void processFeature(JsonNode feature) {
    JsonNode properties = feature.get("properties");
    JsonNode geometry = feature.get("geometry");

    if (properties != null && geometry != null) {
      String regionName = properties.get("name").asText();
      JsonNode coordinates = geometry.get("coordinates");

      Path2D shape = createShapeFromCoordinates(coordinates);
      if (shape != null) {
        geoShapes.add(shape);
        regionNames.put(String.valueOf(geoShapes.size() - 1), regionName);
      }
    }
  }

  private Path2D createShapeFromCoordinates(JsonNode coordinates) {
    Path2D path = new Path2D.Double();

    if (coordinates.isArray() && coordinates.size() > 0) {
      JsonNode firstRing = coordinates.get(0);
      if (firstRing.isArray()) {
        boolean first = true;
        for (JsonNode coord : firstRing) {
          if (coord.isArray() && coord.size() >= 2) {
            double x = coord.get(0).asDouble();
            double y = coord.get(1).asDouble();

            // Convert longitude/latitude to screen coordinates
            x = (x + 180) * getWidth() / 360;
            y = (90 - y) * getHeight() / 180;

            if (first) {
              path.moveTo(x, y);
              first = false;
            } else {
              path.lineTo(x, y);
            }
          }
        }
        path.closePath();
      }
    }

    return path;
  }

  public void setElectionData(Map<String, List<VoteCounted>> data) {
    this.electionData = data;
    calculateRegionColors();
    repaint();
  }

  private void calculateRegionColors() {
    regionColors.clear();

    // Find max votes for color scaling
    long maxVotes = electionData.values().stream()
        .flatMap(List::stream)
        .mapToLong(VoteCounted::getCount)
        .max()
        .orElse(1);

    for (Map.Entry<String, List<VoteCounted>> entry : electionData.entrySet()) {
      String region = entry.getKey();
      long totalVotes = entry.getValue().stream()
          .mapToLong(VoteCounted::getCount)
          .sum();

      float intensity = (float) totalVotes / maxVotes;
      Color color = new Color(intensity, 0.2f, 0.2f, 0.7f);
      regionColors.put(region, color);
    }
  }

  @Override
  protected void paintComponent(Graphics g) {
    super.paintComponent(g);
    Graphics2D g2d = (Graphics2D) g;
    g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

    // Draw map regions
    for (int i = 0; i < geoShapes.size(); i++) {
      Path2D shape = geoShapes.get(i);
      String regionKey = String.valueOf(i);
      String regionName = regionNames.get(regionKey);

      Color fillColor = regionColors.getOrDefault(regionName, Color.LIGHT_GRAY);
      g2d.setColor(fillColor);
      g2d.fill(shape);

      g2d.setColor(Color.BLACK);
      g2d.setStroke(new BasicStroke(0.5f));
      g2d.draw(shape);
    }

    drawLegend(g2d);
  }

  private void drawLegend(Graphics2D g2d) {
    int legendX = getWidth() - 200;
    int legendY = 50;

    g2d.setColor(Color.WHITE);
    g2d.fillRect(legendX - 10, legendY - 10, 180, 100);
    g2d.setColor(Color.BLACK);
    g2d.drawRect(legendX - 10, legendY - 10, 180, 100);

    g2d.drawString("Vote Intensity", legendX, legendY);

    // Draw color gradient
    for (int i = 0; i < 50; i++) {
      float intensity = i / 50f;
      Color color = new Color(intensity, 0.2f, 0.2f, 0.7f);
      g2d.setColor(color);
      g2d.fillRect(legendX + i * 2, legendY + 10, 2, 20);
    }

    g2d.setColor(Color.BLACK);
    g2d.drawString("Low", legendX, legendY + 45);
    g2d.drawString("High", legendX + 80, legendY + 45);
  }
}
