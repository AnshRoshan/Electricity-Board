package com.anshroshan.electrictymanagement.servlet;

import com.anshroshan.electrictymanagement.service.BillService;
import com.anshroshan.electrictymanagement.service.ConsumerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/bills")
public class AdminBillServlet extends HttpServlet {
    private final ConsumerService consumerService = new ConsumerService();
    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            response.sendRedirect("login");
            return;
        }

        // Handle bill viewing
        String consumerNumberStr = request.getParameter("consumerNumber");
        if (consumerNumberStr != null && !consumerNumberStr.isEmpty()) {
            try {
                long consumerNumber = Long.parseLong(consumerNumberStr);
                if (consumerService.getConsumer(consumerNumber) == null) {
                    request.setAttribute("error", "Consumer Number " + consumerNumber + " does not exist.");
                } else {
                    request.setAttribute("bills", billService.getBills(consumerNumber));
                    request.setAttribute("consumerNumber", consumerNumber);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Consumer Number format.");
            }
        }

        request.getRequestDispatcher("/adminBills.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            response.sendRedirect("login");
            return;
        }

        // Handle adding a new bill
        try {
            long consumerNumber = Long.parseLong(request.getParameter("consumerNumber"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String period = request.getParameter("period");
            LocalDate billDate = LocalDate.parse(request.getParameter("billDate"));
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            String disconnectionDateStr = request.getParameter("disconnectionDate");
            LocalDate disconnectionDate = (disconnectionDateStr != null && !disconnectionDateStr.isEmpty()) ? LocalDate.parse(disconnectionDateStr) : null;
            double lateFee = Double.parseDouble(request.getParameter("lateFee"));

            String billId = billService.addBill(consumerNumber, amount, period, billDate, dueDate, disconnectionDate, lateFee);
            request.setAttribute("message", "Bill added successfully! Bill ID: " + billId);
            // Optionally pre-fill the view section with the consumer's bills
            request.setAttribute("bills", billService.getBills(consumerNumber));
            request.setAttribute("consumerNumber", consumerNumber);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format in form fields.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("/adminBills.jsp").forward(request, response);
    }
}