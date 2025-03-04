package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.service.BillService;
import com.anshroshan.electric.service.PaymentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet for handling bill payment operations
 */
@WebServlet("/payment")
public class PaymentServlet extends BaseServlet {
    private PaymentService paymentService;
    private BillService billService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.paymentService = new PaymentService();
        this.billService = new BillService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAuthenticated(request, response)) {
            return;
        }

        String billId = request.getParameter("billId");
        if (billId == null || billId.isEmpty()) {
            request.setAttribute("error", "Bill ID is required");
            request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
            return;
        }

        try {
            Bill bill = billService.getBillById(billId);
            if (bill == null) {
                request.setAttribute("error", "Bill not found");
                request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
                return;
            }

            if ("Paid".equals(bill.getStatus())) {
                request.setAttribute("error", "This bill has already been paid");
                request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
                return;
            }

            request.setAttribute("bill", bill);
            request.getRequestDispatcher("/WEB-INF/views/customer/payment.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.severe("Error retrieving bill: " + e.getMessage());
            request.setAttribute("error", "An error occurred while retrieving the bill");
            request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAuthenticated(request, response)) {
            return;
        }

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        String customerId = customer.getCustomerId();

        String billId = request.getParameter("billId");
        String paymentMethod = request.getParameter("paymentMethod");
        String amountStr = request.getParameter("amount");

        if (billId == null || billId.isEmpty() || paymentMethod == null || paymentMethod.isEmpty() || amountStr == null
                || amountStr.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            doGet(request, response);
            return;
        }

        try {
            double amount = Double.parseDouble(amountStr);
            String[] billIds = { billId };

            // Validate payment amount
            if (!paymentService.validatePaymentAmount(amount, billIds)) {
                request.setAttribute("error", "Payment amount does not match the bill total");
                doGet(request, response);
                return;
            }

            // Process payment
            String transactionId = paymentService.processPayment(amount, billIds, paymentMethod, customerId);

            // Redirect to success page
            response.sendRedirect(request.getContextPath() + "/paymentSuccess?transactionId=" + transactionId);
        } catch (NumberFormatException e) {
            logger.severe("Invalid amount format: " + e.getMessage());
            request.setAttribute("error", "Invalid amount format");
            doGet(request, response);
        } catch (SQLException e) {
            logger.severe("Error processing payment: " + e.getMessage());
            request.setAttribute("error", "An error occurred while processing the payment");
            doGet(request, response);
        }
    }
}