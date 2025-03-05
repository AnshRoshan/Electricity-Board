<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Customer</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .form-group { margin: 10px 0; }
    </style>
</head>
<body>
    <h2>Add New Customer</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
        <p><strong>Customer ID:</strong> ${customerId}</p>
        <p><strong>Customer Name:</strong> ${customerName}</p>
        <p><strong>Email:</strong> ${email}</p>
        <a href="add-consumer">Add ConsumerID</a>
    </c:if>

    <c:if test="${empty success}">
        <form action="add-customer" method="post">
            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="fullName" required>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <textarea name="address" required></textarea>
            </div>
            <div class="form-group">
                <label>ConsumerNumber (13 digits):</label>
                <input type="text" name="consumerNumber" required pattern="\d{13}" title="Enter a 13-digit number">
            </div>
            <div class="form-group">
                <label>Phone Number (10 digits):</label>
                <input type="text" name="phoneNumber" required pattern="\d{10}" title="Enter a 10-digit number">
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Customer Type:</label>
                <select name="customerType" required>
                    <option value="Residential">Residential</option>
                    <option value="Commercial">Commercial</option>
                </select>
            </div>
            <div class="form-group">
                <label>User ID (5-20 chars):</label>
                <input type="text" name="userId" required minlength="5" maxlength="20">
            </div>
            <button type="submit">Add Customer</button>
        </form>
    </c:if>
</body>
</html>