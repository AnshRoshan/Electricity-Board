<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Confirmation</title>
    <style>
        .confirmation { margin: 20px; }
    </style>
</head>
<body>
    <div class="confirmation">
        <h2>Payment Successful!</h2>
        <p><strong>Transaction ID:</strong> ${payment.transactionId}</p>
        <p><strong>Receipt Number:</strong> ${payment.receiptNumber}</p>
        <p><strong>Transaction Date:</strong> ${payment.transactionDate}</p>
        <p><strong>Transaction Type:</strong> ${payment.transactionType}</p>
        <p><strong>Bill Numbers:</strong> ${payment.billIds}</p>
        <p><strong>Transaction Amount:</strong> $${payment.transactionAmount}</p>
        <p><strong>Transaction Status:</strong> ${payment.transactionStatus}</p>
        <a href="bill-history">View Bill History</a> | <a href="home">Back to Dashboard</a>
    </div>
</body>
</html>