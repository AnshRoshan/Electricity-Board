package com.anshroshan.electrictymanagement.servlet;

import com.anshroshan.electrictymanagement.models.Customer;
import com.anshroshan.electrictymanagement.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Special admin login
            if ("admin".equals(email) && "admin".equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("isAdmin", true);
                response.sendRedirect("admin/bills"); // Redirect to admin page
                return;
            }

            // Special Customer login
            if ("ansh".equals(email) && "ansh".equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", new Customer());
                session.setAttribute("isAdmin", false);
                response.sendRedirect("home"); // Redirect to customer home page
                return;
            }

            // Customer login
            Customer customer = customerService.login(email, password);
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            session.setAttribute("isAdmin", false);
            response.sendRedirect("home"); // Redirect to customer home page
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}