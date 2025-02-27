package com.anshroshan.electric.dao;

import com.anshroshan.electric.model.Payment;
import com.anshroshan.electric.util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentDAO {

    public void savePayment(Payment payment) throws Exception {
        String sql = "INSERT INTO payments (transaction_id, receipt_number, transaction_date, transaction_type, bill_ids, transaction_amount, transaction_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, payment.getTransactionId());
            stmt.setString(2, payment.getReceiptNumber());
            stmt.setString(3, payment.getTransactionDate());
            stmt.setString(4, payment.getTransactionType());
            stmt.setString(5, payment.getBillIds());
            stmt.setDouble(6, payment.getTransactionAmount());
            stmt.setString(7, payment.getTransactionStatus());
            stmt.executeUpdate();
        }
    }
}