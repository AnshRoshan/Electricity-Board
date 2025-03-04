package com.anshroshan.electric.models;

import java.util.ArrayList;

public class Consumer {
    private long consumerNumber; // BIGINT PRIMARY KEY
    private String customerId; // VARCHAR(64) FOREIGN KEY
    private String address; // VARCHAR(256)
    private String consumerType; // VARCHAR(32)
    private String status; // VARCHAR(32)
    private ArrayList<Bill> bills;

    // Constructors
    public Consumer() {
    }

    // Constructor without bills
    public Consumer(long consumerNumber, String customerId, String address, String consumerType, String status) {
        this.consumerNumber = consumerNumber;
        this.customerId = customerId;
        this.address = address;
        this.consumerType = consumerType;
        this.status = status;
        this.bills = new ArrayList<>(); // Default empty list
    }

    // Constructor with bills (calls the first constructor)
    public Consumer(long consumerNumber, String customerId, String address, String consumerType, String status,
            ArrayList<Bill> bills) {
        this(consumerNumber, customerId, address, consumerType, status); // Calls the first constructor
        this.bills = (bills != null) ? bills : new ArrayList<>();
    }

    public ArrayList<Bill> getBills() {
        return bills;
    }

    public void setBills(ArrayList<Bill> bills) {
        this.bills = bills;
    }

    // Getters and Setters
    public long getConsumerNumber() {
        return consumerNumber;
    }

    public void setConsumerNumber(long consumerNumber) {
        this.consumerNumber = consumerNumber;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getConsumerType() {
        return consumerType;
    }

    public void setConsumerType(String consumerType) {
        this.consumerType = consumerType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}