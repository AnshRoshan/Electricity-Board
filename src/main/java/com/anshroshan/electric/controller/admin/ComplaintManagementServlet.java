package com.anshroshan.electric.controller.admin;

import com.anshroshan.electric.model.Complaint;
import com.anshroshan.electric.service.ComplaintService;
import com.anshroshan.electric.service.ConsumerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/view-complaint-history")
public class ComplaintManagementServlet extends HttpServlet {

    private ComplaintService complaintService;
    private ConsumerService consumerService;

    @Override
    public void init() throws ServletException {
        complaintService = new ComplaintService();
        consumerService = new ConsumerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String consumerNumber = request.getParameter("consumerNumber");
        String complaintId = request.getParameter("complaintId");
        String complaintType = request.getParameter("complaintType");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        try {
            List<Complaint> complaints = complaintService.getComplaints(consumerNumber, complaintId, complaintType, startDate, endDate);
            if (consumerNumber != null && !consumerNumber.isEmpty() && !consumerService.isConsumerIdExists(consumerNumber)) {
                request.setAttribute("error", "Invalid Consumer Number.");
            } else if (complaintId != null && !complaintId.isEmpty() && complaintService.getComplaintById(complaintId) == null) {
                request.setAttribute("error", "Invalid Complaint ID.");
            } else {
                request.setAttribute("complaints", complaints);
            }
            request.getRequestDispatcher("/WEB-INF/views/admin/view-bill-complaints.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to fetch complaints.");
            request.getRequestDispatcher("/WEB-INF/views/admin/view-bill-complaints.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String complaintId = request.getParameter("complaintId");
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        try {
            Complaint complaint = complaintService.getComplaintById(complaintId);
            if (complaint != null) {
                complaint.setStatus(status);
                complaint.setNotes(notes);
                complaint.setLastUpdatedDate(java.time.LocalDateTime.now().toString());
                complaintService.updateComplaint(complaint);
                request.setAttribute("success", "Complaint status updated successfully.");
            } else {
                request.setAttribute("error", "Complaint not found.");
            }
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to update complaint status.");
            doGet(request, response);
        }
    }
}