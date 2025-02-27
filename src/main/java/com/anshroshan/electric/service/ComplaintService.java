package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.ComplaintDAO;
import com.anshroshan.electric.model.Complaint;

import java.util.List;

public class ComplaintService {

    private ComplaintDAO complaintDAO;

    public ComplaintService() {
        this.complaintDAO = new ComplaintDAO();
    }

    // Register a new complaint (US007)
    public void registerComplaint(Complaint complaint) throws Exception {
        complaintDAO.addComplaint(complaint);
    }

    // Get complaint by ID (US008, US016)
    public Complaint getComplaintById(String complaintId) throws Exception {
        return complaintDAO.getComplaintById(complaintId);
    }

    // Get complaint by status for a consumer (US008)
    public Complaint getComplaintByStatus(String consumerNumber, String status) throws Exception {
        return complaintDAO.getComplaintByStatus(consumerNumber, status);
    }

    // Get complaints by consumer number (US009)
    public List<Complaint> getComplaintsByConsumerNumber(String consumerNumber) throws Exception {
        return complaintDAO.getComplaintsByConsumerNumber(consumerNumber);
    }

    // Get all complaints (US009 - Admin View)
    public List<Complaint> getAllComplaints() throws Exception {
        return complaintDAO.getAllComplaints();
    }

    // Get complaints with filters (US016 - View Complaint)
    public List<Complaint> getComplaints(String consumerNumber, String complaintId, String complaintType, String startDate, String endDate) throws Exception {
        return complaintDAO.getComplaints(consumerNumber, complaintId, complaintType, startDate, endDate);
    }

    // Update complaint status and notes (US016)
    public void updateComplaint(Complaint complaint) throws Exception {
        complaintDAO.updateComplaint(complaint);
    }
}