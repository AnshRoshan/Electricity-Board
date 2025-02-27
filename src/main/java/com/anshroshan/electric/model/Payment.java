package com.anshroshan.electric.model;

public class Payment {
    private String transactionId;    // Unique identifier for the transaction
    private String receiptNumber;    // Receipt number for the payment
    private String transactionDate;  // Date and time of the transaction
    private String transactionType;  // "Credit" or "Debit"
    private String billIds;          // Comma-separated list of bill IDs paid
    private double transactionAmount;// Total amount paid
    private String transactionStatus;// "SUCCESS" or "FAILED"

    // Default constructor
    public Payment() {}

    // Getters and Setters
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public String getReceiptNumber() { return receiptNumber; }
    public void setReceiptNumber(String receiptNumber) { this.receiptNumber = receiptNumber; }

    public String getTransactionDate() { return transactionDate; }
    public void setTransactionDate(String transactionDate) { this.transactionDate = transactionDate; }

    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }

    public String getBillIds() { return billIds; }
    public void setBillIds(String billIds) { this.billIds = billIds; }

    public double getTransactionAmount() { return transactionAmount; }
    public void setTransactionAmount(double transactionAmount) { this.transactionAmount = transactionAmount; }

    public String getTransactionStatus() { return transactionStatus; }
    public void setTransactionStatus(String transactionStatus) { this.transactionStatus = transactionStatus; }
}