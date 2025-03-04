package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final CustomerService customerService;

    public LoginServlet() {
        this.customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("customerId");
        String password = request.getParameter("password");

        try {
            Customer customer = customerService.login(userId, password);
            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                session.setAttribute("customerId", customer.getCustomerId());
                // using sendRedirect
                System.out.println("Session : "+session.getAttribute("customer"));
                Customer cu= (Customer) session.getAttribute("customer");
                System.out.println("Session id: "+ cu.getCustomerId());

                response.sendRedirect("customerHome.jsp");
            } else {
                request.setAttribute("error", "Invalid User ID or Password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Login failed due to a server error.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}