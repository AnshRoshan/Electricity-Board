<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Home</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .welcome { font-size: 24px; color: #333; }
        .profile, .bill-summary { border: 1px solid #ccc; padding: 10px; margin: 10px 0; }
        .actions { margin-top: 20px; }
        .action-btn { 
            display: inline-block; 
            padding: 8px 15px; 
            background-color: #4CAF50; 
            color: white; 
            text-decoration: none; 
            margin-right: 10px;
            border-radius: 4px;
        }
        .action-btn:hover { background-color: #45a049; }
        .logout { float: right; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="logout">
        <a href="logout">Logout</a>
    </div>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
    
    <div class="welcome">
        Welcome, <%= request.getAttribute("customerName") != null ? request.getAttribute("customerName") : "Customer" %>!
    </div>
    
    <div class="profile">
        <h3>Your Profile</h3>
        <p><strong>Customer ID:</strong> <%= request.getAttribute("customerId") %></p>
        <p><strong>Name:</strong> <%= request.getAttribute("customerName") %></p>
        <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
        <p><strong>Mobile:</strong> <%= request.getAttribute("mobile") %></p>
        <p><strong>Address:</strong> <%= request.getAttribute("address") %></p>
    </div>
    
    <div class="bill-summary">
        <h3>Bill Summary</h3>
        <% if (request.getAttribute("currentBill") != null) { %>
            <p><strong>Current Bill Amount:</strong> $<%= request.getAttribute("currentBillAmount") %></p>
            <p><strong>Due Date:</strong> <%= request.getAttribute("dueDate") %></p>
            <p><strong>Status:</strong> <%= request.getAttribute("billStatus") %></p>
            <% if ("UNPAID".equals(request.getAttribute("billStatus"))) { %>
                <a href="payment?billId=<%= request.getAttribute("billId") %>" class="action-btn">Pay Now</a>
            <% } %>
        <% } else { %>
            <p>No current bills found.</p>
        <% } %>
    </div>
    
    <div class="actions">
        <h3>Quick Actions</h3>
        <a href="view-bills" class="action-btn">View All Bills</a>
        <a href="bill-history" class="action-btn">Payment History</a>
        <a href="register-complaint" class="action-btn">Register Complaint</a>
        <a href="complaint-status" class="action-btn">Check Complaint Status</a>
    </div>
</body>
</html>