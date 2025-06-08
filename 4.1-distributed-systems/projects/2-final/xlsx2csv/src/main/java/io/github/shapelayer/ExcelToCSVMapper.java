package io.github.shapelayer;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class ExcelToCSVMapper extends Mapper<NullWritable, Text, NullWritable, Text> {
    @Override
    protected void map(NullWritable key, Text value, Context context) throws IOException, InterruptedException {
        for (String line : value.toString().split("\n")) {
            context.write(NullWritable.get(), new Text(line));
        }
    }
}
