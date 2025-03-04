package com.anshroshan.electric.servlet;

import com.anshroshan.electric.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final CustomerService customerService;

    public RegisterServlet() {
        this.customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String consumerNumber = request.getParameter("consumerNumber");
        String title = request.getParameter("title");
        String name = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobile = request.getParameter("mobileNumber");
        String email = request.getParameter("email");
        String customerType = request.getParameter("customerType");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        // Generate a 32-character CUSTOMERID using UUID
        String customerID = generateUserId();

        try {
            String result = customerService.registerCustomer(consumerNumber, title, name, address, mobile, email,
                    customerType, customerID, password, confirmPassword);
            request.setAttribute("message", result);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("message", "An error occurred during registration. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            e.printStackTrace();
        }
    }

    private String generateUserId() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}