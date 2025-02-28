package com.anshroshan.electrictymanagement.dao;

import com.anshroshan.electrictymanagement.models.Payment;
import java.sql.*;
import java.util.UUID;
import java.util.logging.Logger;

public class PaymentDAO {
    private static final Logger LOGGER = Logger.getLogger(PaymentDAO.class.getName());

    public String addPayment(Payment payment) {
        String sql = "INSERT INTO PAYMENT (TRANSACTIONID, TRANSACTIONDATE, AMOUNT, BILLS, STATUS, METHOD, CUSTOMERID) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING TRANSACTIONID";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            String transactionId = "TXN-" + UUID.randomUUID().toString().substring(0, 8);
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, transactionId);
                stmt.setDate(2, Date.valueOf(payment.getTransactionDate()));
                stmt.setDouble(3, payment.getAmount());
                stmt.setArray(4, conn.createArrayOf("TEXT", payment.getBills()));
                stmt.setString(5, payment.getStatus());
                stmt.setString(6, payment.getMethod());
                stmt.setString(7, payment.getCustomerId());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    LOGGER.info("Payment added successfully: " + transactionId);
                    return rs.getString("TRANSACTIONID");
                }
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error adding payment: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public Payment getPaymentById(String transactionId) {
        String sql = "SELECT * FROM PAYMENT WHERE TRANSACTIONID = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, transactionId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Array array = rs.getArray("BILLS");
                    String[] bills = (String[]) array.getArray();
                    Payment payment = new Payment(
                            rs.getString("TRANSACTIONID"),
                            rs.getDate("TRANSACTIONDATE").toLocalDate(),
                            rs.getDouble("AMOUNT"),
                            bills,
                            rs.getString("STATUS"),
                            rs.getString("METHOD"),
                            rs.getString("CUSTOMERID")
                    );
                    LOGGER.info("Payment retrieved: " + transactionId);
                    return payment;
                }
                LOGGER.warning("No payment found with ID: " + transactionId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving payment: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }
}