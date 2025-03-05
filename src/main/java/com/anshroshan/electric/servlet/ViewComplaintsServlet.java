package com.anshroshan.electric.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.anshroshan.electric.models.Complaint;
import com.anshroshan.electric.service.ComplaintService;

/**
 * Servlet implementation class ViewComplaintsServlet
 * Handles the retrieval and display of complaints for a customer
 */
@WebServlet("/viewComplaints")
public class ViewComplaintsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ComplaintService complaintService;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewComplaintsServlet() {
        super();
        complaintService = new ComplaintService();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     *      Retrieves complaints for the logged-in customer and forwards to the view
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        // Check if user is logged in
        if (customerId == null || customerId.isEmpty()) {
            // Redirect to login page if not logged in
            response.sendRedirect("login.jsp?error=Please log in to view your complaints");
            return;
        }

        try {
            // Get complaints for the customer
            List<Complaint> complaints = complaintService.getComplaintsByCustomerId(customerId);

            // Set complaints as request attribute
            request.setAttribute("complaints", complaints);

            // Forward to the JSP page
            request.getRequestDispatcher("viewComplaints.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error
            getServletContext().log("Error retrieving complaints", e);

            // Set error message and forward to error page or back to view with error
            request.setAttribute("errorMessage", "Failed to retrieve complaints: " + e.getMessage());
            request.getRequestDispatcher("viewComplaints.jsp").forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     *      Handles any POST requests - redirects to doGet for this servlet
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For this servlet, POST requests are handled the same as GET
        doGet(request, response);
    }
}