package com.anshroshan.electrictymanagement.service;

import com.anshroshan.electrictymanagement.dao.ComplaintDAO;
import com.anshroshan.electrictymanagement.models.Complaint;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Logger;

public class ComplaintService {
    private static final Logger LOGGER = Logger.getLogger(ComplaintService.class.getName());
    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    public String registerComplaint(long consumerNumber, String customerId, String compType, String category, String description, String contactMethod, String contact) {
        if (compType == null || compType.trim().isEmpty()) {
            LOGGER.warning("Complaint type missing.");
            throw new IllegalArgumentException("Complaint Type is required.");
        }
        if (category == null || category.trim().isEmpty()) {
            LOGGER.warning("Category missing.");
            throw new IllegalArgumentException("Category is required.");
        }
        if (description == null || description.trim().isEmpty() || description.length() > 1024) {
            LOGGER.warning("Invalid description: " + description);
            throw new IllegalArgumentException("Description is required, max 1024 characters.");
        }
        if (!"Email".equalsIgnoreCase(contactMethod) && !"Phone".equalsIgnoreCase(contactMethod)) {
            LOGGER.warning("Invalid contact method: " + contactMethod);
            throw new IllegalArgumentException("Contact Method must be Email or Phone.");
        }

        Complaint complaint = new Complaint(null, consumerNumber, customerId, compType, category, description, contactMethod, contact, "Pending", LocalDate.now(), null, null);
        String complaintId = complaintDAO.addComplaint(complaint);
        if (complaintId != null) {
            LOGGER.info("Complaint registered successfully: " + complaintId);
            return complaintId;
        } else {
            LOGGER.severe("Failed to register complaint for customer: " + customerId);
            throw new RuntimeException("Failed to register complaint.");
        }
    }

    public Complaint getComplaint(String complaintId) {
        Complaint complaint = complaintDAO.getComplaintById(complaintId);
        if (complaint != null) {
            LOGGER.info("Complaint fetched: " + complaintId);
            return complaint;
        } else {
            LOGGER.warning("Complaint not found: " + complaintId);
            throw new IllegalArgumentException("Complaint not found.");
        }
    }

    public List<Complaint> getComplaintsByCustomerId(String customerId) {
        List<Complaint> complaints = complaintDAO.getComplaintsByCustomerId(customerId);
        if (!complaints.isEmpty()) {
            LOGGER.info("Complaints fetched for customer: " + customerId);
        } else {
            LOGGER.warning("No complaints found for customer: " + customerId);
        }
        return complaints;
    }

    public List<Complaint> getComplaintsByConsumerNumber(long consumerNumber) {
        List<Complaint> complaints = complaintDAO.getComplaintsByConsumerNumber(consumerNumber);
        if (!complaints.isEmpty()) {
            LOGGER.info("Complaints fetched for consumer: " + consumerNumber);
        } else {
            LOGGER.warning("No complaints found for consumer: " + consumerNumber);
        }
        return complaints;
    }

    public void updateComplaintStatus(String complaintId, String status, String note) {
        if (!"Pending".equalsIgnoreCase(status) && !"In Progress".equalsIgnoreCase(status) && !"Resolved".equalsIgnoreCase(status) && !"Closed".equalsIgnoreCase(status)) {
            LOGGER.warning("Invalid status: " + status);
            throw new IllegalArgumentException("Status must be Pending, In Progress, Resolved, or Closed.");
        }
        if (complaintDAO.updateComplaintStatus(complaintId, status, note)) {
            LOGGER.info("Complaint status updated: " + complaintId);
        } else {
            LOGGER.severe("Failed to update complaint status: " + complaintId);
            throw new RuntimeException("Failed to update complaint status.");
        }
    }

    public List<Complaint> getComplaintsByDateRange(String customerId, LocalDate startDate, LocalDate endDate) {
        if (startDate.isAfter(endDate)) {
            LOGGER.warning("Start date after end date: " + startDate + ", " + endDate);
            throw new IllegalArgumentException("Start Date must be before End Date.");
        }
        List<Complaint> complaints = complaintDAO.getComplaintsByDateRange(customerId, startDate, endDate);
        if (!complaints.isEmpty()) {
            LOGGER.info("Complaints fetched for customer " + customerId + " between " + startDate + " and " + endDate);
        } else {
            LOGGER.warning("No complaints found for customer " + customerId + " in range " + startDate + " to " + endDate);
        }
        return complaints;
    }
}