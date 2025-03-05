<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Complaint History</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .form-group { margin: 10px 0; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        .status-pending { background-color: #ffcccc; }
        .status-in-progress { background-color: #ffffcc; }
        .status-resolved { background-color: #ccffcc; }
    </style>
</head>
<body>
    <h2>Complaint History</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>

    <form action="view-complaint-history" method="get">
        <div class="form-group">
            <label>ConsumerNumber:</label>
            <input type="text" name="consumerNumber" value="${param.consumerNumber}">
        </div>
        <div class="form-group">
            <label>Complaint ID:</label>
            <input type="text" name="complaintId" value="${param.complaintId}">
        </div>
        <div class="form-group">
            <label>Complaint Type:</label>
            <select name="complaintType">
                <option value="">All</option>
                <option value="billing_issue">Billing Issue</option>
                <option value="power_outage">Power Outage</option>
                <option value="meter_reading_issue">Meter Reading Issue</option>
            </select>
        </div>
        <div class="form-group">
            <label>Start Date:</label>
            <input type="date" name="startDate" value="${param.startDate}">
            <label>End Date:</label>
            <input type="date" name="endDate" value="${param.endDate}">
        </div>
        <button type="submit">Search</button>
    </form>

    <c:if test="${not empty complaints}">
        <table>
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>ConsumerNumber</th>
                    <th>Type</th>
                    <th>Date Submitted</th>
                    <th>Status</th>
                    <th>Last Updated</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="complaint" items="${complaints}">
                    <tr class="status-${complaint.status.toLowerCase().replace(' ', '-')}">
                        <td>${complaint.complaintId}</td>
                        <td>${complaint.consumerNumber}</td>
                        <td>${complaint.complaintType}</td>
                        <td>${complaint.dateSubmitted}</td>
                        <td>
                            <form action="view-complaint-history" method="post">
                                <input type="hidden" name="complaintId" value="${complaint.complaintId}">
                                <select name="status" onchange="this.form.submit()">
                                    <option value="Pending" <c:if test="${complaint.status == 'Pending'}">selected</c:if>>Pending</option>
                                    <option value="In Progress" <c:if test="${complaint.status == 'In Progress'}">selected</c:if>>In Progress</option>
                                    <option value="Resolved" <c:if test="${complaint.status == 'Resolved'}">selected</c:if>>Resolved</option>
                                    <option value="Closed" <c:if test="${complaint.status == 'Closed'}">selected</c:if>>Closed</option>
                                </select>
                                <input type="text" name="notes" value="${complaint.notes}" placeholder="Add notes">
                            </form>
                        </td>
                        <td>${complaint.lastUpdatedDate}</td>
                        <td><a href="#">View Details</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="#">Export to PDF</a> | <a href="#">Export to CSV</a>
    </c:if>
</body>
</html>