package com.anshroshan.electric.controller.customer;

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

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String consumerNumber = request.getParameter("consumerNumber");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String mobileNumber = request.getParameter("mobileNumber");
        String customerType = request.getParameter("customerType");
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            if (!ValidationUtil.isValidConsumerNumber(consumerNumber)) {
                request.setAttribute("error", "Please enter a valid Consumer Number.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (customerService.isConsumerNumberExists(consumerNumber)) {
                request.setAttribute("error", "Consumer Number already exists.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidName(fullName)) {
                request.setAttribute("error", "Full Name must contain only letters and be less than 50 characters.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidAddress(address)) {
                request.setAttribute("error", "Address must be at least 10 characters long.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Incorrect email format.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (customerService.isEmailExists(email)) {
                request.setAttribute("error", "Email already exists.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidMobileNumber(mobileNumber)) {
                request.setAttribute("error", "Mobile number is invalid.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidUserId(userId)) {
                request.setAttribute("error", "User ID must be between 5 and 20 characters.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (customerService.isUserIdExists(userId)) {
                request.setAttribute("error", "User ID already exists. Please choose a different User ID.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidPassword(password)) {
                request.setAttribute("error", "Password must be at least 8 characters with one uppercase, lowercase, number, and special character.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match.");
                request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
                return;
            }

            String customerId = "CUST" + new Random().nextInt(90000) + 10000;

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setConsumerNumber(consumerNumber);
            customer.setFullName(fullName);
            customer.setAddress(address);
            customer.setEmail(email);
            customer.setMobileNumber(mobileNumber);
            customer.setCustomerType(customerType);
            customer.setUserId(userId);
            customer.setPassword(PasswordUtil.hashPassword(password));

            customerService.registerCustomer(customer);

            request.setAttribute("message", "Registration successful!");
            request.setAttribute("customerId", customerId);
            request.setAttribute("customerName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
        }
    }
}