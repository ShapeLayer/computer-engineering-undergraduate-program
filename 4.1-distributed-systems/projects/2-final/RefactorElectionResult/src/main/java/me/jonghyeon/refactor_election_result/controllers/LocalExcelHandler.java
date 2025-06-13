package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.models.VoteCounted;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Stream;

public class LocalExcelHandler extends ExcelHandler {
  public static List<List<VoteCounted>> parseAll(String[] targets) throws IOException {
    List<Path> targetPaths = new ArrayList<>();

    for (String target : targets) {
      Path currPath = Paths.get(target);

      if (!Files.exists(currPath)) {
        System.err.println("Target path does not exist. Passed: " + target);
      }
      
      if (!Files.isDirectory(currPath)) {
        targetPaths.add(currPath);
        continue;
      }

      try (Stream<Path> ps = Files.walk(currPath)) {
        ps
            .filter(path -> !Files.isDirectory(path) && path.toString().toLowerCase().endsWith(".xlsx"))
            .forEach(xlsxPath -> {
              targetPaths.add(xlsxPath);
            });
      }
    }

    List<List<VoteCounted>> results = new ArrayList<>();
    for (Path path : targetPaths) {
      System.out.println("Processing " + path);
      try (InputStream is = Files.newInputStream(path)) {
        results.add(parse(is));
      }
    }

    return results;
  }
}
