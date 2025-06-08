package io.github.shapelayer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.fs.Path;

import java.io.IOException;


public class HadoopJobHandler {
    public Configuration configuration;
    public Job job;

    public HadoopJobHandler() throws IOException {
        this.configuration = new Configuration();
        this.job = Job.getInstance(this.configuration, Commons.PROCESS_FULL_NAME);
        
        job.setJarByClass(Main.class);
    }

    public boolean invokeJob(String inputPath, String outputPath) throws IOException, InterruptedException, ClassNotFoundException {
        job.setInputFormatClass(ExcelInputFormat.class);
        ExcelInputFormat.addInputPath(job, new Path(inputPath));
        job.setMapperClass(ExcelToCSVMapper.class);
        job.setNumReduceTasks(0);

        job.setOutputKeyClass(NullWritable.class);
        job.setOutputValueClass(Text.class);
        TextOutputFormat.setOutputPath(job, new Path(outputPath));

        return job.waitForCompletion(true);
    }
}
