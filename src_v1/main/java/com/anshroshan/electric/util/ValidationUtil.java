package com.anshroshan.electric.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[A-Za-z\\s]+$");

    // Validate 13-digit consumer number
    public static boolean isValidConsumerNumber(String consumerNumber) {
        return consumerNumber != null && consumerNumber.matches("\\d{13}");
    }

    // Validate name (letters only, max 50 characters)
    public static boolean isValidName(String name) {
        return name != null && !name.isEmpty() && name.length() <= 50 && NAME_PATTERN.matcher(name).matches();
    }

    // Validate address (minimum 10 characters)
    public static boolean isValidAddress(String address) {
        return address != null && !address.isEmpty() && address.length() >= 10;
    }

    // Validate email format
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    // Validate 10-digit mobile number
    public static boolean isValidMobileNumber(String mobileNumber) {
        return mobileNumber != null && mobileNumber.matches("\\d{10}");
    }

    // Validate user ID (5-20 characters)
    public static boolean isValidUserId(String userId) {
        return userId != null && userId.length() >= 5 && userId.length() <= 20;
    }

    // Validate password complexity
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    // Validate complaint type (predefined types)
    public static boolean isValidComplaintType(String complaintType) {
        return complaintType != null && !complaintType.isEmpty() && 
               (complaintType.equals("billing_issue") || complaintType.equals("power_outage") || complaintType.equals("meter_reading_issue"));
    }
}