package com.anshroshan.electrictymanagement.dao;

import com.anshroshan.electrictymanagement.models.Consumer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ConsumerDAO {
    private static final Logger LOGGER = Logger.getLogger(ConsumerDAO.class.getName());

    public boolean addConsumer(Consumer consumer) {
        String sql = "INSERT INTO CONSUMER (CONSUMERNUMBER, CUSTOMERID, ADDRESS, CONSUMERTYPE, STATUS) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumer.getConsumerNumber());
                stmt.setString(2, consumer.getCustomerId());
                stmt.setString(3, consumer.getAddress());
                stmt.setString(4, consumer.getConsumerType());
                stmt.setString(5, consumer.getStatus());
                int rows = stmt.executeUpdate();
                LOGGER.info("Consumer added successfully: " + consumer.getConsumerNumber());
                return rows > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error adding consumer: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public Consumer getConsumerByNumber(long consumerNumber) {
        String sql = "SELECT * FROM CONSUMER WHERE CONSUMERNUMBER = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Consumer consumer = new Consumer(
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getString("CUSTOMERID"),
                            rs.getString("ADDRESS"),
                            rs.getString("CONSUMERTYPE"),
                            rs.getString("STATUS")
                    );
                    LOGGER.info("Consumer retrieved: " + consumerNumber);
                    return consumer;
                }
                LOGGER.warning("No consumer found with number: " + consumerNumber);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving consumer: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean updateConsumer(Consumer consumer) {
        String sql = "UPDATE CONSUMER SET ADDRESS = ?, CONSUMERTYPE = ?, STATUS = ? WHERE CONSUMERNUMBER = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, consumer.getAddress());
                stmt.setString(2, consumer.getConsumerType());
                stmt.setString(3, consumer.getStatus());
                stmt.setLong(4, consumer.getConsumerNumber());
                int rows = stmt.executeUpdate();
                LOGGER.info("Consumer updated successfully: " + consumer.getConsumerNumber());
                return rows > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error updating consumer: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean softDeleteConsumer(long consumerNumber) {
        String sql = "UPDATE CONSUMER SET STATUS = 'Inactive' WHERE CONSUMERNUMBER = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                int rows = stmt.executeUpdate();
                LOGGER.info("Consumer soft-deleted successfully: " + consumerNumber);
                return rows > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error soft-deleting consumer: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Consumer> getConsumersByCustomerId(String customerId) {
        String sql = "SELECT * FROM CONSUMER WHERE CUSTOMERID = ?";
        List<Consumer> consumers = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Consumer consumer = new Consumer(
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getString("CUSTOMERID"),
                            rs.getString("ADDRESS"),
                            rs.getString("CONSUMERTYPE"),
                            rs.getString("STATUS")
                    );
                    consumers.add(consumer);
                }
                LOGGER.info("Consumers retrieved for customer: " + customerId);
                return consumers;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving consumers: " + e.getMessage());
            return consumers;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean isConsumerNumberUnique(long consumerNumber) {
        String sql = "SELECT COUNT(*) FROM CONSUMER WHERE CONSUMERNUMBER = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error checking consumer number uniqueness: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }
}