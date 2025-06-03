plugins {
    id("java")
}

group = "io.github.shapelayer.essupport"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")

    implementation(group="org.apache.hadoop", name="hadoop-common", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-common", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-hdfs", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-yarn-common", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-minicluster", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-core", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-jobclient", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-app", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-shuffle", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-mapreduce-client-common", version="3.4.0")
    implementation(group="org.apache.hadoop", name="hadoop-client", version="3.4.0")
}

tasks.test {
    useJUnitPlatform()
}

allprojects {
    tasks.withType<JavaCompile> {
        options.isDeprecation = true
    }


    java.sourceCompatibility = org.gradle.api.JavaVersion.VERSION_1_8
    java.targetCompatibility = org.gradle.api.JavaVersion.VERSION_1_8
}
