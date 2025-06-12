package me.jonghyeon.refactor_election_result.controllers;

import me.jonghyeon.refactor_election_result.models.VoteCounted;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

import java.util.ArrayList;
import java.util.List;

public class SparkDataHandler {
    private SparkSession spark;
    private JavaSparkContext sc;

    public SparkDataHandler(String appName) {
        SparkConf conf = new SparkConf()
                .setAppName(appName)
                .setMaster("local[*]")  // Use all available cores locally
                .set("spark.sql.adaptive.enabled", "true")
                .set("spark.sql.adaptive.coalescePartitions.enabled", "true")
                .set("spark.driver.extraJavaOptions", 
                    "--add-opens java.base/java.lang=ALL-UNNAMED " +
                    "--add-opens java.base/java.lang.invoke=ALL-UNNAMED " +
                    "--add-opens java.base/java.lang.reflect=ALL-UNNAMED " +
                    "--add-opens java.base/java.io=ALL-UNNAMED " +
                    "--add-opens java.base/java.net=ALL-UNNAMED " +
                    "--add-opens java.base/java.nio=ALL-UNNAMED " +
                    "--add-opens java.base/java.util=ALL-UNNAMED " +
                    "--add-opens java.base/java.util.concurrent=ALL-UNNAMED " +
                    "--add-opens java.base/java.util.concurrent.atomic=ALL-UNNAMED " +
                    "--add-opens java.base/sun.nio.ch=ALL-UNNAMED " +
                    "--add-opens java.base/sun.nio.cs=ALL-UNNAMED " +
                    "--add-opens java.base/sun.security.action=ALL-UNNAMED " +
                    "--add-opens java.base/sun.util.calendar=ALL-UNNAMED " +
                    "--add-opens java.security.jgss/sun.security.krb5=ALL-UNNAMED")
                .set("spark.executor.extraJavaOptions", 
                    "--add-opens java.base/java.lang=ALL-UNNAMED " +
                    "--add-opens java.base/java.lang.invoke=ALL-UNNAMED " +
                    "--add-opens java.base/java.lang.reflect=ALL-UNNAMED " +
                    "--add-opens java.base/java.io=ALL-UNNAMED " +
                    "--add-opens java.base/java.net=ALL-UNNAMED " +
                    "--add-opens java.base/java.nio=ALL-UNNAMED " +
                    "--add-opens java.base/java.util=ALL-UNNAMED " +
                    "--add-opens java.base/java.util.concurrent=ALL-UNNAMED " +
                    "--add-opens java.base/java.util.concurrent.atomic=ALL-UNNAMED " +
                    "--add-opens java.base/sun.nio.ch=ALL-UNNAMED " +
                    "--add-opens java.base/sun.nio.cs=ALL-UNNAMED " +
                    "--add-opens java.base/sun.security.action=ALL-UNNAMED " +
                    "--add-opens java.base/sun.util.calendar=ALL-UNNAMED " +
                    "--add-opens java.security.jgss/sun.security.krb5=ALL-UNNAMED");
        
        spark = SparkSession.builder()
                .config(conf)
                .getOrCreate();
        
        sc = new JavaSparkContext(spark.sparkContext());
    }

    public void processAndSaveData(List<List<VoteCounted>> parsed, String outputPath, boolean useHadoop) {
        // Flatten the nested list structure
        List<VoteCounted> flattenedData = new ArrayList<>();
        for (List<VoteCounted> votesCountedList : parsed) {
            flattenedData.addAll(votesCountedList);
        }

        // Create RDD from the data
        JavaRDD<VoteCounted> voteRDD = sc.parallelize(flattenedData);

        // Convert to DataFrame for easier processing
        Dataset<Row> voteDF = createDataFrame(voteRDD);

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

        System.out.println("Spark processed data saved to: " + finalOutputPath + "_spark_processed");
    }

    private Dataset<Row> createDataFrame(JavaRDD<VoteCounted> voteRDD) {
        // Define the schema
        StructType schema = new StructType(new StructField[]{
                DataTypes.createStructField("voteType", DataTypes.StringType, false),
                DataTypes.createStructField("regionArea", DataTypes.StringType, false),
                DataTypes.createStructField("regionCity", DataTypes.StringType, false),
                DataTypes.createStructField("regionWard", DataTypes.StringType, false),
                DataTypes.createStructField("candidate", DataTypes.StringType, false),
                DataTypes.createStructField("count", DataTypes.LongType, false)
        });

        // Convert RDD to Row RDD
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
        if (sc != null) {
            sc.close();
        }
    }
}
