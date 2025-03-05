package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.ComplaintDAO;
import com.anshroshan.electric.models.Complaint;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

// ComplaintService.java
public class ComplaintService {

    private final ComplaintDAO complaintDAO;

    public ComplaintService() {
        this.complaintDAO = new ComplaintDAO();
    }

    public String registerComplaint(Complaint complaint) throws Exception {
        // Validation
        if (complaint.getCompType() == null || complaint.getCompType().isEmpty()) {
            throw new Exception("Complaint type is required");
        }
        if (complaint.getCategory() == null || complaint.getCategory().isEmpty()) {
            throw new Exception("Category is required");
        }
        if (complaint.getDescription() == null || complaint.getDescription().length() > 1024) {
            throw new Exception("Description is required and should be less than 1024 characters");
        }
        if (complaint.getConsumerNumber() <= 0) {
            throw new Exception("Valid consumer number is required");
        }
        if (complaint.getCustomerId() == null || complaint.getCustomerId().isEmpty()) {
            throw new Exception("Customer ID is required");
        }
        if (!isValidEmail(complaint.getContact()) && "email".equals(complaint.getContactMethod())) {
            throw new Exception("Invalid email format");
        }

        return complaintDAO.saveComplaint(complaint);
    }

    public Map<String, String[]> getCategories() {
        return complaintDAO.getCategoriesByType();
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && email.matches(emailRegex);
    }

    public String saveComplaint(Complaint complaint) throws SQLException {
        return complaintDAO.saveComplaint(complaint);
    }

    /**
     * Retrieves a complaint by its ID
     * 
     * @param complaintId The ID of the complaint to retrieve
     * @return The Complaint object if found, null otherwise
     * @throws SQLException If a database error occurs
     */
    public Complaint getComplaintById(String complaintId) throws SQLException {
        if (complaintId == null || complaintId.isEmpty()) {
            return null;
        }
        return complaintDAO.getComplaintById(complaintId);
    }

    /**
     * Retrieves all complaints for a specific customer
     * 
     * @param customerId The ID of the customer
     * @return A list of Complaint objects for the customer
     * @throws SQLException If a database error occurs
     */
    public List<Complaint> getComplaintsByCustomerId(String customerId) throws SQLException {
        if (customerId == null || customerId.isEmpty()) {
            throw new IllegalArgumentException("Customer ID cannot be null or empty");
        }
        return complaintDAO.getComplaintsByCustomerId(customerId);
    }

    /**
     * Updates the status of a complaint
     * 
     * @param complaintId       The ID of the complaint to update
     * @param status            The new status
     * @param resolutionDetails Optional resolution details (can be null)
     * @return true if the update was successful, false otherwise
     * @throws SQLException If a database error occurs
     */
    public boolean updateComplaintStatus(String complaintId, String status, String resolutionDetails)
            throws SQLException {
        if (complaintId == null || complaintId.isEmpty()) {
            return false;
        }
        if (status == null || status.isEmpty()) {
            return false;
        }
        return complaintDAO.updateComplaintStatus(complaintId, status, resolutionDetails);
    }
}