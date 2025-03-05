package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.CustomerDAO;
import com.anshroshan.electric.model.Customer;

public class CustomerService {

    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    // Register a new customer (US001, US010)
    public void registerCustomer(Customer customer) throws Exception {
        customerDAO.addCustomer(customer);
    }

    // Check if consumer number exists (US001, US010)
    public boolean isConsumerNumberExists(String consumerNumber) throws Exception {
        return customerDAO.getCustomerByConsumerNumber(consumerNumber) != null;
    }

    // Check if email exists (US001, US010)
    public boolean isEmailExists(String email) throws Exception {
        return customerDAO.getCustomerByEmail(email) != null;
    }

    // Check if user ID exists (US001, US010)
    public boolean isUserIdExists(String userId) throws Exception {
        return customerDAO.getCustomerByUserId(userId) != null;
    }

    // Get customer by user ID (for login - US002)
    public Customer getCustomerByUserId(String userId) throws Exception {
        return customerDAO.getCustomerByUserId(userId);
    }

    // Get customer by ID (US010, US011)
    public Customer getCustomerById(String customerId) throws Exception {
        return customerDAO.getCustomerById(customerId);
    }
}