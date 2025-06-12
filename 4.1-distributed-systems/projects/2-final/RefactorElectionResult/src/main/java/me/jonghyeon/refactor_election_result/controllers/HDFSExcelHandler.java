package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.models.ExcelHandler;
import me.jonghyeon.refactor_election_result.models.VoteCounted;

import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.RemoteIterator;
import org.apache.hadoop.fs.LocatedFileStatus;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

public class HDFSExcelHandler extends ExcelHandler {
  public static List<List<VoteCounted>> parseAll(String[] targets, FileSystem fs) throws IOException {
    List<Path> targetPaths = new ArrayList<>();

    for (String target : targets) {
      Path currPath = new Path(target);

      if (!fs.exists(currPath)) {
        System.err.println("Target path does not exist in HDFS. Passed: " + target);
        continue;
      }
      
      FileStatus fileStatus = fs.getFileStatus(currPath);
      if (!fileStatus.isDirectory()) {
        targetPaths.add(currPath);
        continue;
      }

      RemoteIterator<LocatedFileStatus> fileIterator = fs.listFiles(currPath, true);
      while (fileIterator.hasNext()) {
        LocatedFileStatus eachFileStatus = fileIterator.next();
        if (!eachFileStatus.isDirectory() && eachFileStatus.getPath().getName().toLowerCase().endsWith(".xlsx")) {
          targetPaths.add(eachFileStatus.getPath());
        }
      }
    }

    List<List<VoteCounted>> results = new ArrayList<>();
    for (Path path : targetPaths) {
      System.out.println("Processing " + path);
      try (InputStream is = fs.open(path)) {
        results.add(parse(is));
      }
    }

    fs.close();
    return results;
  }
}
