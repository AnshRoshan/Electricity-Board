<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Summary</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .bill-container { max-width: 800px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .bill-header { text-align: center; margin-bottom: 20px; }
        .bill-details { margin-bottom: 30px; }
        .bill-details table { width: 100%; border-collapse: collapse; }
        .bill-details th, .bill-details td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        .bill-details th { background-color: #f2f2f2; }
        .bill-total { font-size: 18px; font-weight: bold; text-align: right; margin: 20px 0; }
        .bill-actions { display: flex; justify-content: space-between; margin-top: 30px; }
        .bill-actions a, .bill-actions button { 
            padding: 10px 15px; 
            text-decoration: none; 
            color: white; 
            border-radius: 4px; 
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .pay-button { background-color: #4CAF50; }
        .pay-button:hover { background-color: #45a049; }
        .back-button { background-color: #555; }
        .back-button:hover { background-color: #333; }
        .download-button { background-color: #2196F3; }
        .download-button:hover { background-color: #0b7dda; }
        .status-paid { color: green; }
        .status-unpaid { color: red; }
        .status-overdue { color: darkred; font-weight: bold; }
        .back-link { display: block; margin-bottom: 20px; }
    </style>
</head>
<body>
    <a href="view-bills" class="back-link">Back to Bills</a>
    
    <div class="bill-container">
        <% 
            Bill bill = (Bill) request.getAttribute("bill");
            if (bill != null) { 
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String status = "";
                String statusClass = "";
                
                if (bill.isPaid()) {
                    status = "PAID";
                    statusClass = "status-paid";
                } else {
                    Date today = new Date();
                    Date dueDate = bill.getDueDate();
                    
                    if (dueDate != null && today.after(dueDate)) {
                        status = "OVERDUE";
                        statusClass = "status-overdue";
                    } else {
                        status = "UNPAID";
                        statusClass = "status-unpaid";
                    }
                }
        %>
            <div class="bill-header">
                <h2>Electricity Bill</h2>
                <h3 class="<%= statusClass %>"><%= status %></h3>
            </div>
            
            <div class="bill-details">
                <table>
                    <tr>
                        <th>Bill Number:</th>
                        <td><%= bill.getBillNumber() %></td>
                        <th>ConsumerID:</th>
                        <td><%= bill.getConsumerId() %></td>
                    </tr>
                    <tr>
                        <th>Billing Date:</th>
                        <td><%= bill.getBillingDate() != null ? dateFormat.format(bill.getBillingDate()) : "N/A" %></td>
                        <th>Due Date:</th>
                        <td><%= bill.getDueDate() != null ? dateFormat.format(bill.getDueDate()) : "N/A" %></td>
                    </tr>
                    <tr>
                        <th>Billing Period:</th>
                        <td colspan="3"><%= bill.getBillingPeriod() %></td>
                    </tr>
                    <tr>
                        <th>Units Consumed:</th>
                        <td><%= bill.getUnitsConsumed() %></td>
                        <th>Rate per Unit:</th>
                        <td>₹<%= bill.getRatePerUnit() %></td>
                    </tr>
                </table>
            </div>
            
            <div class="bill-total">
                Total Amount: ₹<%= bill.getAmount() %>
            </div>
            
            <div class="bill-actions">
                <a href="view-bills" class="back-button">Back to Bills</a>
                
                <% if (!bill.isPaid()) { %>
                    <a href="payment?billId=<%= bill.getBillId() %>" class="pay-button">Pay Now</a>
                <% } %>
                
                <a href="download-bill?billId=<%= bill.getBillId() %>" class="download-button">Download PDF</a>
            </div>
        <% } else { %>
            <div class="bill-header">
                <h2>Bill Not Found</h2>
                <p>The requested bill information is not available.</p>
            </div>
        <% } %>
    </div>
</body>
</html>