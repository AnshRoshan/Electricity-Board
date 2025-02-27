package com.anshroshan.electric.model;

public class User {
    private String userId;      // Unique identifier for the user (5-20 characters)
    private String password;    // Hashed password
    private String role;        // "Customer" or "Admin" (optional for future use)

    // Default constructor
    public User() {}

    // Getters and Setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}