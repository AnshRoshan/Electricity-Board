package com.anshroshan.electric.dao;

import com.anshroshan.electric.models.Consumer;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.util.DatabaseUtil;

import java.sql.Consumer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerDAO {

    private final ConsumerDAO consumerDAO;
    private final BillDAO billDAO;

    public CustomerDAO() {
        this.consumerDAO = new ConsumerDAO();
        this.billDAO = new BillDAO();
    }

    public boolean isEmailOrMobileExists(String email, long mobile) throws SQLException {
        String query = "SELECT COUNT(*) FROM CUSTOMER WHERE EMAIL = ? OR MOBILE = ?";
        try (Consumer conn = DatabaseUtil.getConsumer()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, email);
                stmt.setLong(2, mobile);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
                return false;
            }
        }
    }

    public boolean isCustomerIdExists(String userId) throws SQLException {
        String query = "SELECT COUNT(*) FROM CUSTOMER WHERE CUSTOMERID = ?";
        try (Consumer conn = DatabaseUtil.getConsumer();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        }
    }

    public boolean addCustomer(Customer customer) throws SQLException {
        String query = "INSERT INTO CUSTOMER (CUSTOMERID, TITLE, NAME, ADDRESS, MOBILE, EMAIL, PASSWORD) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Consumer conn = DatabaseUtil.getConsumer()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, customer.getCustomerId());
                stmt.setString(2, customer.getTitle());
                stmt.setString(3, customer.getName());
                stmt.setString(4, customer.getAddress());
                stmt.setLong(5, customer.getMobile());
                stmt.setString(6, customer.getEmail());
                stmt.setString(7, customer.getPassword());
                return stmt.executeUpdate() > 0;
            }
        }
    }

    public Customer getCustomerById(String customerId) throws SQLException {
        customerId = customerId.trim();
        String query = "SELECT * FROM CUSTOMER WHERE CUSTOMERID = ? ";
        try (Consumer conn = DatabaseUtil.getConsumer()) {
            assert conn != null; // Ensure consumer is not null
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return new Customer(
                            rs.getString("CUSTOMERID"),
                            rs.getString("TITLE"),
                            rs.getString("NAME"),
                            rs.getString("ADDRESS"),
                            rs.getLong("MOBILE"),
                            rs.getString("EMAIL"),
                            rs.getString("PASSWORD"),
                            (ArrayList<Consumer>) consumerDAO.getConsumersByCustomerId(customerId));
                }
                return null; // Return null if no customer is found
            }
        }
    }
}