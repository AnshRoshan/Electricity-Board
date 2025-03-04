package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet("/billHistory")
public class BillHistoryServlet extends HttpServlet {
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        this.customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String customerId = (String) session.getAttribute("customerId");

        try {
            // Default: last 6 months
            Calendar cal = Calendar.getInstance();
            Date endDate = new Date(cal.getTimeInMillis());
            cal.add(Calendar.MONTH, -6);
            Date startDate = new Date(cal.getTimeInMillis());

            // Override with user-specified range if provided
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = new Date(sdf.parse(startDateStr).getTime());
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = new Date(sdf.parse(endDateStr).getTime());
            }

            List<Bill> bills = customerService.getBillHistory(customerId, startDate, endDate);

            // Apply filters
            String statusFilter = request.getParameter("statusFilter");
            if (statusFilter != null && !statusFilter.isEmpty() && !"All".equals(statusFilter)) {
                bills.removeIf(bill -> !bill.getStatus().equals(statusFilter));
            }

            // Apply sorting
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "billDate":
                        Collections.sort(bills, Comparator.comparing(Bill::getBillDate));
                        break;
                    case "dueDate":
                        Collections.sort(bills, Comparator.comparing(Bill::getDueDate));
                        break;
                    case "amount":
                        Collections.sort(bills, Comparator.comparingDouble(Bill::getAmount));
                        break;
                }
            }

            request.setAttribute("bills", bills);
            request.setAttribute("startDate", sdf.format(startDate));
            request.setAttribute("endDate", sdf.format(endDate));
            request.getRequestDispatcher("billHistory.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load bill history. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD.");
            request.getRequestDispatcher("billHistory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Handle filters/sort via GET
    }
}