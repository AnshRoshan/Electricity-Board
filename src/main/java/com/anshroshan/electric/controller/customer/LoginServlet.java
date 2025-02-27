package com.anshroshan.electric.controller.customer;

import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.service.CustomerService;
import com.anshroshan.electric.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/customer/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        try {
            Customer customer = customerService.getCustomerByUserId(userId);
            if (customer != null && PasswordUtil.hashPassword(password).equals(customer.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInCustomer", customer);
                if (password.equals("Welcome@123")) { // Check for default password
                    request.setAttribute("promptChangePassword", true);
                    request.getRequestDispatcher("/WEB-INF/views/customer/login.jsp").forward(request, response);
                } else {
                    response.sendRedirect("home");
                }
            } else {
                request.setAttribute("error", "Invalid User ID or Password");
                request.getRequestDispatcher("/WEB-INF/views/customer/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/customer/login.jsp").forward(request, response);
        }
    }
}