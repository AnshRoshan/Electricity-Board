<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f4f8;
            color: #333;
        }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .welcome-section {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .admin-features {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        .feature-card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .feature-icon {
            font-size: 36px;
            margin-bottom: 15px;
            color: #3498db;
        }
        .feature-title {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 10px;
        }
        .feature-description {
            color: #7f8c8d;
            margin-bottom: 15px;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .footer {
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-size: 14px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>PowerPay Admin Dashboard</h1>
    </div>
    
    <div class="container">
        <% 
            // Check if admin is logged in
            // This is a placeholder - implement proper admin session check
            boolean isAdminLoggedIn = true; // Replace with actual session check
            
            if (!isAdminLoggedIn) {
                response.sendRedirect("../login.jsp");
                return;
            }
        %>
        
        <div class="welcome-section">
            <h2>Welcome, Admin!</h2>
            <p>Manage customers, consumers, bills, and complaints from this dashboard.</p>
        </div>
        
        <div class="admin-features">
            <div class="feature-card">
                <div class="feature-icon">👤</div>
                <h3 class="feature-title">Add Customer</h3>
                <p class="feature-description">Register new customers to the system</p>
                <a href="addCustomer.jsp" class="btn">Manage</a>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">⚡</div>
                <h3 class="feature-title">Add Consumer</h3>
                <p class="feature-description">Add new electricity consumers</p>
                <a href="addConsumer.jsp" class="btn">Manage</a>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🔄</div>
                <h3 class="feature-title">Update Consumer</h3>
                <p class="feature-description">Modify existing consumer details</p>
                <a href="updateConsumer.jsp" class="btn">Manage</a>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">❌</div>
                <h3 class="feature-title">Remove Consumer</h3>
                <p class="feature-description">Remove consumers from the system</p>
                <a href="removeConsumer.jsp" class="btn">Manage</a>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">📝</div>
                <h3 class="feature-title">Add Bill</h3>
                <p class="feature-description">Generate new bills for consumers</p>
                <a href="addBill.jsp" class="btn">Manage</a>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3 class="feature-title">View Bills</h3>
                <p class="feature-description">View and manage all bills</p>
                <a href="viewBill.jsp" class="btn">Manage</a>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">📢</div>
                <h3 class="feature-title">View Complaints</h3>
                <p class="feature-description">Handle customer complaints</p>
                <a href="viewComplaints.jsp" class="btn">Manage</a>
            </div>
        </div>
        
        <div class="footer">
            <p>&copy; 2023 PowerPay Electricity Services. All rights reserved.</p>
        </div>
    </div>
</body>
</html>