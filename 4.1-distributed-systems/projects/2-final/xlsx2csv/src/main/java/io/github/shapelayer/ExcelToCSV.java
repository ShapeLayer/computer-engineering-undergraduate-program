package io.github.shapelayer;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelToCSV {

    /**
     * Converts all sheets from an Excel file (provided as an InputStream) to a list of CSV strings.
     * Each string in the list represents the CSV content of one sheet.
     * This method is suitable for use in Hadoop Mappers where input is an InputStream.
     *
     * @param inputStream The InputStream of the Excel file.
     * @return A list of strings, where each string is the CSV content of a sheet.
     * @throws IOException If an I/O error occurs or the stream is not a valid Excel file.
     */
    public static List<String> convert(InputStream inputStream) throws IOException {
        List<String> sheetsCsvData = new ArrayList<>();
        try (Workbook workbook = new XSSFWorkbook(inputStream)) {
            for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                Sheet sheet = workbook.getSheetAt(i);
                StringBuilder sb = new StringBuilder();
                for (Row row : sheet) {
                    boolean firstCell = true;
                    for (Cell cell : row) {
                        System.out.println(cell.toString());
                        if (!firstCell) {
                            sb.append(",");
                        }
                        // Basic cell to string conversion, consider DataFormatter for more complex types
                        sb.append("\"").append(cell.toString().replace("\"", "\"\"")).append("\"");
                        firstCell = false;
                    }
                    if (!firstCell) { // If row had any cells
                        sb.append("\n");
                    }
                }
                sheetsCsvData.add(sb.toString());
            }
        }
        return sheetsCsvData;
    }

    /**
     * Converts an Excel file from a given local file path to a list of CSV strings.
     * Each string in the list represents the CSV content of one sheet.
     *
     * @param filepath Path to the local .xlsx file.
     * @return A list of strings, where each string is the CSV content of a sheet.
     * @throws IOException If an I/O error occurs.
     */
    public static List<String> convert(Path filepath) throws IOException {
        if (!Files.exists(filepath) || Files.isDirectory(filepath)) {
            throw new FileNotFoundException("File not found or is a directory: " + filepath);
        }
        try (InputStream fis = Files.newInputStream(filepath)) {
            return convert(fis);
        }
    }

    /**
     * Recursively finds all .xlsx files under a base directory, converts them,
     * and returns a map where keys are original .xlsx filenames and values are lists of CSV sheet data.
     *
     * @param basepath The root directory to search for .xlsx files.
     * @return A map of .xlsx filenames to their converted CSV sheet data.
     * @throws IOException If an I/O error occurs during directory traversal or file reading.
     */
    public static Map<String, List<String>> convertAll(Path basepath) throws IOException {
        if (!Files.exists(basepath)) {
            throw new FileNotFoundException("Base path does not exist: " + basepath);
        }
        if (!Files.isDirectory(basepath)) {
            throw new IllegalArgumentException("Base path must be a directory: " + basepath);
        }

        Map<String, List<String>> allSheetsData = new HashMap<>();
        try (Stream<Path> pathStream = Files.walk(basepath)) {
            pathStream
                .filter(path -> !Files.isDirectory(path) && path.toString().toLowerCase().endsWith(".xlsx"))
                .forEach(excelFilePath -> {
                    try {
                        List<String> csvSheets = convert(excelFilePath);
                        allSheetsData.put(excelFilePath.getFileName().toString(), csvSheets);
                    } catch (Exception e) {
                        System.err.println("Error processing file " + excelFilePath + ": " + e.getMessage() + ". Skipping.");
                    }
                });
        }
        return allSheetsData;
    }

    /**
     * Converts all .xlsx files found recursively under basepath and saves each sheet
     * as a separate .csv file in the outputDir.
     * Output CSVs will be named like 'originalfilename_sheetN.csv'.
     *
     * @param basepath  The root directory to search for .xlsx files.
     * @param outputDir The directory where .csv files will be saved.
     * @throws IOException If an I/O error occurs.
     */
    public static void convertAllAndSave(Path basepath, Path outputDir) throws IOException {
        if (!Files.exists(basepath)) {
            throw new FileNotFoundException("Base input path does not exist: " + basepath);
        }
        Files.createDirectories(outputDir);

        Map<String, List<String>> excelFileToSheetsCsvMap = convertAll(basepath);

        for (Map.Entry<String, List<String>> entry : excelFileToSheetsCsvMap.entrySet()) {
            String originalXlsxFileName = entry.getKey();
            List<String> csvDataPerSheet = entry.getValue();

            String baseName = originalXlsxFileName;
            if (baseName.toLowerCase().endsWith(".xlsx")) {
                baseName = baseName.substring(0, baseName.length() - 5);
            }

            for (int i = 0; i < csvDataPerSheet.size(); i++) {
                String sheetCsvContent = csvDataPerSheet.get(i);
                String outputCsvFileName = baseName + "_sheet" + (i + 1) + ".csv";
                Path sheetOutputPath = outputDir.resolve(outputCsvFileName);
                try {
                    // Using Files.write with bytes for Java 8 compatibility
                    Files.write(sheetOutputPath, sheetCsvContent.getBytes(StandardCharsets.UTF_8));
                } catch (IOException e) {
                    System.err.println("Error writing to file " + sheetOutputPath + ": " + e.getMessage());
                }
            }
        }
    }
}
