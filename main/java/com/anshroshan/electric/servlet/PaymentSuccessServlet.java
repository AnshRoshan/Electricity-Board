package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/paysuccess")
public class PaymentSuccessServlet extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check authentication
        if (!isAuthenticated(request, response)) {
            return;
        }

        // First check if payment is in request attributes (from BillSummaryServlet)
        Payment payment = (Payment) request.getAttribute("payment");

        // If not in request, try to get from session
        if (payment == null) {
            payment = (Payment) request.getSession().getAttribute("payment");
        }

        // If still null, redirect to bills page
        if (payment == null) {
            logger.warning("No payment found in request or session, redirecting to viewBills.jsp");
            response.sendRedirect("viewBills.jsp");
            return;
        }

        logger.info("Processing payment in doPost: " + payment);

        // Store payment in both session and request
        storeInSession(request, "payment", payment);
        storeInSession(request, "paymentProcessed", true);
        request.setAttribute("payment", payment);

        // Forward to JSP
        request.getRequestDispatcher("paysuccess.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check authentication
        if (!isAuthenticated(request, response)) {
            return;
        }

        HttpSession session = request.getSession();
        Payment payment = (Payment) session.getAttribute("payment");
        Boolean processed = (Boolean) session.getAttribute("paymentProcessed");

        // If payment exists and has been processed, show the receipt
        if (payment != null && processed != null && processed) {
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("paysuccess.jsp").forward(request, response);
            return;
        }

        // If payment exists but hasn't been processed, redirect to POST
        if (payment != null) {
            // Use POST-Redirect-GET pattern
            response.setContentType("text/html");
            response.getWriter().println(
                    "<html><body onload=\"document.forms[0].submit()\">" +
                            "<form method=\"post\" action=\"paysuccess\">" +
                            "<input type=\"hidden\" name=\"redirect\" value=\"true\">" +
                            "</form></body></html>"
            );
            return;
        }

        // No payment found, redirect to bills page
        logger.warning("No payment found in session for GET request, redirecting to viewBills.jsp");
        response.sendRedirect("viewBills.jsp");
    }
}