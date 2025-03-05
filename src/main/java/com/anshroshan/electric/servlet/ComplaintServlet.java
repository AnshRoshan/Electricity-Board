package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Complaint;
import com.anshroshan.electric.service.ComplaintService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        this.complaintService = new ComplaintService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the complaint registration form
        request.getRequestDispatcher("registerComplaint.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            // Get form parameters
            String complaintType = request.getParameter("complaintType");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String contactMethod = request.getParameter("contactMethod");
            String contact = request.getParameter("contact");
            Long consumerNumber = Long.parseLong(request.getParameter("consumerNumber"));

            // Get customer information from session
            String customerId = (String) session.getAttribute("customerId");
            // Long consumerNumber = (Long) session.getAttribute("consumerNumber");

            // Validate required fields
            if (complaintType == null || complaintType.isEmpty()) {
                throw new Exception("Complaint type is required");
            }
            if (category == null || category.isEmpty()) {
                throw new Exception("Category is required");
            }
            if (description == null || description.isEmpty() || description.length() > 500) {
                throw new Exception("Description is required and should be less than 500 characters");
            }
            if (contactMethod == null || contactMethod.isEmpty()) {
                throw new Exception("Contact method is required");
            }
            if (contact == null || contact.isEmpty()) {
                throw new Exception("Contact details are required");
            }

            // Validate email format if contact method is email
            if ("email".equals(contactMethod) && !isValidEmail(contact)) {
                throw new Exception("Invalid email format");
            }

            // Validate phone format if contact method is phone
            if ("phone".equals(contactMethod) && !isValidPhone(contact)) {
                throw new Exception("Invalid phone number format");
            }

            // Validate customer information
            if (customerId == null || customerId.isEmpty()) {
                throw new Exception("Customer ID is required. Please log in again.");
            }
            if (consumerNumber <= 0) {
                throw new Exception("Consumernumber is required. Please log in again.");
            }

            // Create new complaint
            Complaint complaint = new Complaint();
            complaint.setComplaintId(generateComplaintId());
            complaint.setCompType(complaintType);
            complaint.setCategory(category);
            complaint.setDescription(description);
            complaint.setContactMethod(contactMethod);
            complaint.setContact(contact);
            complaint.setStatus("Pending");
            complaint.setSubmissionDate(new Date());
            complaint.setLastUpdate(new Date());
            complaint.setCustomerId(customerId);
            complaint.setConsumerNumber(consumerNumber);

            // Save to database
            String complaintId = complaintService.saveComplaint(complaint);

            // Set attributes for confirmation page
            request.setAttribute("complaint", complaint);
            request.setAttribute("complaintId", complaintId);
            request.setAttribute("estimatedTime", getEstimatedTime(complaintType));
            request.setAttribute("complaintSummary",
                    "Type: " + complaintType + "\nCategory: " + category + "\nDescription: " + description);

            // Forward to confirmation page
            request.getRequestDispatcher("complaintConfirmation.jsp").forward(request, response);

        } catch (Exception e) {
            // Set error message and forward back to form
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("registerComplaint.jsp").forward(request, response);
        }
    }

    private String generateComplaintId() {
        return "CMP" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    private String getEstimatedTime(String complaintType) {
        return switch (complaintType) {
            case "billing_issue" -> "48 hours";
            case "power_outage" -> "24 hours";
            case "meter_reading_issue" -> "72 hours";
            default -> "48 hours";
        };
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && email.matches(emailRegex);
    }

    private boolean isValidPhone(String phone) {
        // Remove non-digit characters
        String digitsOnly = phone.replaceAll("\\D", "");
        // Check if it has 10 digits
        return digitsOnly.length() == 10;
    }
}