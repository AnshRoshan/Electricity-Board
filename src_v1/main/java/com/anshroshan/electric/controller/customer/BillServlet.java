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
import java.util.List;

@WebServlet("/view-bills")
public class BillServlet extends HttpServlet {

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
            List<Bill> bills = billService.getBillsByConsumerNumber(customer.getConsumerNumber());
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load bills. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String[] selectedBillIds = request.getParameterValues("selectedBills");
        if (selectedBillIds != null && selectedBillIds.length > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("selectedBillIds", selectedBillIds);
            response.sendRedirect("bill-summary");
        } else {
            request.setAttribute("error", "Please select at least one bill to proceed.");
            doGet(request, response);
        }
    }
}