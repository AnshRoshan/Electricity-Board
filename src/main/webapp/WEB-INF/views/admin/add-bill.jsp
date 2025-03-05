<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Bill</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .form-group { margin: 10px 0; }
    </style>
</head>
<body>
    <h2>Add New Bill</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
        <p><strong>Bill ID:</strong> ${bill.billId}</p>
        <p><strong>ConsumerID:</strong> ${bill.consumerNumber}</p>
        <p><strong>Billing Period:</strong> ${bill.billingPeriod}</p>
        <p><strong>Bill Date:</strong> ${bill.billDate}</p>
        <p><strong>Due Date:</strong> ${bill.dueDate}</p>
        <p><strong>Disconsumer Date:</strong> ${bill.disconsumerDate}</p>
        <p><strong>Bill Amount:</strong> $${bill.billAmount}</p>
        <p><strong>Late Fee:</strong> $${bill.lateFee}</p>
        <p><strong>Status:</strong> ${bill.status}</p>
        <a href="add-bill">Add Another Bill</a> | <a href="dashboard">Back to Dashboard</a>
    </c:if>

    <c:if test="${empty success}">
        <form action="add-bill" method="post">
            <div class="form-group">
                <label>ConsumerID:</label>
                <input type="text" name="consumerId" required>
            </div>
            <div class="form-group">
                <label>Billing Period (e.g., June 2024):</label>
                <input type="text" name="billingPeriod" required>
            </div>
            <div class="form-group">
                <label>Bill Date:</label>
                <input type="date" name="billDate" required>
            </div>
            <div class="form-group">
                <label>Due Date:</label>
                <input type="date" name="dueDate" required>
            </div>
            <div class="form-group">
                <label>Disconsumer Date (optional):</label>
                <input type="date" name="disconsumerDate">
            </div>
            <div class="form-group">
                <label>Bill Amount:</label>
                <input type="number" name="billAmount" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label>Late Fee (optional):</label>
                <input type="number" name="lateFee" step="0.01" min="0" value="0">
            </div>
            <div class="form-group">
                <label>Status:</label>
                <select name="status" required>
                    <option value="Unpaid">Unpaid</option>
                    <option value="Paid">Paid</option>
                </select>
            </div>
            <button type="submit">Save</button>
            <a href="dashboard">Cancel</a>
        </form>
    </c:if>
</body>
</html>