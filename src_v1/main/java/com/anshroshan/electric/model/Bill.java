package com.anshroshan.electric.model;

public class Bill {
    private String billId;          // Unique identifier for the bill
    private String consumerNumber;  // Consumer ID linked to the bill
    private String billNumber;      // Optional bill number for reference (if needed)
    private String billingPeriod;   // e.g., "June 2024"
    private String billDate;        // Date the bill was generated
    private String dueDate;         // Payment due date
    private String disconnectionDate; // Optional disconnection date
    private double billAmount;      // Total bill amount
    private double lateFee;         // Optional late fee
    private String status;          // "Unpaid" or "Paid"
    private String paymentDate;     // Date of payment (if paid)

    // Default constructor
    public Bill() {}

    // Getters and Setters
    public String getBillId() { return billId; }
    public void setBillId(String billId) { this.billId = billId; }

    public String getConsumerNumber() { return consumerNumber; }
    public void setConsumerNumber(String consumerNumber) { this.consumerNumber = consumerNumber; }

    public String getBillNumber() { return billNumber; }
    public void setBillNumber(String billNumber) { this.billNumber = billNumber; }

    public String getBillingPeriod() { return billingPeriod; }
    public void setBillingPeriod(String billingPeriod) { this.billingPeriod = billingPeriod; }

    public String getBillDate() { return billDate; }
    public void setBillDate(String billDate) { this.billDate = billDate; }

    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }

    public String getDisconnectionDate() { return disconnectionDate; }
    public void setDisconnectionDate(String disconnectionDate) { this.disconnectionDate = disconnectionDate; }

    public double getBillAmount() { return billAmount; }
    public void setBillAmount(double billAmount) { this.billAmount = billAmount; }

    public double getLateFee() { return lateFee; }
    public void setLateFee(double lateFee) { this.lateFee = lateFee; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }
}