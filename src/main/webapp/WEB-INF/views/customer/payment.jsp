<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<!DOCTYPE html>
<html>
<head>
    <title>Make Payment</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .payment-form { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .error { color: red; margin-bottom: 15px; }
        .bill-summary { margin-bottom: 20px; padding: 15px; background-color: #f9f9f9; border-radius: 4px; }
        .back-link { display: block; margin-bottom: 20px; }
    </style>
</head>
<body>
    <a href="view-bills" class="back-link">Back to Bills</a>
    
    <div class="payment-form">
        <h2>Make Payment</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <% 
            Bill bill = (Bill) request.getAttribute("bill");
            if (bill != null) { 
        %>
            <div class="bill-summary">
                <h3>Bill Summary</h3>
                <p><strong>Bill Number:</strong> <%= bill.getBillNumber() %></p>
                <p><strong>Billing Date:</strong> <%= bill.getBillingDate() %></p>
                <p><strong>Due Date:</strong> <%= bill.getDueDate() %></p>
                <p><strong>Amount Due:</strong> ₹<%= bill.getAmount() %></p>
            </div>
            
            <form action="process-payment" method="post">
                <input type="hidden" name="billId" value="<%= bill.getBillId() %>">
                
                <div class="form-group">
                    <label for="paymentMethod">Payment Method:</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="">Select Payment Method</option>
                        <option value="Credit Card">Credit Card</option>
                        <option value="Debit Card">Debit Card</option>
                        <option value="Net Banking">Net Banking</option>
                        <option value="UPI">UPI</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="cardNumber">Card Number / UPI ID:</label>
                    <input type="text" id="cardNumber" name="cardNumber" required>
                </div>
                
                <button type="submit">Make Payment</button>
            </form>
        <% } else { %>
            <p>Bill information not available. Please go back and try again.</p>
        <% } %>
    </div>
</body>
</html>