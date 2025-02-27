package com.anshroshan.electric.controller.customer;

import com.anshroshan.electric.model.Complaint;
import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.service.ComplaintService;
import com.anshroshan.electric.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet({"/register-complaint", "/complaint-status"})
public class ComplaintServlet extends HttpServlet {

    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        complaintService = new ComplaintService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInCustomer") == null) {
            response.sendRedirect("login");
            return;
        }
        String path = request.getServletPath();
        if ("/complaint-status".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/customer/complaint-status.jsp").forward(request, response);
        } else {
            Customer customer = (Customer) session.getAttribute("loggedInCustomer");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/customer/register-complaint.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInCustomer") == null) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getServletPath();
        if ("/complaint-status".equals(path)) {
            String complaintId = request.getParameter("complaintId");
            String statusFilter = request.getParameter("statusFilter");
            try {
                Complaint complaint = null;
                if (complaintId != null && !complaintId.isEmpty()) {
                    complaint = complaintService.getComplaintById(complaintId);
                }
                if (complaint == null && statusFilter != null && !statusFilter.isEmpty()) {
                    Customer customer = (Customer) session.getAttribute("loggedInCustomer");
                    complaint = complaintService.getComplaintByStatus(customer.getConsumerNumber(), statusFilter);
                }
                if (complaint != null) {
                    request.setAttribute("complaint", complaint);
                } else {
                    request.setAttribute("error", "No complaint found with the given ID or status.");
                }
                request.getRequestDispatcher("/WEB-INF/views/customer/complaint-status.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to fetch complaint status. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/customer/complaint-status.jsp").forward(request, response);
            }
        } else if ("/register-complaint".equals(path)) {
            Customer customer = (Customer) session.getAttribute("loggedInCustomer");
            String complaintType = request.getParameter("complaintType");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String contactMethod = request.getParameter("contactMethod");
            String contactDetails = request.getParameter("contactDetails");

            try {
                if (!ValidationUtil.isValidComplaintType(complaintType)) {
                    request.setAttribute("error", "Complaint Type is required.");
                    doGet(request, response);
                    return;
                }
                if (category == null || category.isEmpty()) {
                    request.setAttribute("error", "Category is required.");
                    doGet(request, response);
                    return;
                }
                if (description == null || description.isEmpty() || description.length() > 500) {
                    request.setAttribute("error", "Description is required and must be less than 500 characters.");
                    doGet(request, response);
                    return;
                }
                if (contactMethod == null || contactMethod.isEmpty()) {
                    request.setAttribute("error", "Preferred Contact Method is required.");
                    doGet(request, response);
                    return;
                }
                if (contactDetails == null || contactDetails.isEmpty() || 
                    (contactMethod.equals("email") && !ValidationUtil.isValidEmail(contactDetails)) ||
                    (contactMethod.equals("phone") && !ValidationUtil.isValidMobileNumber(contactDetails))) {
                    request.setAttribute("error", "Invalid contact details for the selected method.");
                    doGet(request, response);
                    return;
                }

                Complaint complaint = new Complaint();
                String complaintId = "CMP" + UUID.randomUUID().toString().substring(0, 8);
                complaint.setComplaintId(complaintId);
                complaint.setConsumerNumber(customer.getConsumerNumber());
                complaint.setComplaintType(complaintType);
                complaint.setCategory(category);
                complaint.setDescription(description);
                complaint.setContactMethod(contactMethod);
                complaint.setContactDetails(contactDetails);
                complaint.setStatus("Pending");
                complaint.setSubmissionDate(java.time.LocalDateTime.now().toString());

                complaintService.registerComplaint(complaint);

                request.setAttribute("complaintId", complaintId);
                request.setAttribute("resolutionTime", getEstimatedResolutionTime(complaintType));
                request.setAttribute("complaint", complaint);
                request.setAttribute("success", "Complaint registered successfully!");
                request.getRequestDispatcher("/WEB-INF/views/customer/register-complaint.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to register complaint. Please try again.");
                doGet(request, response);
            }
        }
    }

    private String getEstimatedResolutionTime(String complaintType) {
        switch (complaintType) {
            case "billing_issue": return "3-5 business days";
            case "power_outage": return "24-48 hours";
            case "meter_reading_issue": return "5-7 business days";
            default: return "3-7 business days";
        }
    }
}