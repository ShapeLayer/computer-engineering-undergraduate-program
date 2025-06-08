# Election Result Analyzer

A Java 8 program that reads CSV files containing election results and analyzes vote data for specific political parties by region.

## Features

1. **CSV File Processing**: Reads all CSV files from the `/csv` directory
2. **Party Filtering**: Processes data only for specified target parties
3. **Regional Aggregation**: Groups vote data by party and region
4. **Multiple Output Files**: Generates comprehensive analysis reports

## Target Parties

The program processes data for the following political parties:
- 더불어시민당 (Democratic Civil Party)
- 미래한국당 (Future Korea Party)
- 정의당 (Justice Party)
- 국민의당 (People's Party)
- 민생당 (People's Livelihood Party)
- 우리공화당 (Our Republican Party)
- 한국경제당 (Korean Economic Party)
- 민중당 (People's Party)

## Project Structure

```
ElectionResultAnalyzer/
├── build.gradle                 # Gradle build configuration
├── src/main/java/io/github/shapelayer/
│   ├── Main.java                # Main application entry point
│   ├── analyzer/
│   │   └── ElectionResultAnalyzer.java  # Core analysis logic
│   ├── model/
│   │   ├── ElectionResult.java  # Election result data model
│   │   └── PartyRegionResult.java  # Party-region aggregation model
│   └── util/
│       └── CSVElectionReader.java  # CSV parsing utility
├── csv/                         # Input CSV files directory
└── output/                      # Generated analysis results
    ├── comprehensive_election_results.csv
    ├── party_summary.csv
    └── region_summary.csv
```

## How to Run

1. **Build the project:**
   ```bash
   ./gradlew build
   ```

2. **Run the analysis:**
   ```bash
   ./gradlew run
   ```

## Input Format

The program expects CSV files with Korean election results in the following format:
- Header row 4: Party names
- Data row 5: Vote counts for each party
- File naming convention: `개표상황(투표구별)_[지역명]_sheet1.csv`

## Output Files

### 1. comprehensive_election_results.csv
Contains detailed results for each party in each region:
```csv
Party,Region,TotalVotes,DistrictCount
국민의당,송파구,35553,1
더불어시민당,부천시,123456,1
...
```

### 2. party_summary.csv
Summary statistics for each party across all regions:
```csv
Party,TotalVotes,TotalDistricts,RegionCount
국민의당,1869515,248,248
더불어시민당,9183305,248,248
...
```

### 3. region_summary.csv
Summary statistics for each region across all parties:
```csv
Region,TotalVotes,PartyCount
부천시,380291,8
송파구,352688,8
...
```

## Dependencies

- Java 8 or higher
- OpenCSV 5.7.1 for CSV parsing
- Gradle 8.8 for build management

## Key Features Implemented

1. **Stream API Usage**: Utilizes Java 8 Streams for efficient data processing
2. **Lambda Expressions**: Modern functional programming approach
3. **File I/O**: Robust file reading and writing operations
4. **Error Handling**: Comprehensive exception handling for CSV parsing
5. **Data Aggregation**: Efficient grouping and summarization of election data
6. **UTF-8 Support**: Proper handling of Korean text in CSV files

## Error Handling

The program includes robust error handling for:
- Missing or invalid CSV files
- Malformed CSV data
- File I/O exceptions
- Number parsing errors

## Performance

- Processes 579 CSV files efficiently
- Memory-efficient streaming approach
- Parallel processing capabilities where applicable
