<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Customer" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Consumer</title>
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
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #2c3e50;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .btn-secondary {
            background-color: #7f8c8d;
        }
        .btn-secondary:hover {
            background-color: #6c7a7d;
        }
        .actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .success-message {
            padding: 10px;
            background-color: #d4edda;
            color: #155724;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .error-message {
            padding: 10px;
            background-color: #f8d7da;
            color: #721c24;
            border-radius: 4px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>PowerPay Admin - Add Consumer</h1>
    </div>
    
    <div class="container">
        <h2>Add New Consumer</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                Consumeradded successfully!
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                Error adding consumer. Please try again.
            </div>
        <% } %>
        
        <form action="../AddConsumerServlet" method="post">
            <div class="form-group">
                <label for="customerId">Select Customer:</label>
                <select id="customerId" name="customerId" required>
                    <option value="">-- Select Customer --</option>
                    <% 
                    // This is a placeholder - in a real application, you would fetch customers from the database
                    // List<Customer> customers = customerDAO.getAllCustomers();
                    // for (Customer customer : customers) {
                    %>
                    <!-- <option value="<%= // customer.getId() %>"><%= // customer.getName() %> (<%= // customer.getEmail() %>)</option> -->
                    <% // } %>
                    
                    <!-- Placeholder options for demonstration -->
                    <option value="1">John Doe (john@example.com)</option>
                    <option value="2">Jane Smith (jane@example.com)</option>
                    <option value="3">Robert Johnson (robert@example.com)</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="consumerNumber">ConsumerNumber:</label>
                <input type="text" id="consumerNumber" name="consumerNumber" required>
            </div>
            
            <div class="form-group">
                <label for="consumerType">Consumer Type:</label>
                <select id="consumerType" name="consumerType" required>
                    <option value="">-- Select Consumer Type --</option>
                    <option value="Residential">Residential</option>
                    <option value="Commercial">Commercial</option>
                    <option value="Industrial">Industrial</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="address">Consumer Address:</label>
                <textarea id="address" name="address" rows="3" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="meterNumber">Meter Number:</label>
                <input type="text" id="meterNumber" name="meterNumber" required>
            </div>
            
            <div class="form-group">
                <label for="loadAmount">Load Amount (kW):</label>
                <input type="text" id="loadAmount" name="loadAmount" required>
            </div>
            
            <div class="actions">
                <a href="adminHome.jsp" class="btn btn-secondary">Back to Dashboard</a>
                <button type="submit" class="btn">Add Consumer</button>
            </div>
        </form>
    </div>
</body>
</html>