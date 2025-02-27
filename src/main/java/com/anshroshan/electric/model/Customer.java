package com.anshroshan.electric.model;

public class Customer {
    private String customerId;      // Unique identifier for the customer (e.g., "CUST12345")
    private String fullName;        // Customer's full name
    private String address;         // Customer's billing address
    private String consumerNumber;  // Initial consumer number (13 digits)
    private String mobileNumber;    // Customer phone number (10 digits)
    private String email;           // Customer email
    private String customerType;    // "Residential" or "Commercial"
    private String userId;          // Login user ID (5-20 characters)
    private String password;        // Hashed password

    // Default constructor
    public Customer() {}

    // Getters and Setters
    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getConsumerNumber() { return consumerNumber; }
    public void setConsumerNumber(String consumerNumber) { this.consumerNumber = consumerNumber; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCustomerType() { return customerType; }
    public void setCustomerType(String customerType) { this.customerType = customerType; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}