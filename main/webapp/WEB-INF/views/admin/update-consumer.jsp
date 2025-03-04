<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Consumer</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .form-group { margin: 10px 0; }
    </style>
</head>
<body>
    <h2>Update Consumer</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>

    <c:if test="${not empty consumer}">
        <form action="add-consumer?action=update" method="post">
            <input type="hidden" name="consumerId" value="${consumer.consumerId}">
            <div class="form-group">
                <label>ConsumerID (Read-Only):</label>
                <input type="text" value="${consumer.consumerId}" readonly>
            </div>
            <div class="form-group">
                <label>Customer ID (Read-Only):</label>
                <input type="text" value="${consumer.customerId}" readonly>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <textarea name="address" required>${consumer.address}</textarea>
            </div>
            <div class="form-group">
                <label>Phone Number (10 digits):</label>
                <input type="text" name="phoneNumber" value="${consumer.phoneNumber}" required pattern="\d{10}" title="Enter a 10-digit number">
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" value="${consumer.email}" required>
            </div>
            <div class="form-group">
                <label>Customer Type:</label>
                <select name="customerType" required>
                    <option value="Residential" <c:if test="${consumer.customerType == 'Residential'}">selected</c:if>>Residential</option>
                    <option value="Commercial" <c:if test="${consumer.customerType == 'Commercial'}">selected</c:if>>Commercial</option>
                </select>
            </div>
            <button type="submit">Update</button>
            <a href="add-consumer">Back</a>
        </form>
    </c:if>
</body>
</html>