package com.anshroshan.electric.controller.customer;

import com.anshroshan.electric.model.Bill;
import com.anshroshan.electric.model.Payment;
import com.anshroshan.electric.service.BillService;
import com.anshroshan.electric.service.PaymentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private BillService billService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
        paymentService = new PaymentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("selectedBillIds") == null) {
            response.sendRedirect("view-bills");
            return;
        }

        String[] selectedBillIds = (String[]) session.getAttribute("selectedBillIds");
        try {
            List<Bill> selectedBills = billService.getBillsByIds(Arrays.asList(selectedBillIds));
            double totalAmount = selectedBills.stream().mapToDouble(Bill::getBillAmount).sum();
            request.setAttribute("selectedBills", selectedBills);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("/WEB-INF/views/customer/payment.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load payment page. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/customer/payment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String cardholderName = request.getParameter("cardholderName");

        if (!isValidCardNumber(cardNumber) || !isValidExpiryDate(expiryDate) || !isValidCvv(cvv) || cardholderName.isEmpty()) {
            request.setAttribute("error", getValidationError(cardNumber, expiryDate, cvv));
            doGet(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        String[] selectedBillIds = (String[]) session.getAttribute("selectedBillIds");
        try {
            List<Bill> selectedBills = billService.getBillsByIds(Arrays.asList(selectedBillIds));
            double totalAmount = selectedBills.stream().mapToDouble(Bill::getBillAmount).sum();

            String transactionId = UUID.randomUUID().toString();
            String receiptNumber = "REC" + System.currentTimeMillis();
            String transactionDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            String transactionType = request.getParameter("paymentMethod") != null && request.getParameter("paymentMethod").contains("credit") ? "Credit" : "Debit";

            Payment payment = new Payment();
            payment.setTransactionId(transactionId);
            payment.setReceiptNumber(receiptNumber);
            payment.setTransactionDate(transactionDate);
            payment.setTransactionType(transactionType);
            payment.setBillIds(String.join(",", selectedBillIds));
            payment.setTransactionAmount(totalAmount);
            payment.setTransactionStatus("SUCCESS");

            paymentService.savePayment(payment);
            billService.updateBillStatus(selectedBillIds, "Paid");

            session.removeAttribute("selectedBillIds");
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("/WEB-INF/views/customer/payment-confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Payment failed. Please try again.");
            doGet(request, response);
        }
    }

    private boolean isValidCardNumber(String cardNumber) {
        return cardNumber != null && cardNumber.matches("\\d{16}");
    }

    private boolean isValidExpiryDate(String expiryDate) {
        if (expiryDate == null || !expiryDate.matches("\\d{2}/\\d{2}")) return false;
        String[] parts = expiryDate.split("/");
        int month = Integer.parseInt(parts[0]);
        int year = Integer.parseInt("20" + parts[1]);
        Date now = new Date();
        return month >= 1 && month <= 12 && year >= now.getYear() + 1900;
    }

    private boolean isValidCvv(String cvv) {
        return cvv != null && cvv.matches("\\d{3,4}");
    }

    private String getValidationError(String cardNumber, String expiryDate, String cvv) {
        if (!isValidCardNumber(cardNumber)) return "Invalid card number. Must be 16 digits.";
        if (!isValidExpiryDate(expiryDate)) return "Invalid or expired expiry date.";
        if (!isValidCvv(cvv)) return "Invalid CVV. Must be 3 or 4 digits.";
        return "All fields are required.";
    }
}