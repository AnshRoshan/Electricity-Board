package com.anshroshan.electric.controller.customer;

import com.anshroshan.electric.model.Bill;
import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.service.BillService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private BillService billService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInCustomer") == null) {
            response.sendRedirect("login");
            return;
        }

        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        try {
            Bill latestBill = billService.getLatestBill(customer.getConsumerNumber());
            request.setAttribute("customer", customer);
            request.setAttribute("latestBill", latestBill);
            request.getRequestDispatcher("/WEB-INF/views/customer/home.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while loading the home page.");
            request.getRequestDispatcher("/WEB-INF/views/customer/home.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if ("logout".equals(request.getParameter("action"))) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login");
        }
    }
}