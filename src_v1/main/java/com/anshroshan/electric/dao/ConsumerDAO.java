package com.anshroshan.electric.dao;

import com.anshroshan.electric.model.Consumer;
import com.anshroshan.electric.util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ConsumerDAO {

    public void addConsumer(Consumer consumer) throws Exception {
        String sql = "INSERT INTO consumers (consumer_id, customer_id, address, phone_number, email, customer_type, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumer.getConsumerId());
            stmt.setString(2, consumer.getCustomerId());
            stmt.setString(3, consumer.getAddress());
            stmt.setString(4, consumer.getPhoneNumber());
            stmt.setString(5, consumer.getEmail());
            stmt.setString(6, consumer.getCustomerType());
            stmt.setString(7, consumer.getStatus() != null ? consumer.getStatus() : "Active");
            stmt.executeUpdate();
        }
    }

    public Consumer getConsumerById(String consumerId) throws Exception {
        String sql = "SELECT * FROM consumers WHERE consumer_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractConsumerFromResultSet(rs);
            }
            return null;
        }
    }

    public List<Consumer> getConsumersByCustomerId(String customerId) throws Exception {
        String sql = "SELECT * FROM consumers WHERE customer_id = ? AND status = 'Active'";
        List<Consumer> consumers = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                consumers.add(extractConsumerFromResultSet(rs));
            }
            return consumers;
        }
    }

    public void updateConsumer(Consumer consumer) throws Exception {
        String sql = "UPDATE consumers SET address = ?, phone_number = ?, email = ?, customer_type = ? WHERE consumer_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumer.getAddress());
            stmt.setString(2, consumer.getPhoneNumber());
            stmt.setString(3, consumer.getEmail());
            stmt.setString(4, consumer.getCustomerType());
            stmt.setString(5, consumer.getConsumerId());
            stmt.executeUpdate();
        }
    }

    public void softDeleteConsumer(String consumerId) throws Exception {
        String sql = "UPDATE consumers SET status = 'Inactive' WHERE consumer_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerId);
            stmt.executeUpdate();
        }
    }

    private Consumer extractConsumerFromResultSet(ResultSet rs) throws Exception {
        Consumer consumer = new Consumer();
        consumer.setConsumerId(rs.getString("consumer_id"));
        consumer.setCustomerId(rs.getString("customer_id"));
        consumer.setAddress(rs.getString("address"));
        consumer.setPhoneNumber(rs.getString("phone_number"));
        consumer.setEmail(rs.getString("email"));
        consumer.setCustomerType(rs.getString("customer_type"));
        consumer.setStatus(rs.getString("status"));
        return consumer;
    }
}