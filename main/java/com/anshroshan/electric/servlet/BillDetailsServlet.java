package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.models.Customer;
import com.anshroshan.electric.service.BillService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet for handling bill details display
 */
@WebServlet("/billDetails")
public class BillDetailsServlet extends BaseServlet {
    private BillService billService;

    @Override
    public void init() throws ServletException {
        super.init();
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

            // Verify that the bill belongs to the logged-in customer
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            boolean billBelongsToCustomer = false;

            for (var consumer : customer.getConsumerList()) {
                for (var customerBill : consumer.getBills()) {
                    if (customerBill.getBillId().equals(billId)) {
                        billBelongsToCustomer = true;
                        break;
                    }
                }
                if (billBelongsToCustomer)
                    break;
            }

            if (!billBelongsToCustomer) {
                request.setAttribute("error", "You are not authorized to view this bill");
                request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
                return;
            }

            request.setAttribute("bill", bill);
            request.getRequestDispatcher("/WEB-INF/views/customer/bill-details.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.severe("Error retrieving bill: " + e.getMessage());
            request.setAttribute("error", "An error occurred while retrieving the bill");
            request.getRequestDispatcher("/WEB-INF/views/customer/view-bills.jsp").forward(request, response);
        }
    }
}