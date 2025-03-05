package com.anshroshan.electric.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.anshroshan.electric.models.Complaint;
import com.anshroshan.electric.service.ComplaintService;

/**
 * Servlet implementation class ViewComplaintDetailsServlet
 * Handles the retrieval and display of a single complaint's details
 */
@WebServlet("/viewComplaintDetails")
public class ViewComplaintDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ComplaintService complaintService;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewComplaintDetailsServlet() {
        super();
        complaintService = new ComplaintService();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     *      Retrieves a specific complaint by ID and forwards to the detail view
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        // Check if user is logged in
        if (customerId == null || customerId.isEmpty()) {
            // Redirect to login page if not logged in
            response.sendRedirect("login.jsp?error=Please log in to view complaint details");
            return;
        }

        // Get complaint ID from request parameter
        String complaintId = request.getParameter("id");

        if (complaintId == null || complaintId.isEmpty()) {
            // Redirect to complaints list if no ID provided
            response.sendRedirect("viewComplaints?error=No complaint ID provided");
            return;
        }

        try {
            // Get complaint by ID
            Complaint complaint = complaintService.getComplaintById(complaintId);

            // Check if complaint exists and belongs to the logged-in customer
            if (complaint == null) {
                response.sendRedirect("viewComplaints?error=Complaint not found");
                return;
            }

            if (!complaint.getCustomerId().equals(customerId)) {
                response.sendRedirect("viewComplaints?error=You do not have permission to view this complaint");
                return;
            }

            // Set complaint as request attribute
            request.setAttribute("complaint", complaint);

            // Forward to the JSP page
            request.getRequestDispatcher("viewComplaintDetails.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error
            getServletContext().log("Error retrieving complaint details", e);

            // Set error message and redirect to complaints list
            response.sendRedirect("viewComplaints?error=Failed to retrieve complaint details: " + e.getMessage());
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