package com.anshroshan.electric.servlet;

import com.anshroshan.electric.dao.BillDAO;
import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.service.BillService;
import com.anshroshan.electric.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/viewBills")
public class ViewBillsServlet extends HttpServlet {
    private CustomerService customerService;
    private BillService billService;

    @Override
    public void init() throws ServletException {
        this.customerService = new CustomerService();
        this.billService = new BillService();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            System.out.println("Session or customerId is null in doGet");
            response.sendRedirect("login.jsp");
            return;
        }

        String customerId = (String) session.getAttribute("customerId");

        try {
            Customer customer = customerService.getCustomerDetails(customerId);
            if (customer == null) {
                System.out.println("Customer not found for ID: " + customerId);
                session.invalidate();
                response.sendRedirect("login.jsp");
                return;
            }

            // Set customer in session to match JSP expectation
            session.setAttribute("customer", customer);
            request.getRequestDispatcher("viewBills.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load bills. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Customer customer= (Customer) session.getAttribute("customer");
        if (customer == null) {
            System.out.println("The customer is not here.. ");
            response.sendRedirect("login.jsp");
            return;
        }

        String[] selectedBillIds = request.getParameterValues("selectedBills");
        if (selectedBillIds != null && selectedBillIds.length > 0) {
            List<Bill> selectedBills = billService.getBillsByBillIds(selectedBillIds) ;
            // Assume this method fetches bills by ID
            request.setAttribute("selectedBills", selectedBills);
            System.out.println("Selected bills: " + selectedBills);
            request.getRequestDispatcher("billSummary.jsp").forward(request, response);
        } else {
            System.out.println("No bills selected in doPost");
            request.setAttribute("error", "No bills selected.");
            doGet(request, response);
        }
    }
}