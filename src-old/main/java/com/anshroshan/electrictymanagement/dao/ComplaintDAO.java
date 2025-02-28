package com.anshroshan.electrictymanagement.dao;

import com.anshroshan.electrictymanagement.models.Complaint;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

public class ComplaintDAO {
    private static final Logger LOGGER = Logger.getLogger(ComplaintDAO.class.getName());

    public String addComplaint(Complaint complaint) {
        String sql = "INSERT INTO COMPLAINT (COMPLAINTID, CONSUMERNUMBER, CUSTOMERID, COMPTYPE, CATEGORY, DESCRIPTION, CONTACTMETHOD, CONTACT, STATUS, SUBMISSIONDATE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING COMPLAINTID";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            String complaintId = "CMP-" + UUID.randomUUID().toString().substring(0, 8);
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, complaintId);
                stmt.setLong(2, complaint.getConsumerNumber());
                stmt.setString(3, complaint.getCustomerId());
                stmt.setString(4, complaint.getCompType());
                stmt.setString(5, complaint.getCategory());
                stmt.setString(6, complaint.getDescription());
                stmt.setString(7, complaint.getContactMethod());
                stmt.setString(8, complaint.getContact());
                stmt.setString(9, complaint.getStatus());
                stmt.setDate(10, Date.valueOf(complaint.getSubmissionDate()));
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    LOGGER.info("Complaint added successfully: " + complaintId);
                    return rs.getString("COMPLAINTID");
                }
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error adding complaint: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public Complaint getComplaintById(String complaintId) {
        String sql = "SELECT * FROM COMPLAINT WHERE COMPLAINTID = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, complaintId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Complaint complaint = new Complaint(
                            rs.getString("COMPLAINTID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getString("CUSTOMERID"),
                            rs.getString("COMPTYPE"),
                            rs.getString("CATEGORY"),
                            rs.getString("DESCRIPTION"),
                            rs.getString("CONTACTMETHOD"),
                            rs.getString("CONTACT"),
                            rs.getString("STATUS"),
                            rs.getDate("SUBMISSIONDATE").toLocalDate(),
                            rs.getDate("LASTUPDATE") != null ? rs.getDate("LASTUPDATE").toLocalDate() : null,
                            rs.getString("NOTE")
                    );
                    LOGGER.info("Complaint retrieved: " + complaintId);
                    return complaint;
                }
                LOGGER.warning("No complaint found with ID: " + complaintId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving complaint: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Complaint> getComplaintsByCustomerId(String customerId) {
        String sql = "SELECT * FROM COMPLAINT WHERE CUSTOMERID = ? ORDER BY SUBMISSIONDATE DESC";
        List<Complaint> complaints = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Complaint complaint = new Complaint(
                            rs.getString("COMPLAINTID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getString("CUSTOMERID"),
                            rs.getString("COMPTYPE"),
                            rs.getString("CATEGORY"),
                            rs.getString("DESCRIPTION"),
                            rs.getString("CONTACTMETHOD"),
                            rs.getString("CONTACT"),
                            rs.getString("STATUS"),
                            rs.getDate("SUBMISSIONDATE").toLocalDate(),
                            rs.getDate("LASTUPDATE") != null ? rs.getDate("LASTUPDATE").toLocalDate() : null,
                            rs.getString("NOTE")
                    );
                    complaints.add(complaint);
                }
                LOGGER.info("Complaints retrieved for customer: " + customerId);
                return complaints;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving complaints: " + e.getMessage());
            return complaints;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Complaint> getComplaintsByConsumerNumber(long consumerNumber) {
        String sql = "SELECT * FROM COMPLAINT WHERE CONSUMERNUMBER = ? ORDER BY SUBMISSIONDATE DESC";
        List<Complaint> complaints = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Complaint complaint = new Complaint(
                            rs.getString("COMPLAINTID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getString("CUSTOMERID"),
                            rs.getString("COMPTYPE"),
                            rs.getString("CATEGORY"),
                            rs.getString("DESCRIPTION"),
                            rs.getString("CONTACTMETHOD"),
                            rs.getString("CONTACT"),
                            rs.getString("STATUS"),
                            rs.getDate("SUBMISSIONDATE").toLocalDate(),
                            rs.getDate("LASTUPDATE") != null ? rs.getDate("LASTUPDATE").toLocalDate() : null,
                            rs.getString("NOTE")
                    );
                    complaints.add(complaint);
                }
                LOGGER.info("Complaints retrieved for consumer: " + consumerNumber);
                return complaints;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving complaints: " + e.getMessage());
            return complaints;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean updateComplaintStatus(String complaintId, String status, String note) {
        String sql = "UPDATE COMPLAINT SET STATUS = ?, NOTE = ?, LASTUPDATE = ? WHERE COMPLAINTID = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, status);
                stmt.setString(2, note);
                stmt.setDate(3, Date.valueOf(LocalDate.now()));
                stmt.setString(4, complaintId);
                int rows = stmt.executeUpdate();
                LOGGER.info("Complaint status updated successfully: " + complaintId);
                return rows > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error updating complaint status: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Complaint> getComplaintsByDateRange(String customerId, LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT * FROM COMPLAINT WHERE CUSTOMERID = ? AND SUBMISSIONDATE BETWEEN ? AND ? ORDER BY SUBMISSIONDATE DESC";
        List<Complaint> complaints = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, customerId);
                stmt.setDate(2, Date.valueOf(startDate));
                stmt.setDate(3, Date.valueOf(endDate));
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Complaint complaint = new Complaint(
                            rs.getString("COMPLAINTID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getString("CUSTOMERID"),
                            rs.getString("COMPTYPE"),
                            rs.getString("CATEGORY"),
                            rs.getString("DESCRIPTION"),
                            rs.getString("CONTACTMETHOD"),
                            rs.getString("CONTACT"),
                            rs.getString("STATUS"),
                            rs.getDate("SUBMISSIONDATE").toLocalDate(),
                            rs.getDate("LASTUPDATE") != null ? rs.getDate("LASTUPDATE").toLocalDate() : null,
                            rs.getString("NOTE")
                    );
                    complaints.add(complaint);
                }
                LOGGER.info("Complaints retrieved for customer " + customerId + " between " + startDate + " and " + endDate);
                return complaints;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving complaints by date range: " + e.getMessage());
            return complaints;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }
}