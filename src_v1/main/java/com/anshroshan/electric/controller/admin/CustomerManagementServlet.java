package com.anshroshan.electric.controller.admin;

import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.service.CustomerService;
import com.anshroshan.electric.util.PasswordUtil;
import com.anshroshan.electric.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;

@WebServlet("/admin/add-customer")
public class CustomerManagementServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/add-customer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String consumerNumber = request.getParameter("consumerNumber");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String customerType = request.getParameter("customerType");
        String userId = request.getParameter("userId");

        try {
            // Validation
            if (!ValidationUtil.isValidName(fullName)) {
                request.setAttribute("error", "Full Name must contain only letters and be less than 50 characters.");
                doGet(request, response);
                return;
            }
            if (!ValidationUtil.isValidAddress(address)) {
                request.setAttribute("error", "Address must be at least 10 characters long.");
                doGet(request, response);
                return;
            }
            if (!ValidationUtil.isValidConsumerNumber(consumerNumber) || customerService.isConsumerNumberExists(consumerNumber)) {
                request.setAttribute("error", "Invalid or duplicate Consumer Number.");
                doGet(request, response);
                return;
            }
            if (!ValidationUtil.isValidMobileNumber(phoneNumber)) {
                request.setAttribute("error", "Invalid phone number.");
                doGet(request, response);
                return;
            }
            if (!ValidationUtil.isValidEmail(email) || customerService.isEmailExists(email)) {
                request.setAttribute("error", "Invalid or duplicate email.");
                doGet(request, response);
                return;
            }
            if (!ValidationUtil.isValidUserId(userId) || customerService.isUserIdExists(userId)) {
                request.setAttribute("error", "User ID must be 5-20 characters and unique.");
                doGet(request, response);
                return;
            }

            // Generate random Customer ID and default password
            String customerId = "CUST" + new Random().nextInt(90000) + 10000;
            String defaultPassword = "Welcome@123"; // Default password

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setFullName(fullName);
            customer.setAddress(address);
            customer.setConsumerNumber(consumerNumber);
            customer.setMobileNumber(phoneNumber);
            customer.setEmail(email);
            customer.setCustomerType(customerType);
            customer.setUserId(userId);
            customer.setPassword(PasswordUtil.hashPassword(defaultPassword));

            customerService.registerCustomer(customer);

            request.setAttribute("customerId", customerId);
            request.setAttribute("customerName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("success", "Customer added successfully. Please add one or more Consumer IDs to complete the setup.");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-customer.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to add customer. Please try again.");
            doGet(request, response);
        }
    }
}