/**
 * IndexCreate.java
 * Midterm Project for <Distributed System> Lecture in Computer Engineering
 * (Software Engineering) Undergraduate Program
 * 
 * Author: Jonghyeon Park (@ShapeLayer, https://jonghyeon.me)
 * 
 * This program puts a massive amount of data into Elasticsearch using Hadoop
 * MapReduce. It uses the Elasticsearch REST API to create an index and put
 * documents into it. It also provides a command line interface to interact
 * with Elasticsearch.
 * 
 * How to use:
 * 1. Set up a Hadoop cluster and Elasticsearch cluster.
 * 2. Compile the code. Since the task requires a single source file, this can
 *   be done using the command:
 *   $ javac -classpath $(hadoop classpath) -d . IndexCreate.java
 *   $ jar cf IndexCreate.jar *.class
 *   (Compiling using Gradle or Maven is also good. For configuration in Gradle,
 *    see the build.gradle.kts code snippet below.)
 * 3. Create a .env file in the same directory as the IndexCreate.jar file.
 *    The snippet of the .env file is below. (or you can set the system environment
 *    variables.)
 * 4. Run the program using Hadoop:
 *   $ hadoop fs -rm -r /tmp/jobOutput
 *    (If you have to remove the previous output directory.)
 *   $ hadoop jar IndexCreate.jar IndexCreate --hadoop /user/hduser/10K.ID.CONTENTS /tmp/jobOutput
 * 
 * This program supports the several options. For more information, run the command:
 *   $ hadoop jar IndexCreate.jar IndexCreate -h
 */

/**
 * .env:
 * 
 * ES_HOST=http://localhost:9200
 * ES_TARGET_INDEX=wikipedia
 * ES_USERNAME=elastic
 * ES_PASSWORD=
 * HDFS_DOTENV_CACHE_PATH=/user/hduer/.env
 */

/**
 * build.gradle.kts:
 * 
 * plugins {
 *     id("java")
 * }
 * 
 * group = "io.github.shapelayer.essupport"
 * version = "1.0-SNAPSHOT"
 * 
 * repositories {
 *     mavenCentral()
 * }
 * 
 * dependencies {
 *     testImplementation(platform("org.junit:junit-bom:5.10.0"))
 *     testImplementation("org.junit.jupiter:junit-jupiter")
 * 
 *     implementation(group="org.apache.hadoop", name="hadoop-common", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-common", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-hdfs", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-yarn-common", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-minicluster", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-core", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-jobclient", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-app", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-shuffle", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-common", version="3.4.0")
 *     implementation(group="org.apache.hadoop", name="hadoop-client", version="3.4.0")
 * }
 * 
 * tasks.test {
 *     useJUnitPlatform()
 * }
 * 
 * allprojects {
 *     tasks.withType<JavaCompile> {
 *         options.isDeprecation = true
 *     }
 * 
 * 
 *     java.sourceCompatibility = org.gradle.api.JavaVersion.VERSION_1_8
 *     java.targetCompatibility = org.gradle.api.JavaVersion.VERSION_1_8
 * }
 */

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

class Environment {
  static final String DOTENV_PATH = ".env";

  static final String ENV_KEY_ES_HOST = "ES_HOST";
  static final String ENV_KEY_ES_TARGET_INDEX = "ES_TARGET_INDEX";
  static final String ENV_KEY_ES_USERNAME = "ES_USERNAME";
  static final String ENV_KEY_ES_PASSWORD = "ES_PASSWORD";
  static final String ENV_KEY_HDFS_DOTENV_CACHE_PATH = "HDFS_DOTENV_CACHE_PATH";

  static final String ENV_DEFAULT_VALUE_ES_HOST = "http://localhost:9200";
  static final String ENV_DEFAULT_VALUE_ES_TARGET_INDEX = "wikipedia";
  static final String ENV_DEFAULT_VALUE_ES_USERNAME = "elastic";
  static final String ENV_DEFAULT_VALUE_ES_PASSWORD = "";
  static final String ENV_DEFAULT_VALUE_HDFS_DOTENV_CACHE_PATH = "/user/hduser/.env";

  public static String esHost = null;
  public static String esTargetIndex = null;
  public static String esUsername = null;
  public static String esPassword = null;
  public static String hdfsDotenvCachePath = null;

  public static void load() {
    Properties properties = new Properties();
    try {
      Reader reader = new FileReader(DOTENV_PATH);
      properties.load(reader);

      esHost = properties.getProperty(ENV_KEY_ES_HOST);
      esTargetIndex = properties.getProperty(ENV_KEY_ES_TARGET_INDEX);
      esUsername = properties.getProperty(ENV_KEY_ES_USERNAME);
      esPassword = properties.getProperty(ENV_KEY_ES_PASSWORD);
      hdfsDotenvCachePath = properties.getProperty(ENV_KEY_HDFS_DOTENV_CACHE_PATH);
    } catch (IOException e) {}

    if (esHost == null) esHost = System.getenv(ENV_KEY_ES_HOST);
    if (esTargetIndex == null) esTargetIndex = System.getenv(ENV_KEY_ES_TARGET_INDEX);
    if (esUsername == null) esUsername = System.getenv(ENV_KEY_ES_USERNAME);
    if (esPassword == null) esPassword = System.getenv(ENV_KEY_ES_PASSWORD);
    if (hdfsDotenvCachePath == null) hdfsDotenvCachePath = System.getenv(ENV_KEY_HDFS_DOTENV_CACHE_PATH);

    if (esHost == null) {
      esHost = ENV_DEFAULT_VALUE_ES_HOST;
      System.err.println("Elastic Search host (" + ENV_KEY_ES_HOST + ") not found. Using default: " + ENV_DEFAULT_VALUE_ES_HOST);
    }
    if (esTargetIndex == null) {
      esTargetIndex = ENV_DEFAULT_VALUE_ES_TARGET_INDEX;
      System.err.println("A target index of Elastic Search (" + ENV_KEY_ES_TARGET_INDEX + ") not found. Using default: " + ENV_DEFAULT_VALUE_ES_TARGET_INDEX);
    }
    if (esUsername == null) {
      esUsername = ENV_DEFAULT_VALUE_ES_USERNAME;
      System.err.println("Username(" + ENV_KEY_ES_USERNAME + ") not found. Using default: " + ENV_DEFAULT_VALUE_ES_USERNAME);
    }
    if (esPassword == null) {
      esPassword = ENV_DEFAULT_VALUE_ES_PASSWORD;
      System.err.println("Password(" + ENV_KEY_ES_PASSWORD + ") not found. Using default: " + ENV_DEFAULT_VALUE_ES_PASSWORD + " (It must be error!)");
    }
    if (hdfsDotenvCachePath == null) {
      hdfsDotenvCachePath = ENV_DEFAULT_VALUE_HDFS_DOTENV_CACHE_PATH;
      System.err.println("A destination path to cache .env file not found (" + ENV_KEY_HDFS_DOTENV_CACHE_PATH + ") not found. Using default: " + ENV_DEFAULT_VALUE_HDFS_DOTENV_CACHE_PATH);
    }
  }

  private static void _onCalled() {
    if (esHost == null || esTargetIndex == null || esUsername == null || esPassword == null)
      load();
  }

  public static String getCredentials() {
    _onCalled();
    return String.format("%s:%s", esUsername, esPassword);
  }

  public static String getCredentialsEncoded() {
    return "Basic " + java.util.Base64.getEncoder().encodeToString(getCredentials().getBytes(StandardCharsets.UTF_8));
  }
}

class StringUtility {
  public static String escapeJson(String content) {
    return content.replace("\\", "\\\\").replace("\"", "\\\"");
  }
}

class Json {
  public static Object loads(String json) { return Json._loadsProc(json); }
  public static String dumps(Object object) { return Json._dumpsProc(object); }

  private static String _dumpsProc(Object object) {
    List<String> buf = new LinkedList<>();
    if (object instanceof Map) {
      Map<?, ?> map = (Map<?, ?>) object;
      buf.add("{");
      boolean first = true;
      for (Map.Entry<?, ?> entry : map.entrySet()) {
        if (!first) {
          buf.add(",");
        }
        first = false;
        buf.add(String.format("\"%s\":", StringUtility.escapeJson(entry.getKey().toString())));
        buf.add(Json._dumpsProc(entry.getValue()));
      }
      buf.add("}");
    } else if (object instanceof List) {
      List<?> list = (List<?>) object;
      buf.add("[");
      boolean first = true;
      for (Object item : list) {
        if (!first) {
          buf.add(",");
        }
        first = false;
        buf.add(Json._dumpsProc(item));
      }
      buf.add("]");
    } else if (object instanceof String || object instanceof Character) {
      buf.add("\"" + StringUtility.escapeJson(object.toString()) + "\"");
    } else {
      buf.add(object.toString());
    }
    return String.join("", buf);
  }

  private static Object _loadsProc(String json) {
    json = json.trim();
    if (json.startsWith("{")) {
      return Json._parseJsonObject(json);
    }
    if (json.startsWith("[")) {
      return Json._parseJsonArray(json);
    }
    if (json.startsWith("\"") && json.endsWith("\"")) {
      return json.substring(1, json.length() - 1);
    }
    if (json.equalsIgnoreCase("true") || json.equalsIgnoreCase("false")) {
      return Boolean.parseBoolean(json);
    }
    if (json.matches("-?\\d+(\\.\\d+)?")) {
      return json.contains(".") ? Double.parseDouble(json) : Integer.parseInt(json);
    }
    throw new IllegalArgumentException("Invalid JSON value: " + json);
  }

  private static Map<String, Object> _parseJsonObject(String json) {
    Map<String, Object> map = new HashMap<>();
    json = json.substring(1, json.length() - 1).trim();
    String[] entries = Json._splitJsonEntries(json);
    for (String entry : entries) {
      String[] keyValue = entry.split(":", 2);
      String key = Json._loadsProc(keyValue[0]).toString();
      Object value = Json._loadsProc(keyValue[1]);
      map.put(key, value);
    }
    return map;
  }

  private static String[] _splitJsonEntries(String json) {
    List<String> entries = new LinkedList<>();
    int bracketCount = 0, braceCount = 0;
    boolean inQuotes = false;
    StringBuilder entry = new StringBuilder();

    for (int i = 0; i < json.length(); i++) {
      char c = json.charAt(i);
      if (c == '"') {
        if (i == 0 || json.charAt(i - 1) != '\\') {
          inQuotes = !inQuotes;
        }
      }
      if (!inQuotes) {
        if (c == '{') braceCount++;
        else if (c == '}') braceCount--;
        else if (c == '[') bracketCount++;
        else if (c == ']') bracketCount--;
      }
      if (c == ',' && !inQuotes && braceCount == 0 && bracketCount == 0) {
        entries.add(entry.toString().trim());
        entry.setLength(0);
      } else {
        entry.append(c);
      }
    }

    if (entry.length() > 0) entries.add(entry.toString().trim());

    return entries.toArray(new String[0]);
  }

  public static List<Object> _parseJsonArray(String json) {
    List<Object> list = new LinkedList<>();
    json = json.substring(1, json.length() - 1).trim();
    String[] items = Json._splitJsonEntries(json);
    for (String item : items) {
      list.add(Json._loadsProc(item));
    }
    return list;
  }
}

class ESDocument {
  public String id;
  public String body;
  public ESDocument(String id, String body) {
    this.id = id;
    this.body = body;
  }
  public String toJson() {
    Map<String, String> _map = new HashMap<>();
    _map.put("id", this.id);
    _map.put("body", this.body);
    return Json.dumps(_map);
  }
}

class ESQueryFailedException extends Exception {
  public ESQueryFailedException() {}
}

class ESCommunicateController {
  static final String CREATE_PATH = "%s/_create/%s";
  static final String CRUD_PATH = "%s/_doc/%s";
  static final String SEARCH_PATH = "%s/_search";
  static final String CLUSTER_HEALTH_PATH = "_cluster/health/";

  static final boolean DEFAULT_CONFIG_DO_OUTPUT = true;
  static final String DEFAULT_CONFIG_HEADER_CONTENT_TYPE = "application/json";

  public String baseUrl;
  public String index;
  private String createPathCached = null;
  private String crudPathCached = null;
  private String searchPathCached = null;
  private HttpURLConnection conn;

  public ESCommunicateController(String baseUrl, String index) {
    this.baseUrl = baseUrl;
    this.index = index;
    this._updateUrlCache();
  }

  private void _updateUrlCache() {
    this.createPathCached = String.format(CREATE_PATH, this.index, "%s");
    this.crudPathCached = String.format(CRUD_PATH, this.index, "%s");
    this.searchPathCached = String.format(SEARCH_PATH, this.index);
  }

  private void connect(String path) throws IOException {
    URL url = URI.create(this.baseUrl.endsWith("/") ? this.baseUrl + path : this.baseUrl + "/" + path).toURL();
    conn = (HttpURLConnection) url.openConnection();
    this._configConn();
  }

  private void _configConn() {
    if (conn == null) return;
    conn.setDoOutput(DEFAULT_CONFIG_DO_OUTPUT);
    conn.setRequestProperty("Content-Type", DEFAULT_CONFIG_HEADER_CONTENT_TYPE);
    conn.setRequestProperty("Authorization", Environment.getCredentialsEncoded());
  }

  public Map<String, Object> put(ESDocument document) throws IOException {
    this.connect(String.format(this.crudPathCached, document.id));
    conn.setRequestMethod("PUT");

    OutputStream os = conn.getOutputStream();
    OutputStreamWriter out = new OutputStreamWriter(os);
    out.write(document.toJson());
    out.close();

    String _lineBuf;
    List<String> _resBuf = new LinkedList<>();
    InputStream is = conn.getInputStream();
    BufferedReader in = new BufferedReader(new InputStreamReader(is));
    while ((_lineBuf = in.readLine()) != null) {
      _resBuf.add(_lineBuf);
    }
    String _response = String.join("", _resBuf);
    in.close();
    conn.disconnect();

    return (Map<String, Object>) Json.loads(_response);
  };

  public Map<String, Object> get(String id) throws IOException {
    this.connect(String.format(this.crudPathCached, id));
    conn.setRequestMethod("GET");

    String _lineBuf;
    List<String> _resBuf = new LinkedList<>();
    InputStream is = conn.getInputStream();
    BufferedReader in = new BufferedReader(new InputStreamReader(is));
    while ((_lineBuf = in.readLine()) != null) {
      _resBuf.add(_lineBuf);
    }
    String _response = String.join("", _resBuf);
    in.close();
    conn.disconnect();

    return (Map<String, Object>) Json.loads(_response);
  };

  public Map<String, Object> searchUsingUri(String keyword) throws IOException {
    this.connect(this.searchPathCached + "?q=" + keyword);
    conn.setRequestMethod("GET");

    String _lineBuf;
    List<String> _resBuf = new LinkedList<>();
    InputStream is = conn.getInputStream();
    BufferedReader in = new BufferedReader(new InputStreamReader(is));
    while ((_lineBuf = in.readLine()) != null) {
      _resBuf.add(_lineBuf);
    }
    String _response = String.join("", _resBuf);
    in.close();
    conn.disconnect();

    return (Map<String, Object>) Json.loads(_response);
  };

  public Map<String, Object> searchDataBody(String dataBody) throws IOException {
    this.connect(this.searchPathCached);
    conn.setRequestMethod("POST");

    OutputStream os = conn.getOutputStream();
    OutputStreamWriter out = new OutputStreamWriter(os);
    Map<String, Object> requestBody = new HashMap<String, Object>() {{
      put("query", new HashMap<String, Object>() {{
        put("match", new HashMap<String, String>() {{
          put("body", dataBody);
        }});
      }});
    }};
    out.write(Json.dumps(requestBody));
    out.close();

    String _lineBuf;
    List<String> _resBuf = new LinkedList<>();
    InputStream is = conn.getInputStream();
    BufferedReader in = new BufferedReader(new InputStreamReader(is));
    while ((_lineBuf = in.readLine()) != null) {
      _resBuf.add(_lineBuf);
    }
    String _response = String.join("", _resBuf);
    in.close();
    conn.disconnect();

    return (Map<String, Object>) Json.loads(_response);
  };

  public Map<String, Object> getClusterHealth() throws IOException {
    this.connect(this.CLUSTER_HEALTH_PATH);
    conn.setRequestMethod("GET");

    String _lineBuf;
    List<String> _resBuf = new LinkedList<>();
    InputStream is = conn.getInputStream();
    BufferedReader in = new BufferedReader(new InputStreamReader(is));
    while ((_lineBuf = in.readLine()) != null) {
      _resBuf.add(_lineBuf);
    }
    String _response = String.join("", _resBuf);
    in.close();
    conn.disconnect();

    return (Map<String, Object>) Json.loads(_response);
  };

  public static void ensureResponseNotError(Map<String, Object> response) throws ESQueryFailedException, IOException {
    if (response.containsKey("error")) throw new ESQueryFailedException();
    if (!response.containsKey("result")) throw new IOException();
  }
}

class ESMapper extends Mapper<Text, Text, Text, Text> {
  private String _baseURL;

  @Override
  public void setup(Context context) {
    Configuration config = context.getConfiguration();
    _baseURL = config.get(Environment.ENV_KEY_ES_HOST);
    if (_baseURL == null) _baseURL = Environment.ENV_DEFAULT_VALUE_ES_HOST;
  }

  @Override
  public void map(Text key, Text value, Context context) {
    String _key = key.toString();
    String _value = value.toString();

    try {
      ESCommunicateController es = new ESCommunicateController(_baseURL, Environment.esTargetIndex);
      ESDocument document = new ESDocument(_key, _value);
      Map<String, Object> response = es.put(document);
      ESCommunicateController.ensureResponseNotError(response);
      context.write(key, value);
    } catch (IOException e) {
      e.printStackTrace();
    } catch (ESQueryFailedException e) {
      e.printStackTrace();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      try {
        context.getCounter("Stats", "Success").increment(1);
      } catch (Exception e) {
        context.getCounter("Stats", "Failed").increment(1);
        e.printStackTrace();
      }
    }
  }
}

public class IndexCreate {
  static Map<String, Object> argparsed = new HashMap<>();

  static final String usage = String.join("\n",
      "Usage: IndexCreate [options]",
      "",
      "",
      "Options:",
      " -h --help                       : show this help message",
      " -H --hadoop <input> <output>    : executes using hadoop",
      "    --es-host HOST               : elasticsearch host",
      "    --es-index INDEX             : elasticsearch index",
      "    --es-username USERNAME       : elasticsearch username",
      "    --es-password PASSWORD       : elasticsearch password",
      "    --hdfs-env-cache-path PATH   : hdfs path to cache .env file",
      " -P --put <id> <body>            : put a document to elasticsearch",
      " -G --get <id>                   : get a document from elasticsearch",
      " -S --search <keyword>           : search a document from elasticsearch using URI",
      " -s --search-body <body>         : search a document from elasticsearch using body",
      " -C --cluster-health             : get cluster health from elasticsearch",
      " -t --test <id>                  : run a test suite"
  );

  static String _transcriptKey(String key) {
    switch (key) {
      case "H":
        return "hadoop";
      case "P":
        return "put";
      case "G":
        return "get";
      case "S":
        return "search";
      case "s":
        return "search-body";
      case "C":
        return "cluster-health";
      case "t":
        return "test";
      default:
        return key;
    }
  }

  static boolean parseArgs(String[] args) {
    for (int i = 0; i < args.length; i++) {
      String arg = args[i];

      if (arg.startsWith("-")) {
        String[] kv = arg.toLowerCase().substring(arg.startsWith("--") ? 2 : 1).split("=");
        String key = _transcriptKey(kv[0]);

        switch (key) {
          case "hadoop":
            if (i + 2 < args.length) {
              argparsed.put(key, new String[] {args[i + 1], args[i + 2]});
              i += 2;
            } else {
              return false;
            }
            break;
          case "put":
            if (i + 2 < args.length) {
              argparsed.put(key, new String[] {args[i + 1], args[i + 2]});
              i += 2;
            } else {
              return false;
            }
            break;
          case "get":
            if (i + 1 < args.length) {
              argparsed.put(key, args[i + 1]);
              i++;
            } else {
              return false;
            }
            break;
          case "search":
            if (i + 1 < args.length) {
              argparsed.put(key, args[i + 1]);
              i++;
            } else {
              return false;
            }
            break;
          case "search-body":
            if (i + 1 < args.length) {
              argparsed.put(key, args[i + 1]);
              i++;
            } else {
              return false;
            }
            break;
          case "cluster-health":
            argparsed.put(key, true);
            break;
          case "es-host":
          case "es-index":
          case "es-username":
          case "es-password":
          case "hdfs-env-cache-path":
            if (i + 1 < args.length) {
              argparsed.put(key, args[i + 1]);
              i++;
            } else {
              return false;
            }
            break;
          case "test":
            argparsed.put(key, true);
            break;
          default:
            return false;
        }
      }
    }
    return true;
  }

  static void printOutUsage() { System.out.println(usage); }
  static void printErrUsage() { System.err.println(usage); }

  static void invokeHadoopMapReduce() throws IOException, URISyntaxException, InterruptedException, ClassNotFoundException {
    Configuration config = new Configuration();

    if (argparsed.containsKey("es-host")) config.set(Environment.ENV_KEY_ES_HOST, argparsed.get("es-host").toString());
    if (argparsed.containsKey("es-index")) config.set(Environment.ENV_KEY_ES_TARGET_INDEX, argparsed.get("es-index").toString());
    if (argparsed.containsKey("es-username")) config.set(Environment.ENV_KEY_ES_USERNAME, argparsed.get("es-username").toString());
    if (argparsed.containsKey("es-password")) config.set(Environment.ENV_KEY_ES_PASSWORD, argparsed.get("es-password").toString());
    if (argparsed.containsKey("hdfs-env-cache-path")) config.set(Environment.ENV_KEY_HDFS_DOTENV_CACHE_PATH, argparsed.get("hdfs-env-cache-path").toString());

    Job job = Job.getInstance(config, "Create ElasticSearch Index");
    job.setJarByClass(IndexCreate.class);
    job.addCacheFile(new URI(Environment.hdfsDotenvCachePath));

    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);

    job.setMapperClass(ESMapper.class);

    job.setInputFormatClass(KeyValueTextInputFormat.class);
    job.setOutputFormatClass(TextOutputFormat.class);
    job.setNumReduceTasks(0);

    String[] hadoopArgs = (String[]) argparsed.get("hadoop");
    FileInputFormat.addInputPath(job, new Path(hadoopArgs[0]));
    FileOutputFormat.setOutputPath(job, new Path(hadoopArgs[1]));

    job.waitForCompletion(true);
    System.out.println("Job completed successfully.");
  }

  static void invokeTestSuite() throws IOException {
    ESCommunicateController es = new ESCommunicateController(Environment.esHost, Environment.esTargetIndex);

    System.out.println(String.format("ES Host: %s\n", Environment.esHost));

    System.out.println(String.format("GET: \n%s", es.get("TEST_ID")));
    System.out.println(String.format("PUT: \n%s", es.put(new ESDocument("TEST_ID", "TEST_BODY"))));
    
    System.out.println(String.format("Search using URI: \n%s", es.searchUsingUri("TEST_ID")));
    System.out.println(String.format("Search using body: \n%s", es.searchDataBody("TEST_BODY")));
    
    System.out.println(String.format("Cluster Health: \n%s", es.getClusterHealth()));
  }

  static void invokeClusterHealth() throws IOException {
    ESCommunicateController es = new ESCommunicateController(Environment.esHost, Environment.esTargetIndex);
    System.out.println(String.format("Cluster Health: \n%s", es.getClusterHealth()));
  }

  public static void main(String[] args) throws IOException, URISyntaxException, InterruptedException, ClassNotFoundException {
    Environment.load();

    if (args.length < 1) { printErrUsage(); return; }
    if (args[0].equals("-h") || args[0].equals("--help")) { printOutUsage(); return; }

    if (!parseArgs(args)) {
      System.err.println("Invalid arguments.");
      printErrUsage();
      return;
    };

    if (argparsed.containsKey("es-host")) Environment.esHost = argparsed.get("es-host").toString();
    if (argparsed.containsKey("es-index")) Environment.esTargetIndex = argparsed.get("es-index").toString();
    if (argparsed.containsKey("es-username")) Environment.esUsername = argparsed.get("es-username").toString();
    if (argparsed.containsKey("es-password")) Environment.esPassword = argparsed.get("es-password").toString();
    if (argparsed.containsKey("hdfs-env-cache-path")) Environment.hdfsDotenvCachePath = argparsed.get("hdfs-env-cache-path").toString();
    
    if (argparsed.containsKey("test")) { invokeTestSuite(); return; }
    if (argparsed.containsKey("cluster-health")) { invokeClusterHealth(); return; }

    if (argparsed.containsKey("hadoop")) {
      invokeHadoopMapReduce();
      return;
    }

    ESCommunicateController es = new ESCommunicateController(Environment.esHost, Environment.esTargetIndex);
    if (argparsed.containsKey("put")) {
      String[] putArgs = (String[]) argparsed.get("put");
      String id = putArgs[0];
      String body = putArgs[1];
      ESDocument document = new ESDocument(id, body);
      System.out.println(String.format("PUT: \n%s", es.put(document)));
      return;
    }
    if (argparsed.containsKey("get")) {
      String id = argparsed.get("get").toString();
      System.out.println(String.format("GET: \n%s", es.get(id)));
      return;
    }
    if (argparsed.containsKey("search")) {
      String keyword = argparsed.get("search").toString();
      System.out.println(String.format("Search using URI: \n%s", es.searchUsingUri(keyword)));
      return;
    }
    if (argparsed.containsKey("search-body")) {
      String body = argparsed.get("search-body").toString();
      System.out.println(String.format("Search using body: \n%s", es.searchDataBody(body)));
      return;
    }
  }
}
