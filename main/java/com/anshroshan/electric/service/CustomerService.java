package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.BillDAO;
import com.anshroshan.electric.dao.ConsumerDAO;
import com.anshroshan.electric.dao.CustomerDAO;
import com.anshroshan.electric.dao.PaymentDAO;
import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Consumer;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.models.Payment;
import com.anshroshan.electric.util.ValidationUtil;

import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class CustomerService {

    private final CustomerDAO customerDAO;
    private final ConsumerDAO consumerDAO;
    private final BillDAO billDAO;
    private final PaymentDAO paymentDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
        this.consumerDAO = new ConsumerDAO();
        this.billDAO = new BillDAO();
        this.paymentDAO = new PaymentDAO();
    }

    public String registerCustomer(String consumerNumberStr, String title, String name, String address,
            String mobileStr,
            String email, String customerType, String customerID, String password, String confirmPassword)
            throws SQLException {

        // Validate inputs
        if (!ValidationUtil.isValidConsumerNumber(consumerNumberStr)) {
            return "Please enter a valid ConsumerNumber (13 digits).";
        }
        if (!ValidationUtil.isValidName(name)) {
            return "Please enter a valid Full Name (only characters, max 50).";
        }
        if (!ValidationUtil.isValidAddress(address)) {
            return "Address must be at least 10 characters long.";
        }
        if (!ValidationUtil.isValidMobile(mobileStr)) {
            return "Mobile number is invalid (must be 10 digits).";
        }
        if (!ValidationUtil.isValidEmail(email)) {
            return "Incorrect email format.";
        }
        if (!ValidationUtil.isValidCustomerType(customerType)) {
            return "Customer Type must be Residential or Commercial.";
        }
        if (!ValidationUtil.isValidUserId(customerID)) {
            return "User ID must be exactly 32 characters generated UUID.";
        }
        if (!ValidationUtil.isValidPassword(password)) {
            return "Password must be at least 8 characters with one uppercase, lowercase, number, and special character.";
        }
        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            return "Passwords do not match.";
        }

        long consumerNumber = Long.parseLong(consumerNumberStr);
        long mobile = Long.parseLong(mobileStr);

        // Check uniqueness
        if (customerDAO.isEmailOrMobileExists(email, mobile)) {
            return "Email or Mobile number already exists.";
        }
        if (customerDAO.isCustomerIdExists(customerID)) {
            return "User ID already exists. Please choose a different User ID.";
        }
        if (consumerDAO.isConsumerNumberExists(consumerNumber)) {
            return "ConsumerNumber already exists.";
        }

        // Create and save customer
        Consumerconsumer = new Consumer(consumerNumber, customerID, address, customerType, "Active");
        Customer customer = new Customer(customerID, title, name, address, mobile, email, password, consumer);
        boolean customerAdded = customerDAO.addCustomer(customer);
        if (!customerAdded) {
            return "Failed to register customer. Please try again.";
        }

        return "Registration successful! Customer ID: " + customerID + ", Name: " + name + ", Email: " + email;
    }

    public Customer login(String customerID, String password) throws SQLException {
        System.out.println("Login Customer ID :-" + customerID);
        System.out.println("Login PassWord :- " + password);
        Customer customer = customerDAO.getCustomerById(customerID);
        System.out.println("User :--> " + customer);
        if (customer != null && customer.getPassword().equals(password)) {
            return customer;
        }
        return null;
    }

    public Customer getCustomerDetails(String customerId) throws SQLException {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null) {
            List<Consumer> consumers = consumerDAO.getConsumersByCustomerId(customerId);
            for (Consumerconsumer : consumers) {
                List<Bill> bills = billDAO.getAllBills(customerId);
                consumer.setBills((ArrayList<Bill>) bills);
            }
            customer.setConsumerList((ArrayList<Consumer>) consumers);
        }
        return customer;
    }

    // New method for payment processing
    public void processPayment(Payment payment, String[] billIds) throws SQLException {
        // Save payment
        paymentDAO.savePayment(payment);
        // Update bill statuses to "Paid"
        for (String billId : billIds) {
            billDAO.updateBillStatus(billId, "Paid");
        }
    }

    public List<Bill> getBillHistory(String customerId, Date startDate, Date endDate) throws SQLException {
        return billDAO.getBillsByDateRange(customerId, startDate, endDate);
    }

}