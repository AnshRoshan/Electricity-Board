<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Details</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .bill-container { max-width: 800px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .bill-header { text-align: center; margin-bottom: 20px; }
        .bill-details { margin-bottom: 30px; }
        .bill-details table { width: 100%; border-collapse: collapse; }
        .bill-details th, .bill-details td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
        .bill-details th { width: 30%; background-color: #f2f2f2; }
        .bill-total { font-size: 18px; font-weight: bold; text-align: right; margin: 20px 0; padding: 10px; background-color: #f9f9f9; border-radius: 4px; }
        .bill-actions { display: flex; justify-content: space-between; margin-top: 30px; }
        .btn { display: inline-block; padding: 10px 15px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px; margin-right: 10px; }
        .btn-back { background-color: #555; }
        .btn-pay { background-color: #4CAF50; }
        .btn-download { background-color: #2196F3; }
        .status-paid { color: green; font-weight: bold; }
        .status-unpaid { color: red; font-weight: bold; }
        .error { color: red; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="bill-container">
        <div class="bill-header">
            <h1>Bill Details</h1>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% 
            Bill bill = (Bill) request.getAttribute("bill");
            if (bill == null) {
        %>
            <div class="error">
                <p>Bill not found. Please go back and try again.</p>
                <a href="view-bills" class="btn btn-back">Back to Bills</a>
            </div>
        <% } else { 
            String status = bill.getStatus();
            String statusClass = "Paid".equals(status) ? "status-paid" : "status-unpaid";
        %>
            <div class="bill-details">
                <table>
                    <tr>
                        <th>Bill Number:</th>
                        <td><%= bill.getBillId() %></td>
                    </tr>
                    <tr>
                        <th>ConsumerNumber:</th>
                        <td><%= bill.getConsumerNumber() %></td>
                    </tr>
                    <tr>
                        <th>Billing Period:</th>
                        <td><%= bill.getPeriod() %></td>
                    </tr>
                    <tr>
                        <th>Bill Date:</th>
                        <td><%= bill.getBillDate() %></td>
                    </tr>
                    <tr>
                        <th>Due Date:</th>
                        <td><%= bill.getDueDate() %></td>
                    </tr>
                    <tr>
                        <th>Disconsumer Date:</th>
                        <td><%= bill.getDisconsumerDate() != null ? bill.getDisconsumerDate() : "N/A" %></td>
                    </tr>
                    <tr>
                        <th>Amount:</th>
                        <td>$<%= String.format("%.2f", bill.getAmount()) %></td>
                    </tr>
                    <tr>
                        <th>Late Fee:</th>
                        <td>$<%= String.format("%.2f", bill.getLateFee()) %></td>
                    </tr>
                    <tr>
                        <th>Status:</th>
                        <td class="<%= statusClass %>"><%= status %></td>
                    </tr>
                </table>
            </div>
            
            <div class="bill-total">
                Total Payable Amount: $<%= String.format("%.2f", "Paid".equals(status) ? 0 : bill.getAmount() + bill.getLateFee()) %>
            </div>
            
            <div class="bill-actions">
                <a href="view-bills" class="btn btn-back">Back to Bills</a>
                
                <div>
                    <% if (!"Paid".equals(status)) { %>
                        <a href="payment?billId=<%= bill.getBillId() %>" class="btn btn-pay">Pay Now</a>
                    <% } %>
                    <a href="#" class="btn btn-download">Download PDF</a>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>