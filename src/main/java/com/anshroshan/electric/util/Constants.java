package com.anshroshan.electric.util;

public class Constants {
    // Database configuration constants (adjust as needed)
    public static final String DB_URL = "jdbc:postgresql://localhost:5432/electricity_board";
    public static final String DB_USER = "your_username";
    public static final String DB_PASSWORD = "your_password";

    // Status constants
    public static final String STATUS_ACTIVE = "Active";
    public static final String STATUS_INACTIVE = "Inactive";
    public static final String BILL_STATUS_UNPAID = "Unpaid";
    public static final String BILL_STATUS_PAID = "Paid";
    public static final String COMPLAINT_STATUS_PENDING = "Pending";
    public static final String COMPLAINT_STATUS_IN_PROGRESS = "In Progress";
    public static final String COMPLAINT_STATUS_RESOLVED = "Resolved";
    public static final String COMPLAINT_STATUS_CLOSED = "Closed";
    public static final String PAYMENT_STATUS_SUCCESS = "SUCCESS";
    public static final String PAYMENT_STATUS_FAILED = "FAILED";

    // Customer type constants
    public static final String CUSTOMER_TYPE_RESIDENTIAL = "Residential";
    public static final String CUSTOMER_TYPE_COMMERCIAL = "Commercial";

    // Default values
    public static final String DEFAULT_PASSWORD = "Welcome@123";
}