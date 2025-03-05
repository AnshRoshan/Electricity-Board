package com.anshroshan.electric.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    public static Connection getConnection() {
        String url = "jdbc:postgresql://localhost:5432/electricitydb";
        String user = "postgres";
        String password = "ansh";

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to Postgres SQL successfully!");
            return conn;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            // e.printStackTrace();
            return null;
        }
    }
}
