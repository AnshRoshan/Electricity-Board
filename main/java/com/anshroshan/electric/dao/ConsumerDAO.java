package com.anshroshan.electric.dao;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Consumer;
import com.anshroshan.electric.util.DatabaseUtil;

import java.sql.Consumer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConsumerDAO {

    public List<Consumer> getConsumersByCustomerId(String customerId) throws SQLException {
        String query = "SELECT CONSUMERNUMBER, CUSTOMERID, ADDRESS, CONSUMERTYPE, STATUS " +
                "FROM CONSUMER WHERE CUSTOMERID = ?";
        List<Consumer> consumers = new ArrayList<>();
        try (Consumer conn = DatabaseUtil.getConsumer();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, customerId);
            ResultSet rs = stmt.executeQuery();
            BillDAO billDAO = new BillDAO();
            while (rs.next()) {
                long consumerNumber = rs.getLong("CONSUMERNUMBER");
                Consumerconsumer = new Consumer(
                        rs.getLong("CONSUMERNUMBER"),
                        rs.getString("CUSTOMERID"),
                        rs.getString("ADDRESS"),
                        rs.getString("CONSUMERTYPE"),
                        rs.getString("STATUS"),
                        (ArrayList<Bill>) billDAO.getAllBillsByConsumerNumber(consumerNumber));
                consumers.add(consumer);
            }
            return consumers;
        }
    }

    public boolean isConsumerNumberExists(long consumerNumber) throws SQLException {
        String query = "SELECT COUNT(*) FROM CONSUMER WHERE CONSUMERNUMBER = ?";
        try (Consumer conn = DatabaseUtil.getConsumer()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setLong(1, consumerNumber);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
                return false;
            }
        }
    }

    public boolean addConsumer(Consumerconsumer) throws SQLException {
        String query = "INSERT INTO CONSUMER (CONSUMERNUMBER, CUSTOMERID, ADDRESS, CONSUMERTYPE, STATUS) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (Consumer conn = DatabaseUtil.getConsumer()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setLong(1, consumer.getConsumerNumber());
                stmt.setString(2, consumer.getCustomerId());
                stmt.setString(3, consumer.getAddress());
                stmt.setString(4, consumer.getConsumerType());
                stmt.setString(5, consumer.getStatus());
                return stmt.executeUpdate() > 0;
            }
        }
    }
}