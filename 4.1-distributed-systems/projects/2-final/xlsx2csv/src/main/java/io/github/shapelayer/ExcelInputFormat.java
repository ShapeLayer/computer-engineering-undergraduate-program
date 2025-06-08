package io.github.shapelayer;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.InputStream;

public class ExcelInputFormat extends FileInputFormat<NullWritable, Text> {
    @Override
    protected boolean isSplitable(JobContext context, Path filename) {
        return false;
    }

    @Override
    public RecordReader<NullWritable, Text> createRecordReader(InputSplit split, TaskAttemptContext context) {
        return new RecordReader<NullWritable, Text>() {
            private boolean read = false;
            private Text value = new Text();

            @Override
            public void initialize(InputSplit split, TaskAttemptContext context) {}

            @Override
            public boolean nextKeyValue() {
                return !read && (read = true);
            }

            @Override
            public NullWritable getCurrentKey() {
                return NullWritable.get();
            }

            @Override
            public Text getCurrentValue() {
                if (value.getLength() == 0) {
                    try {
                        Path path = ((FileSplit) split).getPath();
                        InputStream input = path.getFileSystem(context.getConfiguration()).open(path);
                        Workbook workbook = new XSSFWorkbook(input);
                        Sheet sheet = workbook.getSheetAt(0);

                        StringBuilder sb = new StringBuilder();
                        for (Row row : sheet) {
                            for (Cell cell : row) {
                                sb.append("\"").append(cell.toString().replace("\"", "\"\"")).append("\",");
                            }
                            if (sb.length() > 0) sb.setLength(sb.length() - 1);
                            sb.append("\n");
                        }

                        workbook.close();
                        value.set(sb.toString());
                    } catch (Exception e) {
                        throw new RuntimeException("Failed to read Excel file", e);
                    }
                }
                return value;
            }

            @Override
            public float getProgress() {
                return read ? 1.0f : 0.0f;
            }

            @Override
            public void close() {}
        };
    }
}
