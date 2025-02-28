package com.anshroshan.electrictymanagement.service;

import com.anshroshan.electrictymanagement.dao.PaymentDAO;
import com.anshroshan.electrictymanagement.models.Payment;
import java.time.LocalDate;
import java.util.logging.Logger;

public class PaymentService {
    private static final Logger LOGGER = Logger.getLogger(PaymentService.class.getName());
    private final PaymentDAO paymentDAO = new PaymentDAO();

    public String processPayment(String customerId, String[] billIds, double amount, String method, String cardNumber, String expiryDate, String cvv) {
        if (billIds == null || billIds.length == 0) {
            LOGGER.warning("No bills selected for payment.");
            throw new IllegalArgumentException("Please select at least one bill.");
        }
        if (amount <= 0) {
            LOGGER.warning("Invalid payment amount: " + amount);
            throw new IllegalArgumentException("Payment amount must be positive.");
        }
        if (!"Credit".equalsIgnoreCase(method) && !"Debit".equalsIgnoreCase(method) && !"Net Banking".equalsIgnoreCase(method)) {
            LOGGER.warning("Invalid payment method: " + method);
            throw new IllegalArgumentException("Invalid payment method.");
        }
        if (cardNumber.length() != 16 || !cardNumber.matches("\\d+")) {
            LOGGER.warning("Invalid card number: " + cardNumber);
            throw new IllegalArgumentException("Card number must be 16 digits.");
        }
        if (!cvv.matches("\\d{3,4}")) {
            LOGGER.warning("Invalid CVV: " + cvv);
            throw new IllegalArgumentException("CVV must be 3 or 4 digits.");
        }
        LocalDate expiry = LocalDate.parse(expiryDate + "-01"); // Assuming format YYYY-MM
        if (expiry.isBefore(LocalDate.now())) {
            LOGGER.warning("Card expired: " + expiryDate);
            throw new IllegalArgumentException("Card has expired.");
        }

        Payment payment = new Payment(null, LocalDate.now(), amount, billIds, "Completed", method, customerId);
        String transactionId = paymentDAO.addPayment(payment);
        if (transactionId != null) {
            LOGGER.info("Payment processed successfully: " + transactionId);
            return transactionId;
        } else {
            LOGGER.severe("Failed to process payment for customer: " + customerId);
            throw new RuntimeException("Payment failed. Please try again.");
        }
    }

    public Payment getPayment(String transactionId) {
        Payment payment = paymentDAO.getPaymentById(transactionId);
        if (payment != null) {
            LOGGER.info("Payment fetched: " + transactionId);
            return payment;
        } else {
            LOGGER.warning("Payment not found: " + transactionId);
            throw new IllegalArgumentException("Payment not found.");
        }
    }
}