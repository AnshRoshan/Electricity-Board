package com.anshroshan.electric.controller.admin;

import com.anshroshan.electric.model.Bill;
import com.anshroshan.electric.service.BillService;
import com.anshroshan.electric.service.ConsumerService;
import com.anshroshan.electric.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@WebServlet({"/admin/add-bill", "/admin/view-bill-history"})
public class BillManagementServlet extends HttpServlet {

    private BillService billService;
    private ConsumerService consumerService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
        consumerService = new ConsumerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/admin/add-bill".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/admin/add-bill.jsp").forward(request, response);
        } else if ("/admin/view-bill-history".equals(path)) {
            String consumerNumber = request.getParameter("consumerNumber");
            String periodFilter = request.getParameter("periodFilter");
            String statusFilter = request.getParameter("statusFilter");

            try {
                if (consumerNumber != null && !consumerNumber.isEmpty()) {
                    if (!consumerService.isConsumerIdExists(consumerNumber)) {
                        request.setAttribute("error", "Invalid Consumer Number.");
                    } else {
                        List<Bill> bills = billService.getBillHistory(consumerNumber, periodFilter, statusFilter);
                        request.setAttribute("bills", bills);
                    }
                }
                request.getRequestDispatcher("/WEB-INF/views/admin/view-bill-history.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to fetch bill history.");
                request.getRequestDispatcher("/WEB-INF/views/admin/view-bill-history.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/admin/add-bill".equals(path)) {
            String consumerId = request.getParameter("consumerId");
            String billingPeriod = request.getParameter("billingPeriod");
            String billDate = request.getParameter("billDate");
            String dueDate = request.getParameter("dueDate");
            String disconnectionDate = request.getParameter("disconnectionDate");
            String billAmountStr = request.getParameter("billAmount");
            String lateFeeStr = request.getParameter("lateFee");
            String status = request.getParameter("status");

            try {
                // Validation
                if (!consumerService.isConsumerIdExists(consumerId)) {
                    request.setAttribute("error", "Invalid Consumer ID. It does not exist in the system.");
                    doGet(request, response);
                    return;
                }
                if (billingPeriod == null || billingPeriod.isEmpty()) {
                    request.setAttribute("error", "Billing Period is required.");
                    doGet(request, response);
                    return;
                }
                LocalDate billDateParsed = LocalDate.parse(billDate);
                LocalDate dueDateParsed = LocalDate.parse(dueDate);
                LocalDate disconnectionDateParsed = disconnectionDate.isEmpty() ? null : LocalDate.parse(disconnectionDate);
                if (billDateParsed.isAfter(dueDateParsed)) {
                    request.setAttribute("error", "Bill Date must be before Due Date.");
                    doGet(request, response);
                    return;
                }
                double billAmount = Double.parseDouble(billAmountStr);
                if (billAmount <= 0) {
                    request.setAttribute("error", "Bill Amount must be a positive number.");
                    doGet(request, response);
                    return;
                }
                double lateFee = lateFeeStr.isEmpty() ? 0 : Double.parseDouble(lateFeeStr);
                if (lateFee < 0) {
                    request.setAttribute("error", "Late Fee cannot be negative.");
                    doGet(request, response);
                    return;
                }
                if (billService.isBillExists(consumerId, billingPeriod)) {
                    request.setAttribute("error", "A bill for this Consumer ID and Billing Period already exists.");
                    doGet(request, response);
                    return;
                }

                // Create Bill
                Bill bill = new Bill();
                String billId = "BILL" + UUID.randomUUID().toString().substring(0, 8);
                bill.setBillId(billId);
                bill.setConsumerNumber(consumerId);
                bill.setBillingPeriod(billingPeriod);
                bill.setBillDate(billDate);
                bill.setDueDate(dueDate);
                bill.setDisconnectionDate(disconnectionDate);
                bill.setBillAmount(billAmount);
                bill.setLateFee(lateFee);
                bill.setStatus(status);

                billService.addBill(bill);

                request.setAttribute("success", "Bill added successfully!");
                request.setAttribute("bill", bill);
                request.getRequestDispatcher("/WEB-INF/views/admin/add-bill.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to add bill. Please check your inputs and try again.");
                doGet(request, response);
            }
        }
    }
}