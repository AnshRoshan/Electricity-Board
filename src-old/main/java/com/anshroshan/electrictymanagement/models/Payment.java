package com.anshroshan.electrictymanagement.models;


import java.time.LocalDate;
import java.util.Arrays;

public class Payment {
    private String transactionId;   // VARCHAR(64) PRIMARY KEY
    private LocalDate transactionDate; // DATE
    private double amount;          // DOUBLE PRECISION
    private String[] bills;         // TEXT[] NOT NULL (array of Bill IDs)
    private String status;          // VARCHAR(32)
    private String method;          // VARCHAR(32)
    private String customerId;      // VARCHAR(64) NOT NULL, FK to CUSTOMER

    // Default constructor
    public Payment() {}

    // Parameterized constructor
    public Payment(String transactionId, LocalDate transactionDate, double amount, String[] bills,
                   String status, String method, String customerId) {
        this.transactionId = transactionId;
        this.transactionDate = transactionDate;
        this.amount = amount;
        this.bills = bills;
        this.status = status;
        this.method = method;
        this.customerId = customerId;
    }

    // Getters and Setters
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public LocalDate getTransactionDate() { return transactionDate; }
    public void setTransactionDate(LocalDate transactionDate) { this.transactionDate = transactionDate; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String[] getBills() { return bills; }
    public void setBills(String[] bills) { this.bills = bills; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    @Override
    public String toString() {
        return "Payment{" +
                "transactionId='" + transactionId + '\'' +
                ", transactionDate=" + transactionDate +
                ", amount=" + amount +
                ", bills=" + Arrays.toString(bills) +
                ", status='" + status + '\'' +
                ", method='" + method + '\'' +
                ", customerId='" + customerId + '\'' +
                '}';
    }
}