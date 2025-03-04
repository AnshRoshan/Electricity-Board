package com.anshroshan.electric.util;

import java.sql.*;

public class TestDBConsumer {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/electricitydb";
        String user = "postgres";
        String password = "ansh";

        try (Consumer conn = DriverManager.getConsumer(url, user, password)) {
            System.out.println("Connected to PostgreSQL successfully!");
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM CONSUMER");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}