package com.anshroshan.electrictymanagement.servlet;

import com.anshroshan.electrictymanagement.models.Bill;
import com.anshroshan.electrictymanagement.models.Consumer;
import com.anshroshan.electrictymanagement.models.Customer;
import com.anshroshan.electrictymanagement.service.BillService;
import com.anshroshan.electrictymanagement.service.ConsumerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name="home" ,  value="/home")
public class HomeServlet extends HttpServlet {
    private final ConsumerService consumerService = new ConsumerService();
    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null || Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            response.sendRedirect("login");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        List<Consumer> consumers = consumerService.getConsumersByCustomerId(customer.getCustomerId());

        if (!consumers.isEmpty()) {
            long consumerNumber = consumers.getFirst().getConsumerNumber(); // Assuming first consumer for simplicity
            Bill latestBill = billService.getLatestBill(consumerNumber);
            request.setAttribute("latestBill", latestBill);
            request.setAttribute("consumerNumber", consumerNumber);
        }

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if ("viewBills".equals(action)) {
            String consumerNumberStr = request.getParameter("consumerNumber");
            long consumerNumber = Long.parseLong(consumerNumberStr);
            List<Bill> bills = billService.getBills(consumerNumber);
            request.setAttribute("bills", bills);
            request.setAttribute("consumerNumber", consumerNumber);
            request.getRequestDispatcher("/viewBills.jsp").forward(request, response);
        } else if ("payBills".equals(action)) {
            String[] selectedBillIds = request.getParameterValues("selectedBills");
            if (selectedBillIds != null && selectedBillIds.length > 0) {
                request.setAttribute("selectedBillIds", List.of(selectedBillIds));
                request.setAttribute("totalAmount", billService.calculateTotalAmount(List.of(selectedBillIds)));
                request.getRequestDispatcher("/payBill.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "No bills selected.");
                doGet(request, response);
            }
        }
    }
}