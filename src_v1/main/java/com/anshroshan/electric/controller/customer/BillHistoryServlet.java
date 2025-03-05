package com.anshroshan.electric.controller.customer;

import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.model.Bill;
import com.anshroshan.electric.service.BillService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/bill-history")
public class BillHistoryServlet extends HttpServlet {

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
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String statusFilter = request.getParameter("statusFilter");

        if (startDate == null || endDate == null) {
            endDate = LocalDate.now().toString();
            startDate = LocalDate.now().minusMonths(6).toString();
        }

        try {
            List<Bill> bills = billService.getBillHistory(customer.getConsumerNumber(), null, statusFilter);
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("/WEB-INF/views/customer/bill-history.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load bill history. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/customer/bill-history.jsp").forward(request, response);
        }
    }
}