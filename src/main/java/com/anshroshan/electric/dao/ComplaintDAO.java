package com.anshroshan.electric.dao;

import com.anshroshan.electric.models.Complaint;
import com.anshroshan.electric.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class ComplaintDAO {

    public String saveComplaint(Complaint complaint) throws SQLException {
        String sql = "INSERT INTO COMPLAINT (COMPLAINTID, CONSUMERNUMBER, CUSTOMERID, COMPTYPE, CATEGORY, " +
                "DESCRIPTION, CONTACTMETHOD, CONTACT, STATUS, SUBMISSIONDATE, LASTUPDATE) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String complaintId = UUID.randomUUID().toString();

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);
            pstmt.setLong(2, complaint.getConsumerNumber());
            pstmt.setString(3, complaint.getCustomerId());
            pstmt.setString(4, complaint.getCompType());
            pstmt.setString(5, complaint.getCategory());
            pstmt.setString(6, complaint.getDescription());
            pstmt.setString(7, complaint.getContactMethod());
            pstmt.setString(8, complaint.getContact());
            pstmt.setString(9, "PENDING");
            pstmt.setDate(10, new java.sql.Date(new java.util.Date().getTime()));
            pstmt.setDate(11, new java.sql.Date(new java.util.Date().getTime()));

            pstmt.executeUpdate();
            return complaintId;
        }
    }

    public Map<String, String[]> getCategoriesByType() {
        Map<String, String[]> categories = new HashMap<>();
        categories.put("billing_issue", new String[] { "Overcharging", "Payment Error", "Bill Dispute" });
        categories.put("power_outage", new String[] { "Partial Outage", "Complete Outage", "Frequent Outages" });
        categories.put("meter_reading_issue", new String[] { "Incorrect Reading", "Meter Failure", "Access Issue" });
        return categories;
    }

    /**
     * Retrieves a complaint by its ID
     * 
     * @param complaintId The ID of the complaint to retrieve
     * @return The Complaint object if found, null otherwise
     * @throws SQLException If a database error occurs
     */
    public Complaint getComplaintById(String complaintId) throws SQLException {
        String sql = "SELECT * FROM COMPLAINT WHERE COMPLAINTID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToComplaint(rs);
                }
            }
        }

        return null;
    }

    /**
     * Retrieves all complaints for a specific customer
     * 
     * @param customerId The ID of the customer
     * @return A list of Complaint objects for the customer
     * @throws SQLException If a database error occurs
     */
    public List<Complaint> getComplaintsByCustomerId(String customerId) throws SQLException {
        String sql = "SELECT * FROM COMPLAINT WHERE CUSTOMERID = ? ORDER BY SUBMISSIONDATE DESC";
        List<Complaint> complaints = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, customerId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    complaints.add(mapResultSetToComplaint(rs));
                }
            }
        }

        return complaints;
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
        String sql = "UPDATE COMPLAINT SET STATUS = ?, LASTUPDATE = ?";

        // If status is RESOLVED or CLOSED and resolution details are provided, update
        // resolution fields
        if (("RESOLVED".equalsIgnoreCase(status) || "CLOSED".equalsIgnoreCase(status))
                && resolutionDetails != null && !resolutionDetails.isEmpty()) {
            sql += ", RESOLUTIONDATE = ?, RESOLUTIONDETAILS = ?";
        }

        sql += " WHERE COMPLAINTID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            pstmt.setString(paramIndex++, status.toUpperCase());
            pstmt.setDate(paramIndex++, new java.sql.Date(new java.util.Date().getTime()));

            if (("RESOLVED".equalsIgnoreCase(status) || "CLOSED".equalsIgnoreCase(status))
                    && resolutionDetails != null && !resolutionDetails.isEmpty()) {
                pstmt.setDate(paramIndex++, new java.sql.Date(new java.util.Date().getTime()));
                pstmt.setString(paramIndex++, resolutionDetails);
            }

            pstmt.setString(paramIndex, complaintId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * Maps a ResultSet row to a Complaint object
     * 
     * @param rs The ResultSet containing complaint data
     * @return A Complaint object populated with data from the ResultSet
     * @throws SQLException If a database error occurs
     */
    private Complaint mapResultSetToComplaint(ResultSet rs) throws SQLException {
        Complaint complaint = new Complaint();

        complaint.setComplaintId(rs.getString("COMPLAINTID"));
        complaint.setConsumerNumber(rs.getLong("CONSUMERNUMBER"));
        complaint.setCustomerId(rs.getString("CUSTOMERID"));
        complaint.setCompType(rs.getString("COMPTYPE"));
        complaint.setCategory(rs.getString("CATEGORY"));
        complaint.setDescription(rs.getString("DESCRIPTION"));
        complaint.setContactMethod(rs.getString("CONTACTMETHOD"));
        complaint.setContact(rs.getString("CONTACT"));
        complaint.setStatus(rs.getString("STATUS"));
        complaint.setSubmissionDate(rs.getDate("SUBMISSIONDATE"));
        complaint.setLastUpdateDate(rs.getDate("LASTUPDATE"));

        // Handle optional fields
        complaint.setResolutionDate(rs.getDate("RESOLUTIONDATE"));
        complaint.setResolutionDetails(rs.getString("RESOLUTIONDETAILS"));
        complaint.setEstimatedResolutionTime(rs.getInt("ESTIMATEDRESOLUTIONTIME"));

        return complaint;
    }
}