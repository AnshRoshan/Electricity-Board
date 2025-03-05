package com.anshroshan.electric.dao;

import com.anshroshan.electric.models.Payment;
import com.anshroshan.electric.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

public class PaymentDAO {

    public void savePayment(Payment payment) throws SQLException {
        String query = "INSERT INTO PAYMENT (TRANSACTIONID, TRANSACTIONDATE, AMOUNT, BILLS, STATUS, METHOD, CUSTOMERID) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                String transactionId = payment.getTransactionId() != null ? payment.getTransactionId()
                        : UUID.randomUUID().toString();
                stmt.setString(1, transactionId);
                stmt.setDate(2, payment.getTransactionDate());
                stmt.setDouble(3, payment.getAmount());
                stmt.setArray(4, conn.createArrayOf("TEXT", payment.getBills()));
                stmt.setString(5, payment.getStatus());
                stmt.setString(6, payment.getMethod());
                stmt.setString(7, payment.getCustomerId());
                stmt.executeUpdate();
                payment.setTransactionId(transactionId); // Update the payment object
            }
        }
    }
}