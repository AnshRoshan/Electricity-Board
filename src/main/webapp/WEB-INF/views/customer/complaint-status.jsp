<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.anshroshan.electric.models.Complaint" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Status</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .complaint-table { width: 100%; border-collapse: collapse; }
        .complaint-table th, .complaint-table td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        .complaint-table th { background-color: #f2f2f2; }
        .complaint-table tr:nth-child(even) { background-color: #f9f9f9; }
        .complaint-table tr:hover { background-color: #f2f2f2; }
        .status-pending { color: orange; }
        .status-inprogress { color: blue; }
        .status-resolved { color: green; }
        .status-closed { color: gray; }
        .back-link { margin-bottom: 20px; display: block; }
        .no-complaints { padding: 20px; background-color: #f9f9f9; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <h2>Complaint Status</h2>
    
    <a href="home" class="back-link">Back to Dashboard</a>
    
    <% 
        List<Complaint> complaints = (List<Complaint>)request.getAttribute("complaints");
        if (complaints == null || complaints.isEmpty()) { 
    %>
        <div class="no-complaints">
            <p>No complaints found.</p>
            <a href="register-complaint">Register a new complaint</a>
        </div>
    <% } else { %>
        <table class="complaint-table">
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>Type</th>
                    <th>Category</th>
                    <th>Submission Date</th>
                    <th>Status</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <% for (Complaint complaint : complaints) { 
                    String statusClass = "";
                    if ("PENDING".equalsIgnoreCase(complaint.getStatus())) {
                        statusClass = "status-pending";
                    } else if ("IN PROGRESS".equalsIgnoreCase(complaint.getStatus())) {
                        statusClass = "status-inprogress";
                    } else if ("RESOLVED".equalsIgnoreCase(complaint.getStatus())) {
                        statusClass = "status-resolved";
                    } else if ("CLOSED".equalsIgnoreCase(complaint.getStatus())) {
                        statusClass = "status-closed";
                    }
                %>
                    <tr>
                        <td><%= complaint.getComplaintId() %></td>
                        <td><%= complaint.getCompType() %></td>
                        <td><%= complaint.getCategory() %></td>
                        <td><%= complaint.getSubmissionDate() %></td>
                        <td class="<%= statusClass %>"><%= complaint.getStatus() %></td>
                        <td><a href="complaint-details?id=<%= complaint.getComplaintId() %>">View Details</a></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>