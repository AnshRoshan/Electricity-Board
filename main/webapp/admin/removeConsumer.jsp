<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Consumer</title>
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
        h1, h2, h3 {
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
        input[type="text"] {
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
        .btn-danger {
            background-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
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
        .warning-message {
            padding: 10px;
            background-color: #fff3cd;
            color: #856404;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .search-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        .consumer-details {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .consumer-details p {
            margin: 8px 0;
        }
        .confirm-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>PowerPay Admin - Remove Consumer</h1>
    </div>
    
    <div class="container">
        <h2>Remove Existing Consumer</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                Consumerremoved successfully!
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                Error removing consumer. Please try again.
            </div>
        <% } %>
        
        <div class="search-section">
            <h3>Find Consumer</h3>
            <form action="removeConsumer.jsp" method="get">
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
        <div class="consumer-details">
            <h3>ConsumerDetails</h3>
            <p><strong>ConsumerNumber:</strong> <%= consumer.getConsumerNumber() %></p>
            <p><strong>Consumer Type:</strong> <%= consumer.getConsumerType() %></p>
            <p><strong>Address:</strong> <%= consumer.getAddress() %></p>
            <p><strong>Meter Number:</strong> <%= consumer.getMeterNumber() %></p>
            <p><strong>Load Amount:</strong> <%= consumer.getLoadAmount() %> kW</p>
        </div>
        
        <div class="warning-message">
            <strong>Warning:</strong> Removing a consumer will delete all associated data including bills and payment history. This action cannot be undone.
        </div>
        
        <div class="confirm-section">
            <h3>Confirm Removal</h3>
            <form action="../RemoveConsumerServlet" method="post">
                <input type="hidden" name="consumerNumber" value="<%= consumer.getConsumerNumber() %>">
                
                <div class="actions">
                    <a href="adminHome.jsp" class="btn btn-secondary">Back to Dashboard</a>
                    <button type="submit" class="btn btn-danger">Remove Consumer</button>
                </div>
            </form>
        </div>
        <% } else if (searchConsumerNumber != null) { %>
            <div class="error-message">
                Consumernot found. Please check the consumer number and try again.
            </div>
        <% } %>
    </div>
</body>
</html>