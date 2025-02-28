package com.anshroshan.electrictymanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseUtil {
    private static final Logger LOGGER = Logger.getLogger(DatabaseUtil.class.getName());
    private static final String URL = "jdbc:postgresql://localhost:5432/electricitydb";
    private static final String USER = "postgres"; // Replace with your PostgreSQL username
    private static final String PASSWORD = "ansh"; // Replace with your PostgreSQL password

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            LOGGER.info("Database connection established successfully.");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Failed to connect to the database: " + e.getMessage(), e);
        }
        return connection;
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Database connection closed successfully.");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing database connection: " + e.getMessage(), e);
            }
        }
    }
}