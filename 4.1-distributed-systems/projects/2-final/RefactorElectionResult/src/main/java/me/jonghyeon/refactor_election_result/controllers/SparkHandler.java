package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.Main;
import me.jonghyeon.refactor_election_result.commons.Defaults;
import me.jonghyeon.refactor_election_result.commons.PartySupports;
import me.jonghyeon.refactor_election_result.models.Party;
import me.jonghyeon.refactor_election_result.models.VoteCounted;
import me.jonghyeon.refactor_election_result.models.Values8;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

public class SparkHandler {
  SparkSession spark;

  public SparkHandler() {
    this.spark = SparkSession
        .builder()
        .appName(Defaults.DEFAULT_SPARK_APPNAME)
        .master(Defaults.DEFAULT_SPARK_MASTER)
        .getOrCreate();
  }

  public Map<String, Map<String, Map<String, Values8>>> proc(
    List<List<VoteCounted>> parsed
  ) {
    Map<Party, Values8> partyValues = PartySupports.partyEnumTo8Values;

    // Flatten the nested list structure
    List<VoteCounted> flattenedData = new ArrayList<>();
    for (List<VoteCounted> votesCountedList : parsed) {
      flattenedData.addAll(votesCountedList);
    }

    // Create RDD from the data
    JavaSparkContext sc = new JavaSparkContext(spark.sparkContext());
    JavaRDD<VoteCounted> voteRDD = sc.parallelize(flattenedData);

    // Convert to DataFrame
    Dataset<Row> voteDF = createVoteRDDDataFrame(voteRDD);

    System.out.println("=== Processing Values8 Calculation by Region (Area/City/Ward) ===");
    
    // Calculate total votes per region (Area, City, Ward)
    Dataset<Row> regionTotals = voteDF
            .groupBy("regionArea", "regionCity", "regionWard")
            .agg(org.apache.spark.sql.functions.sum("count").alias("totalVotes"));

    // Calculate votes per party per region with percentages
    Dataset<Row> partyRegionVotes = voteDF
            .groupBy("regionArea", "regionCity", "regionWard", "candidate")
            .agg(org.apache.spark.sql.functions.sum("count").alias("partyVotes"));

    // Join to get percentages
    Dataset<Row> partyRegionPercentages = partyRegionVotes
            .join(regionTotals, new String[]{"regionArea", "regionCity", "regionWard"})
            .withColumn("percentage", 
                org.apache.spark.sql.functions.col("partyVotes")
                    .divide(org.apache.spark.sql.functions.col("totalVotes")));

    System.out.println("Party votes by region with percentages:");
    partyRegionPercentages.show();

    // Collect results for calculation
    List<Row> results = partyRegionPercentages.collectAsList();
    
    // Initialize weighted sum Values8 by region hierarchy: Area -> City -> Ward -> Values8
    Map<String, Map<String, Map<String, Values8>>> regionResults = new java.util.HashMap<>();
    
    // Calculate sum(v_i * r_i) for each party and region
    for (Row row : results) {
      String regionArea = row.getString(0);
      String regionCity = row.getString(1);
      String regionWard = row.getString(2);
      String candidate = row.getString(3);
      long partyVotes = row.getLong(4);
      long totalVotes = row.getLong(5);
      double percentage = row.getDouble(6);
      
      // Initialize region hierarchy if not exists
      if (!regionResults.containsKey(regionArea)) {
        regionResults.put(regionArea, new java.util.HashMap<>());
      }
      if (!regionResults.get(regionArea).containsKey(regionCity)) {
        regionResults.get(regionArea).put(regionCity, new java.util.HashMap<>());
      }
      if (!regionResults.get(regionArea).get(regionCity).containsKey(regionWard)) {
        regionResults.get(regionArea).get(regionCity).put(regionWard, new Values8(0, 0, 0, 0));
      }
      
      // Find matching party by name
      Party matchingParty = null;
      for (Party party : partyValues.keySet()) {
        if (PartySupports.toString(party).equals(candidate)) {
          matchingParty = party;
          break;
        }
      }
      
      if (matchingParty != null) {
        Values8 partyValue = partyValues.get(matchingParty);
        
        // Calculate v_i * r_i for this party-region combination
        Values8 weightedValue = partyValue.mul((float) percentage);
        Values8 currentWardSum = regionResults.get(regionArea).get(regionCity).get(regionWard);
        regionResults.get(regionArea).get(regionCity).put(regionWard, currentWardSum.add(weightedValue));
        
        System.out.printf("Area: %s, City: %s, Ward: %s, Party: %s, Percentage: %.4f, Values8: %s, Weighted: %s%n",
            regionArea, regionCity, regionWard, candidate, percentage, partyValue.toString(), weightedValue.toString());
      }
    }
    
    sc.close();
    
    System.out.println("=== Final Weighted Sum (sum(v_i * r_i)) by Region Hierarchy ===");
    for (Map.Entry<String, Map<String, Map<String, Values8>>> areaEntry : regionResults.entrySet()) {
      System.out.println("Area: " + areaEntry.getKey());
      for (Map.Entry<String, Map<String, Values8>> cityEntry : areaEntry.getValue().entrySet()) {
        System.out.println("  City: " + cityEntry.getKey());
        for (Map.Entry<String, Values8> wardEntry : cityEntry.getValue().entrySet()) {
          System.out.println("    Ward: " + wardEntry.getKey() + " -> " + wardEntry.getValue().toString());
        }
      }
    }
    
    return regionResults;
  }

  public void processVoteCountedData(List<List<VoteCounted>> parsed, String outputPath, boolean useHadoop) {
    // Flatten the nested list structure
    List<VoteCounted> flattenedData = new ArrayList<>();
    for (List<VoteCounted> votesCountedList : parsed) {
      flattenedData.addAll(votesCountedList);
    }

    // Create RDD from the data
    JavaSparkContext sc = new JavaSparkContext(spark.sparkContext());
    JavaRDD<VoteCounted> voteRDD = sc.parallelize(flattenedData);

    // Convert to DataFrame for easier processing
    Dataset<Row> voteDF = createVoteRDDDataFrame(voteRDD);

    // Show some statistics
    System.out.println("=== Spark Processing Statistics ===");
    System.out.println("Total records: " + voteDF.count());
    
    // Group by candidate and sum votes
    Dataset<Row> candidateSummary = voteDF
            .groupBy("candidate")
            .sum("count")
            .orderBy(org.apache.spark.sql.functions.desc("sum(count)"));
    
    System.out.println("Top candidates by total votes:");
    candidateSummary.show(10);

    // Group by region area and sum votes
    Dataset<Row> regionSummary = voteDF
            .groupBy("regionArea")
            .sum("count")
            .orderBy(org.apache.spark.sql.functions.desc("sum(count)"));
    
    System.out.println("Top regions by total votes:");
    regionSummary.show(10);

    // Save the processed data
    String finalOutputPath = outputPath;
    if (useHadoop) {
        // For HDFS, save as CSV with headers
        voteDF.coalesce(1)
                .write()
                .mode("overwrite")
                .option("header", "true")
                .csv(finalOutputPath + "_spark_processed");
    } else {
        // For local files, save as CSV with headers
        voteDF.coalesce(1)
                .write()
                .mode("overwrite")
                .option("header", "true")
                .csv(finalOutputPath + "_spark_processed");
    }

    sc.close();
    System.out.println("Spark processed data saved to: " + finalOutputPath + "_spark_processed");
  }

  public void processAndSaveData(Object data, String outputPath, boolean useHadoop, String dataType) {
    if ("VoteCounted".equals(dataType)) {
      processVoteCountedData((List<List<VoteCounted>>) data, outputPath, useHadoop);
      return;
    }

    // Handle values8 table creation
    JavaSparkContext sc = new JavaSparkContext(spark.sparkContext());
    
    if ("values8".equals(dataType)) {
      createValues8Table(data, outputPath, useHadoop, sc);
    }
    
    sc.close();
  }

  private void createValues8Table(Object data, String outputPath, boolean useHadoop, JavaSparkContext sc) {
    System.out.println("=== Creating Values8 Table ===");
    
    // Create Values8 schema based on the class structure
    StructType values8Schema = new StructType(new StructField[]{
      DataTypes.createStructField("economic", DataTypes.FloatType, false),
      DataTypes.createStructField("diplomatic", DataTypes.FloatType, false),
      DataTypes.createStructField("civil", DataTypes.FloatType, false),
      DataTypes.createStructField("society", DataTypes.FloatType, false)
    });

    // Create sample Values8 data or process provided data
    List<Values8> values8List;
    if (data instanceof List) {
      values8List = (List<Values8>) data;
    } else {
      // Create sample data if no data provided
      values8List = new ArrayList<>();
      values8List.add(new Values8(75.5f, -25.3f, 60.2f, -40.1f));
      values8List.add(new Values8(-30.7f, 45.8f, -20.5f, 35.9f));
      values8List.add(new Values8(15.2f, -60.4f, 80.1f, -15.7f));
      values8List.add(new Values8(-50.3f, 20.6f, -35.8f, 70.4f));
    }
    
    // Convert Values8 objects to Rows
    JavaRDD<Values8> values8RDD = sc.parallelize(values8List);
    JavaRDD<Row> rowRDD = values8RDD.map(v8 -> 
      org.apache.spark.sql.RowFactory.create(
        v8.economic,
        v8.diplomatic,
        v8.civil,
        v8.society
      )
    );
    
    Dataset<Row> values8DF = spark.createDataFrame(rowRDD, values8Schema);
    
    System.out.println("Values8 table created with " + values8DF.count() + " records");
    
    // Show statistics
    System.out.println("Values8 Statistics:");
    values8DF.describe().show();
    
    // Show average values
    Dataset<Row> avgValues = values8DF.select(
      org.apache.spark.sql.functions.avg("economic").alias("avg_economic"),
      org.apache.spark.sql.functions.avg("diplomatic").alias("avg_diplomatic"),
      org.apache.spark.sql.functions.avg("civil").alias("avg_civil"),
      org.apache.spark.sql.functions.avg("society").alias("avg_society")
    );
    
    System.out.println("Average Values8:");
    avgValues.show();
    
    values8DF.show();
    
    // Save values8 table
    String values8OutputPath = outputPath + "_values8";
    if (useHadoop) {
      values8DF.coalesce(1)
              .write()
              .mode("overwrite")
              .option("header", "true")
              .csv(values8OutputPath);
    } else {
      values8DF.coalesce(1)
              .write()
              .mode("overwrite")
              .option("header", "true")
              .csv(values8OutputPath);
    }
    
    System.out.println("Values8 table saved to: " + values8OutputPath);
  }

  private Dataset<Row> createValues8RDDDataFrame(JavaRDD<Values8> values8RDD) {
    StructType schema = new StructType(new StructField[]{
      DataTypes.createStructField("economic", DataTypes.FloatType, false),
      DataTypes.createStructField("diplomatic", DataTypes.FloatType, false),
      DataTypes.createStructField("civil", DataTypes.FloatType, false),
      DataTypes.createStructField("society", DataTypes.FloatType, false)
    });

    JavaRDD<Row> rowRDD = values8RDD.map(v8 -> 
      org.apache.spark.sql.RowFactory.create(
        v8.economic,
        v8.diplomatic,
        v8.civil,
        v8.society
      )
    );

    return spark.createDataFrame(rowRDD, schema);
  }

  private Dataset<Row> createVoteRDDDataFrame(JavaRDD<VoteCounted> voteRDD) {
    StructType schema = new StructType(new StructField[]{
      DataTypes.createStructField("voteType", DataTypes.StringType, false),
      DataTypes.createStructField("regionArea", DataTypes.StringType, false),
      DataTypes.createStructField("regionCity", DataTypes.StringType, false),
      DataTypes.createStructField("regionWard", DataTypes.StringType, false),
      DataTypes.createStructField("candidate", DataTypes.StringType, false),
      DataTypes.createStructField("count", DataTypes.LongType, false)
    });

    JavaRDD<Row> rowRDD = voteRDD.map(vote -> 
      org.apache.spark.sql.RowFactory.create(
        vote.voteType,
        vote.regionArea,
        vote.regionCity,
        vote.regionWard,
        vote.candidate,
        vote.count
      )
    );

    return spark.createDataFrame(rowRDD, schema);
  }

  public void close() {
    if (spark != null) {
      spark.stop();
    }
  }
}
