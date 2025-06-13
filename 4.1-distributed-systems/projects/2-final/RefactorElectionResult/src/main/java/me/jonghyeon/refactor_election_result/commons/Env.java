package me.jonghyeon.refactor_election_result.commons;

import io.github.cdimascio.dotenv.Dotenv;
import io.github.cdimascio.dotenv.DotenvException;

public class Env {
    boolean dotenvEnabled = false;
    Dotenv dotenv;
    public Env() {
        try {
            this.dotenv = Dotenv.load();
            dotenvEnabled = true;
        } catch (DotenvException e) {
            System.err.println(".env not found. use defualt system env");
        }
    }
    public String get(String name) {
        if (dotenvEnabled) {
            return dotenv.get(name);
        } else {
            return System.getenv(name);
        }
    }
}