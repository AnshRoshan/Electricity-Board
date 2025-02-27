package com.anshroshan.electric.dao;

import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerDAO {

    public void addCustomer(Customer customer) throws Exception {
        String sql = "INSERT INTO customers (customer_id, full_name, address, consumer_number, mobile_number, email, customer_type, user_id, password) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getCustomerId());
            stmt.setString(2, customer.getFullName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getConsumerNumber());
            stmt.setString(5, customer.getMobileNumber());
            stmt.setString(6, customer.getEmail());
            stmt.setString(7, customer.getCustomerType());
            stmt.setString(8, customer.getUserId());
            stmt.setString(9, customer.getPassword());
            stmt.executeUpdate();
        }
    }

    public Customer getCustomerByConsumerNumber(String consumerNumber) throws Exception {
        String sql = "SELECT * FROM customers WHERE consumer_number = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        }
    }

    public Customer getCustomerByEmail(String email) throws Exception {
        String sql = "SELECT * FROM customers WHERE email = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        }
    }

    public Customer getCustomerByUserId(String userId) throws Exception {
        String sql = "SELECT * FROM customers WHERE user_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        }
    }

    public Customer getCustomerById(String customerId) throws Exception {
        String sql = "SELECT * FROM customers WHERE customer_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        }
    }

    private Customer extractCustomerFromResultSet(ResultSet rs) throws Exception {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getString("customer_id"));
        customer.setFullName(rs.getString("full_name"));
        customer.setAddress(rs.getString("address"));
        customer.setConsumerNumber(rs.getString("consumer_number"));
        customer.setMobileNumber(rs.getString("mobile_number"));
        customer.setEmail(rs.getString("email"));
        customer.setCustomerType(rs.getString("customer_type"));
        customer.setUserId(rs.getString("user_id"));
        customer.setPassword(rs.getString("password"));
        return customer;
    }
}