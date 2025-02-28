package com.anshroshan.electrictymanagement.models;


import java.time.LocalDate;

public class Bill {
    private String billId;          // VARCHAR(64) PRIMARY KEY
    private long consumerNumber;    // BIGINT NOT NULL, FK to CONSUMER
    private double amount;          // DOUBLE PRECISION
    private String period;          // VARCHAR(32)
    private LocalDate billDate;     // DATE
    private LocalDate dueDate;      // DATE
    private LocalDate disconnection;// DATE
    private double lateFee;         // DOUBLE PRECISION
    private String status;          // VARCHAR(32)

    // Default constructor
    public Bill() {}

    // Parameterized constructor
    public Bill(String billId, long consumerNumber, double amount, String period, LocalDate billDate,
                LocalDate dueDate, LocalDate disconnection, double lateFee, String status) {
        this.billId = billId;
        this.consumerNumber = consumerNumber;
        this.amount = amount;
        this.period = period;
        this.billDate = billDate;
        this.dueDate = dueDate;
        this.disconnection = disconnection;
        this.lateFee = lateFee;
        this.status = status;
    }

    // Getters and Setters
    public String getBillId() { return billId; }
    public void setBillId(String billId) { this.billId = billId; }

    public long getConsumerNumber() { return consumerNumber; }
    public void setConsumerNumber(long consumerNumber) { this.consumerNumber = consumerNumber; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }

    public LocalDate getBillDate() { return billDate; }
    public void setBillDate(LocalDate billDate) { this.billDate = billDate; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public LocalDate getDisconnection() { return disconnection; }
    public void setDisconnection(LocalDate disconnection) { this.disconnection = disconnection; }

    public double getLateFee() { return lateFee; }
    public void setLateFee(double lateFee) { this.lateFee = lateFee; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Bill{" +
                "billId='" + billId + '\'' +
                ", consumerNumber=" + consumerNumber +
                ", amount=" + amount +
                ", period='" + period + '\'' +
                ", billDate=" + billDate +
                ", dueDate=" + dueDate +
                ", disconnection=" + disconnection +
                ", lateFee=" + lateFee +
                ", status='" + status + '\'' +
                '}';
    }
}