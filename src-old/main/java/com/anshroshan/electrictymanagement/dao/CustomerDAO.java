package com.anshroshan.electrictymanagement.dao;

import com.anshroshan.electrictymanagement.models.Customer;
import java.sql.*;
import java.util.UUID;
import java.util.logging.Logger;

public class CustomerDAO {
    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());

    public String addCustomer(Customer customer) {
        String sql = "INSERT INTO CUSTOMER (CUSTOMERID, TITLE, NAME, ADDRESS, MOBILE, EMAIL, PASSWORD) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING CUSTOMERID";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            // Generate random CUSTOMERID
            String customerId = UUID.randomUUID().toString().substring(0, 8); // Shortened for simplicity
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, customerId);
                stmt.setString(2, customer.getTitle());
                stmt.setString(3, customer.getName());
                stmt.setString(4, customer.getAddress());
                stmt.setLong(5, customer.getMobile());
                stmt.setString(6, customer.getEmail());
                stmt.setString(7, customer.getPassword());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    LOGGER.info("Customer added successfully: " + customerId);
                    return rs.getString("CUSTOMERID");
                }
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error adding customer: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public Customer getCustomerById(String customerId) {
        String sql = "SELECT * FROM CUSTOMER WHERE CUSTOMERID = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Customer customer = new Customer(
                            rs.getString("CUSTOMERID"),
                            rs.getString("TITLE"),
                            rs.getString("NAME"),
                            rs.getString("ADDRESS"),
                            rs.getLong("MOBILE"),
                            rs.getString("EMAIL"),
                            rs.getString("PASSWORD")
                    );
                    LOGGER.info("Customer retrieved: " + customerId);
                    return customer;
                }
                LOGGER.warning("No customer found with ID: " + customerId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving customer: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean validateLogin(String email, String password) {
        String sql = "SELECT COUNT(*) FROM CUSTOMER WHERE EMAIL = ? AND PASSWORD = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    LOGGER.info("Login validated for email: " + email);
                    return true;
                }
                LOGGER.warning("Invalid login attempt for email: " + email);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error validating login: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean isEmailUnique(String email) {
        String sql = "SELECT COUNT(*) FROM CUSTOMER WHERE EMAIL = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error checking email uniqueness: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }
}