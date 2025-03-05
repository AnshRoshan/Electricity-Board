<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
</head>
<body>
<h2>Customer Login</h2>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<form action="login" method="post">
    <label>User ID:</label>
    <input type="text" name="userId" required><br>

    <label>Password:</label>
    <input type="password" name="password" required><br>

    <input type="submit" value="Login">
</form>

<c:if test="${promptChangePassword}">
    <p>Please change your default password:</p>
    <form action="change-password" method="post">
        <div class="form-group">
            <label>New Password:</label>
            <input type="password" name="newPassword" required>
        </div>
        <div class="form-group">
            <label>Confirm Password:</label>
            <input type="password" name="confirmPassword" required>
        </div>
        <button type="submit">Change Password</button>
    </form>
</c:if>
<p>Not registered? <a href="register">Register here</a></p>
</body>
</html>
