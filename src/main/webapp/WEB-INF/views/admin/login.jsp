<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
</head>
<body>
    <h2>Admin Login</h2>
    <form action="/login" method="post">
        <label>User ID:</label><input type="text" name="userId"><br>
        <label>Password:</label><input type="password" name="password"><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>