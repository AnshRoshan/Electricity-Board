<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bills</title>
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
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1, h2, h3 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .search-section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
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
        select {
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
        .btn-success {
            background-color: #2ecc71;
        }
        .btn-success:hover {
            background-color: #27ae60;
        }
        .actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
            color: #2c3e50;
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
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #3498db;
            transition: background-color 0.3s ease;
        }
        .pagination a:hover {
            background-color: #f2f2f2;
        }
        .pagination a.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        .no-bills {
            padding: 20px;
            text-align: center;
            background-color: #f9f9f9;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>PowerPay Admin - View Bills</h1>
    </div>
    
    <div class="container">
        <h2>Manage Bills</h2>
        
        <div class="search-section">
            <h3>Search Bills</h3>
            <form action="viewBill.jsp" method="get">
                <div class="form-group">
                    <label for="searchConsumerNumber">ConsumerNumber:</label>
                    <input type="text" id="searchConsumerNumber" name="searchConsumerNumber">
                </div>
                
                <div class="form-group">
                    <label for="searchStatus">Bill Status:</label>
                    <select id="searchStatus" name="searchStatus">
                        <option value="">All Statuses</option>
                        <option value="Paid">Paid</option>
                        <option value="Unpaid">Unpaid</option>
                    </select>
                </div>
                
                <button type="submit" class="btn">Search</button>
                <a href="viewBill.jsp" class="btn btn-secondary">Clear Filters</a>
            </form>
        </div>
        
        <% 
            // This is a placeholder - in a real application, you would fetch bills from the database
            // based on search criteria
            String searchConsumerNumber = request.getParameter("searchConsumerNumber");
            String searchStatus = request.getParameter("searchStatus");
            
            // Create a dummy list of bills for demonstration
            List<Bill> bills = new ArrayList<>();
            
            // Simulate some bills
            if (true) { // In a real app, this would be: if (bills != null && !bills.isEmpty())
                // Add some dummy data for demonstration
                Bill bill1 = new Bill();
                bill1.setBillId(1001);
                bill1.setConsumerNumber("CN100101");
                bill1.setPeriod("Jan 2023");
                bill1.setBillDate("2023-01-05");
                bill1.setDueDate("2023-01-25");
                bill1.setAmount(125.50);
                bill1.setStatus("Paid");
                
                Bill bill2 = new Bill();
                bill2.setBillId(1002);
                bill2.setConsumerNumber("CN100102");
                bill2.setPeriod("Jan 2023");
                bill2.setBillDate("2023-01-05");
                bill2.setDueDate("2023-01-25");
                bill2.setAmount(210.75);
                bill2.setStatus("Unpaid");
                
                Bill bill3 = new Bill();
                bill3.setBillId(1003);
                bill3.setConsumerNumber("CN100103");
                bill3.setPeriod("Jan 2023");
                bill3.setBillDate("2023-01-05");
                bill3.setDueDate("2023-01-25");
                bill3.setAmount(175.25);
                bill3.setStatus("Unpaid");
                
                // Add bills to the list
                bills.add(bill1);
                bills.add(bill2);
                bills.add(bill3);
                
                // Filter bills based on search criteria (in a real app, this would be done in the database query)
                if (searchConsumerNumber != null && !searchConsumerNumber.isEmpty()) {
                    List<Bill> filteredBills = new ArrayList<>();
                    for (Bill bill : bills) {
                        if (bill.getConsumerNumber().contains(searchConsumerNumber)) {
                            filteredBills.add(bill);
                        }
                    }
                    bills = filteredBills;
                }
                
                if (searchStatus != null && !searchStatus.isEmpty()) {
                    List<Bill> filteredBills = new ArrayList<>();
                    for (Bill bill : bills) {
                        if (bill.getStatus().equals(searchStatus)) {
                            filteredBills.add(bill);
                        }
                    }
                    bills = filteredBills;
                }
        %>
        
        <table>
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>ConsumerNumber</th>
                    <th>Period</th>
                    <th>Bill Date</th>
                    <th>Due Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Bill bill : bills) { 
                    String statusClass = "Paid".equals(bill.getStatus()) ? "status-paid" : "status-unpaid";
                %>
                <tr>
                    <td><%= bill.getBillId() %></td>
                    <td><%= bill.getConsumerNumber() %></td>
                    <td><%= bill.getPeriod() %></td>
                    <td><%= bill.getBillDate() %></td>
                    <td><%= bill.getDueDate() %></td>
                    <td>$<%= String.format("%.2f", bill.getAmount()) %></td>
                    <td class="<%= statusClass %>"><%= bill.getStatus() %></td>
                    <td class="action-buttons">
                        <a href="billDetails.jsp?billId=<%= bill.getBillId() %>" class="btn">View</a>
                        <% if ("Unpaid".equals(bill.getStatus())) { %>
                            <a href="markAsPaid.jsp?billId=<%= bill.getBillId() %>" class="btn btn-success">Mark Paid</a>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">Next</a>
        </div>
        
        <% } else { %>
        <div class="no-bills">
            <p>No bills found matching your criteria.</p>
        </div>
        <% } %>
        
        <div class="actions">
            <a href="adminHome.jsp" class="btn btn-secondary">Back to Dashboard</a>
            <a href="addBill.jsp" class="btn">Generate New Bill</a>
        </div>
    </div>
</body>
</html>