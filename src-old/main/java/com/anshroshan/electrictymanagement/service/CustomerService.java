package com.anshroshan.electrictymanagement.service;

import com.anshroshan.electrictymanagement.dao.CustomerDAO;
import com.anshroshan.electrictymanagement.models.Customer;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class CustomerService {
    private static final Logger LOGGER = Logger.getLogger(CustomerService.class.getName());
    private final CustomerDAO customerDAO = new CustomerDAO();

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    public String registerCustomer(String title, String name, String address, long mobile, String email, String password, String confirmPassword) {
        // Validation
        if (name == null || name.trim().isEmpty() || name.length() > 50 || !name.matches("[a-zA-Z ]+")) {
            LOGGER.warning("Invalid name: " + name);
            throw new IllegalArgumentException("Full Name is required, max 50 characters, letters only.");
        }
        if (address == null || address.trim().isEmpty() || address.length() < 10) {
            LOGGER.warning("Invalid address: " + address);
            throw new IllegalArgumentException("Address is required, minimum 10 characters.");
        }
        if (String.valueOf(mobile).length() != 10 || mobile < 0) {
            LOGGER.warning("Invalid mobile number: " + mobile);
            throw new IllegalArgumentException("Mobile number must be 10 digits.");
        }
        if (!Pattern.matches(EMAIL_REGEX, email)) {
            LOGGER.warning("Invalid email format: " + email);
            throw new IllegalArgumentException("Incorrect email format.");
        }
        if (!customerDAO.isEmailUnique(email)) {
            LOGGER.warning("Email already exists: " + email);
            throw new IllegalArgumentException("Email already exists.");
        }
        if (!Pattern.matches(PASSWORD_REGEX, password)) {
            LOGGER.warning("Password does not meet complexity requirements.");
            throw new IllegalArgumentException("Password must be 8+ characters with uppercase, lowercase, number, and special character.");
        }
        if (!password.equals(confirmPassword)) {
            LOGGER.warning("Passwords do not match.");
            throw new IllegalArgumentException("Passwords do not match.");
        }

        Customer customer = new Customer(null, title, name, address, mobile, email, password);
        String customerId = customerDAO.addCustomer(customer);
        if (customerId != null) {
            LOGGER.info("Customer registered successfully: " + customerId);
            return customerId;
        } else {
            LOGGER.severe("Failed to register customer.");
            throw new RuntimeException("Registration failed. Please try again.");
        }
    }

    public Customer login(String email, String password) {
        if (customerDAO.validateLogin(email, password)) {
            Customer customer = customerDAO.getCustomerById(getCustomerIdByEmail(email));
            LOGGER.info("Login successful for email: " + email);
            return customer;
        } else {
            LOGGER.warning("Login failed for email: " + email);
            throw new IllegalArgumentException("Invalid email or password.");
        }
    }

    public Customer getCustomer(String customerId) {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null) {
            LOGGER.info("Customer fetched: " + customerId);
            return customer;
        } else {
            LOGGER.warning("Customer not found: " + customerId);
            throw new IllegalArgumentException("Customer not found.");
        }
    }

    private String getCustomerIdByEmail(String email) {
        // Helper method to fetch customer ID by email (not directly supported by DAO, so simulating here)
        Customer customer = customerDAO.getCustomerById(email); // Assuming email is unique
        return customer != null ? customer.getCustomerId() : null;
    }
}