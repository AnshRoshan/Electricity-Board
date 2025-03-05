<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Consumer</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .form-group { margin: 10px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .action-links a, .action-links button { margin-right: 10px; }
    </style>
</head>
<body>
    <h2>Add New Consumer</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>

    <!-- Search Customer Form -->
    <form action="add-consumer" method="get">
        <div class="form-group">
            <label>Search Customer by ID:</label>
            <input type="text" name="customerId" value="${param.customerId}" required>
            <button type="submit">Search</button>
        </div>
    </form>

    <!-- Add ConsumerForm and ConsumerList -->
    <c:if test="${not empty customer}">
        <h3>Customer: ${customer.fullName} (ID: ${customer.customerId})</h3>

        <!-- Add New ConsumerForm -->
        <form action="add-consumer" method="post">
            <input type="hidden" name="customerId" value="${customer.customerId}">
            <div class="form-group">
                <label>ConsumerID (13 digits):</label>
                <input type="text" name="consumerId" required pattern="\d{13}" title="Enter a 13-digit number">
            </div>
            <div class="form-group">
                <label>Address:</label>
                <textarea name="address" required></textarea>
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
            <button type="submit">Add Consumer</button>
        </form>

        <!-- List of Linked Consumers -->
        <h3>Linked Consumers</h3>
        <table>
            <thead>
                <tr>
                    <th>ConsumerID</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Customer Type</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="consumer" items="${consumers}">
                    <tr>
                        <td>${consumer.consumerId}</td>
                        <td>${consumer.address}</td>
                        <td>${consumer.phoneNumber}</td>
                        <td>${consumer.email}</td>
                        <td>${consumer.customerType}</td>
                        <td class="action-links">
                            <a href="add-consumer?action=update&consumerId=${consumer.consumerId}">Edit</a>
                            <form action="add-consumer?action=delete" method="post" style="display:inline;" 
                                  onsubmit="return confirm('Are you sure you want to remove this consumer? This action cannot be undone');">
                                <input type="hidden" name="consumerId" value="${consumer.consumerId}">
                                <button type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty consumers}">
                    <tr><td colspan="6">No consumers linked yet.</td></tr>
                </c:if>
            </tbody>
        </table>
    </c:if>
</body>
</html>