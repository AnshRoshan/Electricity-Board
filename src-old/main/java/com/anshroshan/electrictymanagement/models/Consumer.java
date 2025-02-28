package com.anshroshan.electrictymanagement.models;


public class Consumer {
    private long consumerNumber; // BIGINT PRIMARY KEY
    private String customerId;   // VARCHAR(64) NOT NULL, FK to CUSTOMER
    private String address;      // VARCHAR(256)
    private String consumerType; // VARCHAR(32)
    private String status;       // VARCHAR(32)

    // Default constructor
    public Consumer() {}

    // Parameterized constructor
    public Consumer(long consumerNumber, String customerId, String address, String consumerType, String status) {
        this.consumerNumber = consumerNumber;
        this.customerId = customerId;
        this.address = address;
        this.consumerType = consumerType;
        this.status = status;
    }

    // Getters and Setters
    public long getConsumerNumber() { return consumerNumber; }
    public void setConsumerNumber(long consumerNumber) { this.consumerNumber = consumerNumber; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getConsumerType() { return consumerType; }
    public void setConsumerType(String consumerType) { this.consumerType = consumerType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Consumer{" +
                "consumerNumber=" + consumerNumber +
                ", customerId='" + customerId + '\'' +
                ", address='" + address + '\'' +
                ", consumerType='" + consumerType + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}