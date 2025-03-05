<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Customer" %>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        .header {
            background-color: #3a86ff;
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
        .dashboard-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }
        .card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            flex: 1 1 300px;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-title {
            color: #3a86ff;
            margin-top: 0;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }
        .card-content {
            margin-top: 15px;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3a86ff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #2a75e0;
        }
        .recent-bills {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .status-paid {
            color: green;
            font-weight: bold;
        }
        .status-unpaid {
            color: red;
            font-weight: bold;
        }
        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            font-size: 14px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>PowerPay Customer Dashboard</h1>
    </div>
    
    <div class="container">
        <% 
            Customer customer = (Customer) session.getAttribute("customer");
            if (customer == null) {
                response.sendRedirect("../login.jsp");
                return;
            }
        %>
        
        <div class="welcome-section">
            <h2>Welcome, <%= customer.getName() %>!</h2>
            <p>Manage your electricity bills and services from this dashboard.</p>
        </div>
        
        <div class="dashboard-cards">
            <div class="card">
                <h3 class="card-title">My Profile</h3>
                <div class="card-content">
                    <p><strong>Name:</strong> <%= customer.getName() %></p>
                    <p><strong>Email:</strong> <%= customer.getEmail() %></p>
                    <p><strong>Phone:</strong> <%= customer.getPhone() %></p>
                    <a href="../profile.jsp" class="btn">View Profile</a>
                </div>
            </div>
            
            <div class="card">
                <h3 class="card-title">Quick Actions</h3>
                <div class="card-content">
                    <p><a href="viewBills.jsp" class="btn">View Bills</a></p>
                    <p><a href="../registerComplaint.jsp" class="btn">Register Complaint</a></p>
                    <p><a href="../viewComplaints.jsp" class="btn">View Complaints</a></p>
                </div>
            </div>
            
            <div class="card">
                <h3 class="card-title">Consumption Summary</h3>
                <div class="card-content">
                    <p>View your electricity consumption patterns and history.</p>
                    <a href="../billHistory.jsp" class="btn">View History</a>
                </div>
            </div>
        </div>
        
        <div class="recent-bills">
            <h3>Recent Bills</h3>
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>ConsumerNumber</th>
                        <th>Period</th>
                        <th>Amount</th>
                        <th>Due Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    boolean foundBills = false;
                    if (customer != null && customer.getConsumerList() != null) {
                        for (Consumer consumer : customer.getConsumerList()) {
                            if (consumer.getBills() != null) {
                                for (Bill bill : consumer.getBills()) {
                                    foundBills = true;
                                    String statusClass = "Paid".equals(bill.getStatus()) ? "status-paid" : "status-unpaid";
                    %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= bill.getConsumerNumber() %></td>
                        <td><%= bill.getPeriod() %></td>
                        <td>$<%= String.format("%.2f", bill.getAmount()) %></td>
                        <td><%= bill.getDueDate() %></td>
                        <td class="<%= statusClass %>"><%= bill.getStatus() %></td>
                        <td>
                            <a href="billDetails.jsp?billId=<%= bill.getBillId() %>" class="btn">View</a>
                        </td>
                    </tr>
                    <% 
                                }
                            }
                        }
                    }
                    
                    if (!foundBills) {
                    %>
                    <tr>
                        <td colspan="7">No recent bills found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="footer">
            <p>&copy; 2023 PowerPay Electricity Services. All rights reserved.</p>
        </div>
    </div>
</body>
</html>