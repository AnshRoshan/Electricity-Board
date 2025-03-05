package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.BillDAO;
import com.anshroshan.electric.dao.PaymentDAO;
import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Payment;

import java.sql.Date;
import java.sql.SQLException;
import java.util.UUID;

/**
 * Service class for handling payment-related business logic
 */
public class PaymentService {

    private final PaymentDAO paymentDAO;
    private final BillDAO billDAO;

    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
        this.billDAO = new BillDAO();
    }

    /**
     * Process a payment for one or more bills
     * 
     * @param amount     The payment amount
     * @param billIds    Array of bill IDs to be paid
     * @param method     The payment method
     * @param customerId The customer ID
     * @return The transaction ID if successful
     * @throws SQLException If a database error occurs
     */
    public String processPayment(double amount, String[] billIds, String method, String customerId)
            throws SQLException {
        // Generate a transaction ID
        String transactionId = UUID.randomUUID().toString();

        // Create a payment record
        Payment payment = new Payment(
                transactionId,
                new Date(System.currentTimeMillis()),
                amount,
                billIds,
                "Completed",
                method,
                customerId);

        // Save the payment
        paymentDAO.savePayment(payment);

        // Update the status of each bill to "Paid"
        Date paymentDate = new Date(System.currentTimeMillis());
        for (String billId : billIds) {
            billDAO.updateBillStatus(billId, "Paid", paymentDate);
        }

        return transactionId;
    }

    /**
     * Validate payment amount against bill total
     * 
     * @param amount  The payment amount
     * @param billIds Array of bill IDs to be paid
     * @return true if the amount is valid, false otherwise
     * @throws SQLException If a database error occurs
     */
    public boolean validatePaymentAmount(double amount, String[] billIds) throws SQLException {
        double totalDue = 0.0;

        for (String billId : billIds) {
            Bill bill = billDAO.getBillByBillId(billId);
            if (bill != null && !"Paid".equals(bill.getStatus())) {
                totalDue += bill.getAmount() + bill.getLateFee();
            }
        }

        // Allow a small difference to account for rounding errors
        return Math.abs(amount - totalDue) < 0.01;
    }
}