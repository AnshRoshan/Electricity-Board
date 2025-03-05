<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<%@ page import="com.anshroshan.electric.models.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
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
        .bill-summary {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .bill-summary p {
            margin: 5px 0;
        }
        .amount {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin: 15px 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-back {
            background-color: #555;
        }
        .btn-pay {
            background-color: #4CAF50;
        }
        .btn-group {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bill Payment</h1>
        
        <% 
            String billIdStr = request.getParameter("billId");
            Customer customer = (Customer) session.getAttribute("customer");
            Bill selectedBill = null;
            
            if (customer != null && billIdStr != null) {
                int billId = Integer.parseInt(billIdStr);
                
                // Find the bill in the customer's consumers
                for (Consumer consumer : customer.getConsumerList()) {
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
            
            if (selectedBill != null && !"Paid".equals(selectedBill.getStatus())) {
                double totalAmount = selectedBill.getAmount() + selectedBill.getLateFee();
        %>
            <div class="bill-summary">
                <p><strong>Bill Number:</strong> <%= selectedBill.getBillId() %></p>
                <p><strong>ConsumerNumber:</strong> <%= selectedBill.getConsumerNumber() %></p>
                <p><strong>Billing Period:</strong> <%= selectedBill.getPeriod() %></p>
                <p><strong>Due Date:</strong> <%= selectedBill.getDueDate() %></p>
                <div class="amount">Total Amount: $<%= String.format("%.2f", totalAmount) %></div>
            </div>
            
            <form action="../processPayment" method="post">
                <input type="hidden" name="billId" value="<%= selectedBill.getBillId() %>">
                <input type="hidden" name="amount" value="<%= totalAmount %>">
                
                <div class="form-group">
                    <label for="paymentMethod">Payment Method:</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="">Select Payment Method</option>
                        <option value="credit_card">Credit Card</option>
                        <option value="debit_card">Debit Card</option>
                        <option value="net_banking">Net Banking</option>
                        <option value="upi">UPI</option>
                    </select>
                </div>
                
                <div id="cardDetails" style="display:none;">
                    <div class="form-group">
                        <label for="cardNumber">Card Number:</label>
                        <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456">
                    </div>
                    <div class="form-group">
                        <label for="cardName">Name on Card:</label>
                        <input type="text" id="cardName" name="cardName" placeholder="John Doe">
                    </div>
                    <div style="display: flex; gap: 10px;">
                        <div class="form-group" style="flex: 1;">
                            <label for="expiryDate">Expiry Date:</label>
                            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY">
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <label for="cvv">CVV:</label>
                            <input type="text" id="cvv" name="cvv" placeholder="123">
                        </div>
                    </div>
                </div>
                
                <div id="upiDetails" style="display:none;">
                    <div class="form-group">
                        <label for="upiId">UPI ID:</label>
                        <input type="text" id="upiId" name="upiId" placeholder="name@upi">
                    </div>
                </div>
                
                <div id="netBankingDetails" style="display:none;">
                    <div class="form-group">
                        <label for="bank">Select Bank:</label>
                        <select id="bank" name="bank">
                            <option value="">Select Bank</option>
                            <option value="sbi">State Bank of India</option>
                            <option value="hdfc">HDFC Bank</option>
                            <option value="icici">ICICI Bank</option>
                            <option value="axis">Axis Bank</option>
                        </select>
                    </div>
                </div>
                
                <div class="btn-group">
                    <a href="billDetails.jsp?billId=<%= selectedBill.getBillId() %>" class="btn btn-back">Back</a>
                    <button type="submit" class="btn btn-pay">Pay Now</button>
                </div>
            </form>
            
            <script>
                document.getElementById('paymentMethod').addEventListener('change', function() {
                    const method = this.value;
                    document.getElementById('cardDetails').style.display = 
                        (method === 'credit_card' || method === 'debit_card') ? 'block' : 'none';
                    document.getElementById('upiDetails').style.display = 
                        (method === 'upi') ? 'block' : 'none';
                    document.getElementById('netBankingDetails').style.display = 
                        (method === 'net_banking') ? 'block' : 'none';
                });
            </script>
        <% } else { %>
            <div class="error">
                <p>Bill information not available or already paid. Please go back and try again.</p>
                <a href="viewBills.jsp" class="btn btn-back">Back to Bills</a>
            </div>
        <% } %>
    </div>
</body>
</html>