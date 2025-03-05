package com.anshroshan.electric.controller.customer;

import com.anshroshan.electric.model.Bill;
import com.anshroshan.electric.service.BillService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/bill-summary")
public class BillSummaryServlet extends HttpServlet {

    private BillService billService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
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
            request.setAttribute("selectedBills", selectedBills);
            request.getRequestDispatcher("/WEB-INF/views/customer/bill-summary.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load bill summary. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/customer/bill-summary.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String[] updatedSelectedBillIds = request.getParameterValues("selectedBills");
        HttpSession session = request.getSession();
        if (updatedSelectedBillIds != null && updatedSelectedBillIds.length > 0) {
            session.setAttribute("selectedBillIds", updatedSelectedBillIds);
            response.sendRedirect("payment");
        } else {
            session.removeAttribute("selectedBillIds");
            response.sendRedirect("view-bills");
        }
    }
}