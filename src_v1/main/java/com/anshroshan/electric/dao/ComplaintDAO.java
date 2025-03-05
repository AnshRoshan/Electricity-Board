package com.anshroshan.electric.dao;

import com.anshroshan.electric.model.Complaint;
import com.anshroshan.electric.util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public void addComplaint(Complaint complaint) throws Exception {
        String sql = "INSERT INTO complaints (complaint_id, consumer_number, complaint_type, category, description, contact_method, contact_details, status, submission_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, complaint.getComplaintId());
            stmt.setString(2, complaint.getConsumerNumber());
            stmt.setString(3, complaint.getComplaintType());
            stmt.setString(4, complaint.getCategory());
            stmt.setString(5, complaint.getDescription());
            stmt.setString(6, complaint.getContactMethod());
            stmt.setString(7, complaint.getContactDetails());
            stmt.setString(8, complaint.getStatus());
            stmt.setString(9, complaint.getSubmissionDate());
            stmt.executeUpdate();
        }
    }

    public Complaint getComplaintById(String complaintId) throws Exception {
        String sql = "SELECT * FROM complaints WHERE complaint_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, complaintId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractComplaintFromResultSet(rs);
            }
            return null;
        }
    }

    public Complaint getComplaintByStatus(String consumerNumber, String status) throws Exception {
        String sql = "SELECT * FROM complaints WHERE consumer_number = ? AND status = ? ORDER BY submission_date DESC LIMIT 1";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerNumber);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractComplaintFromResultSet(rs);
            }
            return null;
        }
    }

    public List<Complaint> getComplaintsByConsumerNumber(String consumerNumber) throws Exception {
        String sql = "SELECT * FROM complaints WHERE consumer_number = ? ORDER BY submission_date DESC";
        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerNumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                complaints.add(extractComplaintFromResultSet(rs));
            }
            return complaints;
        }
    }

    public List<Complaint> getAllComplaints() throws Exception {
        String sql = "SELECT * FROM complaints ORDER BY submission_date DESC";
        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                complaints.add(extractComplaintFromResultSet(rs));
            }
            return complaints;
        }
    }

    public List<Complaint> getComplaints(String consumerNumber, String complaintId, String complaintType, String startDate, String endDate) throws Exception {
        String sql = "SELECT * FROM complaints WHERE 1=1";
        if (consumerNumber != null && !consumerNumber.isEmpty()) {
            sql += " AND consumer_number = ?";
        }
        if (complaintId != null && !complaintId.isEmpty()) {
            sql += " AND complaint_id = ?";
        }
        if (complaintType != null && !complaintType.isEmpty()) {
            sql += " AND complaint_type = ?";
        }
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql += " AND submission_date BETWEEN ? AND ?";
        }
        sql += " ORDER BY submission_date DESC";

        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (consumerNumber != null && !consumerNumber.isEmpty()) {
                stmt.setString(paramIndex++, consumerNumber);
            }
            if (complaintId != null && !complaintId.isEmpty()) {
                stmt.setString(paramIndex++, complaintId);
            }
            if (complaintType != null && !complaintType.isEmpty()) {
                stmt.setString(paramIndex++, complaintType);
            }
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                stmt.setString(paramIndex++, startDate);
                stmt.setString(paramIndex, endDate);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                complaints.add(extractComplaintFromResultSet(rs));
            }
            return complaints;
        }
    }

    public void updateComplaint(Complaint complaint) throws Exception {
        String sql = "UPDATE complaints SET status = ?, notes = ?, last_updated_date = ? WHERE complaint_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, complaint.getStatus());
            stmt.setString(2, complaint.getNotes());
            stmt.setString(3, complaint.getLastUpdatedDate());
            stmt.setString(4, complaint.getComplaintId());
            stmt.executeUpdate();
        }
    }

    private Complaint extractComplaintFromResultSet(ResultSet rs) throws Exception {
        Complaint complaint = new Complaint();
        complaint.setComplaintId(rs.getString("complaint_id"));
        complaint.setConsumerNumber(rs.getString("consumer_number"));
        complaint.setComplaintType(rs.getString("complaint_type"));
        complaint.setCategory(rs.getString("category"));
        complaint.setDescription(rs.getString("description"));
        complaint.setContactMethod(rs.getString("contact_method"));
        complaint.setContactDetails(rs.getString("contact_details"));
        complaint.setStatus(rs.getString("status"));
        complaint.setSubmissionDate(rs.getString("submission_date"));
        complaint.setLastUpdatedDate(rs.getString("last_updated_date"));
        complaint.setNotes(rs.getString("notes"));
        return complaint;
    }
}