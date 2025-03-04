<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Consumer</title>
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
        h1, h2 {
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
        .search-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>PowerPay Admin - Update Consumer</h1>
    </div>
    
    <div class="container">
        <h2>Update Existing Consumer</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                Consumerupdated successfully!
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                Error updating consumer. Please try again.
            </div>
        <% } %>
        
        <div class="search-section">
            <h3>Find Consumer</h3>
            <form action="updateConsumer.jsp" method="get">
                <div class="form-group">
                    <label for="searchConsumerNumber">ConsumerNumber:</label>
                    <input type="text" id="searchConsumerNumber" name="searchConsumerNumber" required>
                </div>
                <button type="submit" class="btn">Search</button>
            </form>
        </div>
        
        <% 
            // This is a placeholder - in a real application, you would fetch the consumer from the database
            String searchConsumerNumber = request.getParameter("searchConsumerNumber");
            Consumerconsumer = null;
            
            if (searchConsumerNumber != null && !searchConsumerNumber.isEmpty()) {
                // Simulate finding a consumer
                // In a real application, you would query the database
                // consumer = consumerDAO.findByConsumerNumber(searchConsumerNumber);
                
                // For demonstration, create a dummy consumer if search parameter exists
                consumer = new Consumer();
                consumer.setConsumerNumber(searchConsumerNumber);
                consumer.setConsumerType("Residential");
                consumer.setAddress("123 Main St, Anytown");
                consumer.setMeterNumber("M-12345");
                consumer.setLoadAmount(5.5);
            }
            
            if (consumer != null) {
        %>
        <form action="../UpdateConsumerServlet" method="post">
            <input type="hidden" name="consumerNumber" value="<%= consumer.getConsumerNumber() %>">
            
            <div class="form-group">
                <label for="consumerType">Consumer Type:</label>
                <select id="consumerType" name="consumerType" required>
                    <option value="Residential" <%= "Residential".equals(consumer.getConsumerType()) ? "selected" : "" %>>Residential</option>
                    <option value="Commercial" <%= "Commercial".equals(consumer.getConsumerType()) ? "selected" : "" %>>Commercial</option>
                    <option value="Industrial" <%= "Industrial".equals(consumer.getConsumerType()) ? "selected" : "" %>>Industrial</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="address">Consumer Address:</label>
                <textarea id="address" name="address" rows="3" required><%= consumer.getAddress() %></textarea>
            </div>
            
            <div class="form-group">
                <label for="meterNumber">Meter Number:</label>
                <input type="text" id="meterNumber" name="meterNumber" value="<%= consumer.getMeterNumber() %>" required>
            </div>
            
            <div class="form-group">
                <label for="loadAmount">Load Amount (kW):</label>
                <input type="text" id="loadAmount" name="loadAmount" value="<%= consumer.getLoadAmount() %>" required>
            </div>
            
            <div class="actions">
                <a href="adminHome.jsp" class="btn btn-secondary">Back to Dashboard</a>
                <button type="submit" class="btn">Update Consumer</button>
            </div>
        </form>
        <% } else if (searchConsumerNumber != null) { %>
            <div class="error-message">
                Consumernot found. Please check the consumer number and try again.
            </div>
        <% } %>
    </div>
</body>
</html>