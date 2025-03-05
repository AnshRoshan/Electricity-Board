package com.anshroshan.electric.models;

import java.sql.Date;

public class Bill {
    private String billId;
    private long consumerNumber;
    private double amount;
    private String period;
    private Date billDate;
    private Date dueDate;
    private Date disconsumerDate;
    private double lateFee;
    private String status;
    private String ConsumerType;
    private String ConsumerStatus;
    private Date PaymentDate;

    // Default constructor
    public Bill() {
    }

    // Parameterized constructor
    public Bill(String billId, long consumerNumber, double amount, String period,
            Date billDate, Date dueDate, Date disconsumerDate, double lateFee, String status, String ConsumerType,
            String ConsumerStatus) {
        this.billId = billId;
        this.consumerNumber = consumerNumber;
        this.amount = amount;
        this.period = period;
        this.billDate = billDate;
        this.dueDate = dueDate;
        this.disconsumerDate = disconsumerDate;
        this.lateFee = lateFee;
        this.status = status;
        this.ConsumerType = ConsumerType;
        this.ConsumerStatus = ConsumerStatus;
        this.PaymentDate = null;
    }

    // Parameterized constructor
    public Bill(String billId, long consumerNumber, double amount, String period,
            Date billDate, Date dueDate, Date disconsumerDate, double lateFee, String status, String ConsumerType,
            String ConsumerStatus, Date PaymentDate) {
        this.billId = billId;
        this.consumerNumber = consumerNumber;
        this.amount = amount;
        this.period = period;
        this.billDate = billDate;
        this.dueDate = dueDate;
        this.disconsumerDate = disconsumerDate;
        this.lateFee = lateFee;
        this.status = status;
        this.ConsumerType = ConsumerType;
        this.ConsumerStatus = ConsumerStatus;
        this.PaymentDate = PaymentDate;
    }

    // Getters and Setters
    public String getBillId() {
        return billId;
    }

    public void setBillId(String billId) {
        this.billId = billId;
    }

    public long getConsumerNumber() {
        return consumerNumber;
    }

    public void setConsumerNumber(long consumerNumber) {
        this.consumerNumber = consumerNumber;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getDisconsumerDate() {
        return disconsumerDate;
    }

    public void setDisconsumerDate(Date disconsumerDate) {
        this.disconsumerDate = disconsumerDate;
    }

    public double getLateFee() {
        return lateFee;
    }

    public void setLateFee(double lateFee) {
        this.lateFee = lateFee;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getConsumerType() {
        return ConsumerType;
    }

    public void setConsumerType(String ConsumerType) {
        this.ConsumerType = ConsumerType;
    }

    public String getConsumerStatus() {
        return ConsumerStatus;
    }

    public void setConsumerStatus(String ConsumerStatus) {
        this.ConsumerStatus = ConsumerStatus;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId='" + billId + '\'' +
                ", consumerNumber=" + consumerNumber +
                ", amount=" + amount +
                ", period='" + period + '\'' +
                ", billDate=" + billDate +
                ", dueDate=" + dueDate +
                ", disconsumerDate=" + disconsumerDate +
                ", lateFee=" + lateFee +
                ", status='" + status + '\'' +
                '}';
    }

    public Date getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        PaymentDate = paymentDate;
    }
}