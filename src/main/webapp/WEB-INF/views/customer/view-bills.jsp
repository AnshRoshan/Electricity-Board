<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Bills</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .bill-table { width: 100%; border-collapse: collapse; }
        .bill-table th, .bill-table td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        .bill-table th { background-color: #f2f2f2; }
        .bill-table tr:nth-child(even) { background-color: #f9f9f9; }
        .bill-table tr:hover { background-color: #f2f2f2; }
        .action-btn { 
            display: inline-block; 
            padding: 5px 10px; 
            background-color: #4CAF50; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px;
        }
        .action-btn:hover { background-color: #45a049; }
        .back-link { margin-bottom: 20px; display: block; }
        .no-bills { padding: 20px; background-color: #f9f9f9; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <h2>Your Bills</h2>
    
    <a href="home" class="back-link">Back to Dashboard</a>
    
    <% 
        List<Bill> bills = (List<Bill>)request.getAttribute("bills");
        if (bills == null || bills.isEmpty()) { 
    %>
        <div class="no-bills">
            <p>No bills found.</p>
        </div>
    <% } else { %>
        <table class="bill-table">
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Billing Period</th>
                    <th>Amount</th>
                    <th>Due Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Bill bill : bills) { %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= bill.getBillingPeriod() %></td>
                        <td>$<%= bill.getAmount() %></td>
                        <td><%= bill.getDueDate() %></td>
                        <td><%= bill.getStatus() %></td>
                        <td>
                            <a href="bill-summary?billId=<%= bill.getBillId() %>" class="action-btn">View Details</a>
                            <% if ("UNPAID".equals(bill.getStatus())) { %>
                                <a href="payment?billId=<%= bill.getBillId() %>" class="action-btn">Pay Now</a>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>
