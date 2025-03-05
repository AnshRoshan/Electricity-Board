<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
    <style>
        .error { color: red; }
        .success { color: green; }
    </style>
</head>
<body>
    <h2>Customer Registration</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if (request.getAttribute("message") != null) { %>
        <p class="success"><%= request.getAttribute("message") %></p>
        <p>Customer ID: <%= request.getAttribute("customerId") %></p>
        <p>Customer Name: <%= request.getAttribute("customerName") %></p>
        <p>Email: <%= request.getAttribute("email") %></p>
    <% } else { %>
        <form action="register" method="post">
            <label>ConsumerNumber (13 digits):</label><br>
            <input type="text" name="consumerNumber" required><br>

            <label>Full Name:</label><br>
            <input type="text" name="fullName" required><br>

            <label>Address:</label><br>
            <textarea name="address" required></textarea><br>

            <label>Email:</label><br>
            <input type="email" name="email" required><br>

            <label>Mobile Number (10 digits):</label><br>
            <input type="text" name="mobileNumber" required><br>

            <label>Customer Type:</label><br>
            <select name="customerType" required>
                <option value="Residential">Residential</option>
                <option value="Commercial">Commercial</option>
            </select><br>

            <label>User ID (5-20 characters):</label><br>
            <input type="text" name="userId" required><br>

            <label>Password:</label><br>
            <input type="password" name="password" required><br>

            <label>Confirm Password:</label><br>
            <input type="password" name="confirmPassword" required><br>

            <input type="submit" value="Register">
        </form>
    <% } %>
</body>
</html>