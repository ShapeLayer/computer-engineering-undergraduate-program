package io.github.shapelayer;

public class Commons {
    public static final String PROCESS_NAME = "xlsx2csv";
    public static final String PROCESS_FULL_NAME = "Excel to CSV Converter";

    public static final String USAGE = "Usage: xlsx2csv [-h|--hadoop=[on|off]] <input path> <output path>";

    public static void printUsage() {
        System.out.println(USAGE);
        System.out.println("Options:");
        System.out.println("  -h, --hadoop=[on|off]  Enable or disable Hadoop support (default: off)");
        System.out.println("  <input path>           Path to the input Excel file");
        System.out.println("  <output path>          Path to the output CSV file");
    }
}
