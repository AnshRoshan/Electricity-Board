<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<%@ page import="com.anshroshan.electric.models.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .bill-info {
            margin-bottom: 30px;
        }
        .bill-info table {
            width: 100%;
            border-collapse: collapse;
        }
        .bill-info th, .bill-info td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .bill-info th {
            width: 30%;
            background-color: #f2f2f2;
        }
        .status-paid {
            color: green;
            font-weight: bold;
        }
        .status-unpaid {
            color: red;
            font-weight: bold;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 10px;
        }
        .btn-back {
            background-color: #555;
        }
        .btn-pay {
            background-color: #4CAF50;
        }
        .btn-download {
            background-color: #2196F3;
        }
        .bill-actions {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
        .bill-total {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin: 20px 0;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bill Details</h1>
        
        <% 
            String billIdStr = request.getParameter("billId");
            Customer customer = (Customer) session.getAttribute("customer");
            Bill selectedBill = null;
            
            if (customer != null && billIdStr != null) {
                int billId = Integer.parseInt(billIdStr);
                
                // Find the bill in the customer's consumers
                for (Consumerconsumer : customer.getConsumerList()) {
                    for (Bill bill : consumer.getBills()) {
                        if (bill.getBillId() == billId) {
                            selectedBill = bill;
                            break;
                        }
                    }
                    if (selectedBill != null) break;
                }
            } else {
                response.sendRedirect("../viewBills.jsp");
                return;
            }
            
            if (selectedBill == null) {
        %>
            <div class="error">
                <p>Bill not found. Please go back and try again.</p>
                <a href="viewBills.jsp" class="btn btn-back">Back to Bills</a>
            </div>
        <% } else { 
            String status = selectedBill.getStatus();
            String statusClass = "Paid".equals(status) ? "status-paid" : "status-unpaid";
        %>
            <div class="bill-info">
                <table>
                    <tr>
                        <th>Bill Number:</th>
                        <td><%= selectedBill.getBillId() %></td>
                    </tr>
                    <tr>
                        <th>ConsumerNumber:</th>
                        <td><%= selectedBill.getConsumerNumber() %></td>
                    </tr>
                    <tr>
                        <th>Billing Period:</th>
                        <td><%= selectedBill.getPeriod() %></td>
                    </tr>
                    <tr>
                        <th>Bill Date:</th>
                        <td><%= selectedBill.getBillDate() %></td>
                    </tr>
                    <tr>
                        <th>Due Date:</th>
                        <td><%= selectedBill.getDueDate() %></td>
                    </tr>
                    <tr>
                        <th>Disconsumer Date:</th>
                        <td><%= selectedBill.getDisconsumerDate() != null ? selectedBill.getDisconsumerDate() : "N/A" %></td>
                    </tr>
                    <tr>
                        <th>Amount:</th>
                        <td>$<%= String.format("%.2f", selectedBill.getAmount()) %></td>
                    </tr>
                    <tr>
                        <th>Late Fee:</th>
                        <td>$<%= String.format("%.2f", selectedBill.getLateFee()) %></td>
                    </tr>
                    <tr>
                        <th>Status:</th>
                        <td class="<%= statusClass %>"><%= status %></td>
                    </tr>
                </table>
            </div>
            
            <div class="bill-total">
                Total Payable Amount: $<%= String.format("%.2f", "Paid".equals(status) ? 0 : selectedBill.getAmount() + selectedBill.getLateFee()) %>
            </div>
            
            <div class="bill-actions">
                <a href="viewBills.jsp" class="btn btn-back">Back to Bills</a>
                
                <div>
                    <% if (!"Paid".equals(status)) { %>
                        <a href="payment.jsp?billId=<%= selectedBill.getBillId() %>" class="btn btn-pay">Pay Now</a>
                    <% } %>
                    <a href="#" class="btn btn-download">Download PDF</a>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>