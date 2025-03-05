package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.models.Payment;
import com.anshroshan.electric.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billSummary")
public class BillSummaryServlet extends BaseServlet {
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        this.customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check authentication
        if (!isAuthenticated(request, response)) {
            return;
        }

        Customer customer = (Customer) request.getSession().getAttribute("customer");
        String customerId = customer.getCustomerId();
        String[] selectedBillIds = (String[]) request.getSession().getAttribute("selectedBillIds");

        if (selectedBillIds == null || selectedBillIds.length == 0) {
            setErrorAndForward(request, response, "No bills selected to summarize.", "viewBills.jsp");
            return;
        }

        try {
            Customer updatedCustomer = customerService.getCustomerDetails(customerId);
            if (updatedCustomer == null) {
                request.getSession().invalidate();
                redirectToLogin(request, response);
                return;
            }

            // Filter selected bills from customer's bill list
            List<Bill> selectedBills = new ArrayList<>();
            for (String billId : selectedBillIds) {
                for (var consumer : updatedCustomer.getConsumerList()) {
                    for (Bill bill : consumer.getBills()) {
                        if (bill.getBillId().equals(billId)) {
                            selectedBills.add(bill);
                            break;
                        }
                    }
                }
            }

            request.setAttribute("selectedBills", selectedBills);
            request.getRequestDispatcher("billSummary.jsp").forward(request, response);
        } catch (SQLException e) {
            logException(e, "Unable to load bill summary");
            setErrorAndForward(request, response, "Unable to load bill summary. Please try again.", "error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check authentication
        if (!isAuthenticated(request, response)) {
            return;
        }

        Customer customer = (Customer) request.getSession().getAttribute("customer");
        String customerId = customer.getCustomerId();
        String[] updatedSelectedBillIds = request.getParameterValues("selectedBills");
        String paymentMethod = request.getParameter("paymentMethod");

        if (updatedSelectedBillIds == null || updatedSelectedBillIds.length == 0) {
            setErrorAndForward(request, response, "No bills selected for payment.", "billSummary.jsp");
            return;
        }

        if (paymentMethod == null || paymentMethod.isEmpty()) {
            setErrorAndForward(request, response, "Please select a payment method.", "billSummary.jsp");
            return;
        }

        try {
            // Refresh customer data to ensure latest bill statuses
            Customer updatedCustomer = customerService.getCustomerDetails(customerId);
            if (updatedCustomer == null) {
                request.getSession().invalidate();
                redirectToLogin(request, response);
                return;
            }

            // Calculate total amount and collect selected bills
            List<Bill> selectedBills = new ArrayList<>();
            double totalAmount = 0;
            for (String billId : updatedSelectedBillIds) {
                for (var consumer : updatedCustomer.getConsumerList()) {
                    for (Bill bill : consumer.getBills()) {
                        if (bill.getBillId().equals(billId)) {
                            selectedBills.add(bill);
                            totalAmount += bill.getAmount() + bill.getLateFee(); // Include late fees
                            break;
                        }
                    }
                }
            }

            // Create Payment object
            Payment payment = new Payment(
                    null, // transactionId generated by DAO
                    new Date(System.currentTimeMillis()), // Current date
                    totalAmount,
                    updatedSelectedBillIds,
                    "Completed", // Assume success for now
                    paymentMethod,
                    customerId);

            // Process payment and update bill statuses
            customerService.processPayment(payment, updatedSelectedBillIds);

            // Update session with payment and clean up
            storeInSession(request, "payment", payment);
            removeFromSession(request, "selectedBillIds");
            removeFromSession(request, "paymentMethod");

            // Forward to payment success page with payment in request
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("paysuccess").forward(request, response);
        } catch (SQLException e) {
            logException(e, "Payment processing failed");
            setErrorAndForward(request, response,
                    "Payment processing failed due to a database error. Please try again.", "billSummary.jsp");
        }
    }
}