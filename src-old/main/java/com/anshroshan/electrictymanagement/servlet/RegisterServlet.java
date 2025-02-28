package com.anshroshan.electrictymanagement.servlet;

import com.anshroshan.electrictymanagement.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "register",value= "/register")
public class RegisterServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            long mobile = Long.parseLong(request.getParameter("mobile"));
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            String customerId = customerService.registerCustomer(title, name, address, mobile, email, password, confirmPassword);
            request.setAttribute("message", "Registration successful! Customer ID: " + customerId + ", Name: " + name + ", Email: " + email);
            request.setAttribute("nextUrl", "login");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }
    }
}