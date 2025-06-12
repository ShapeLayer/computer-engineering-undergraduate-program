import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    id("java")
    id("com.github.johnrengelman.shadow") version "8.1.1"
}

group = "me.jonghyeon.refactor_election_result"
version = "1.0-SNAPSHOT"

repositories {
    maven { url = uri("https://repo.osgeo.org/repository/release/")}
    maven { url = uri("https://repo.osgeo.org/repository/snapshot")}
    mavenCentral()
}

dependencies {
    implementation("org.apache.hadoop:hadoop-common:3.3.6")
    implementation("org.apache.hadoop:hadoop-mapreduce-client-core:3.3.6")

    implementation("org.apache.poi:poi:5.2.5")
    implementation("org.apache.poi:poi-ooxml:5.2.5")

    implementation("org.apache.spark:spark-core_2.12:3.5.0")
    implementation("org.apache.spark:spark-sql_2.12:3.5.0")

    implementation("org.jfree:jfreechart:1.5.6")
    implementation("com.fasterxml.jackson.core:jackson-databind:2.19.0")
    implementation("org.geotools:gt-main:29.2")
    implementation("org.geotools:gt-shapefile:29.2")
    implementation("org.geotools:gt-swing:29.2")

    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
}

tasks.test {
    useJUnitPlatform()
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(8))
    }
}

tasks.withType<ShadowJar> {
    manifest {
        attributes["Main-Class"] = "me.jonghyeon.refactor_election_result.Main"
    }
    mergeServiceFiles()
    transform(com.github.jengelman.gradle.plugins.shadow.transformers.ServiceFileTransformer::class.java)
    setProperty("zip64", true)
}
