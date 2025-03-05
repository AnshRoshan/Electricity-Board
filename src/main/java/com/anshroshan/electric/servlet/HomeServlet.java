package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        this.customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        System.out.println("1. execution reached here");

        try {
            Customer customer = (Customer) session.getAttribute("customer");
            String customerId = customer.getCustomerId();
//            Bill latestBill = customerService.getLatestUnpaidBill(customerId);
            Bill latestBill = new Bill();
            System.out.println("2. xecution reached here");
            response.sendRedirect("customerHome.jsp");
            session.setAttribute("latestBill", latestBill);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading the home page.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}