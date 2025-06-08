package io.github.shapelayer;

class MainArgs {
    public boolean hadoop = false;
    public String inputPath = null;
    public String outputPath = null;
    public static MainArgs parse(String[] args) {
        MainArgs mainArgs = new MainArgs();
        for (String arg : args) {
            if (arg.equals("-h") || arg.equals("--hadoop=on")) {
                mainArgs.hadoop = true;
            } else if (arg.startsWith("--hadoop=")) {
                mainArgs.hadoop = arg.split("=")[1].equals("on");
            } else if (mainArgs.inputPath == null) {
                mainArgs.inputPath = arg;
            } else if (mainArgs.outputPath == null) {
                mainArgs.outputPath = arg;
            }
        }
        return mainArgs;
    }

    public boolean isValid() {
        return inputPath != null && outputPath != null;
    }
}

public class Main {
    public static void main(String[] args) throws Exception {
        MainArgs mainArgs = MainArgs.parse(args);
        if (!mainArgs.isValid()) {
            Commons.printUsage();
            System.exit(1);
        }

        if (mainArgs.hadoop) {
            HadoopJobHandler hadoopJobHandler = new HadoopJobHandler();
            System.exit(hadoopJobHandler.invokeJob(
                    mainArgs.inputPath, // These are HDFS paths for Hadoop
                    mainArgs.outputPath
            ) ? 0 : 1);
        } else {
            // For local processing, convert string paths to java.nio.file.Path
            java.nio.file.Path inputPath = java.nio.file.Paths.get(mainArgs.inputPath);
            java.nio.file.Path outputPath = java.nio.file.Paths.get(mainArgs.outputPath);
            
            ExcelToCSV.convertAllAndSave(
                inputPath,
                outputPath
            );
            System.out.println("Local conversion complete. Output in: " + outputPath.toString());
        }
    }
}
