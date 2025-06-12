import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    id("java")
    id("com.github.johnrengelman.shadow") version "8.1.1"
}

group = "me.jonghyeon.refactor_election_result"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.apache.hadoop:hadoop-common:3.3.6")
    implementation("org.apache.hadoop:hadoop-mapreduce-client-core:3.3.6")

    implementation("org.apache.poi:poi:5.2.5")
    implementation("org.apache.poi:poi-ooxml:5.2.5")

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
}
