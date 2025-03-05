<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.util.ArrayList" %>
            <%@ page import="com.anshroshan.electric.models.Complaint" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>View Complaints</title>
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
                            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                        }

                        .container {
                            max-width: 1200px;
                            margin: 20px auto;
                            padding: 20px;
                            background-color: white;
                            border-radius: 5px;
                            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                        }

                        h1,
                        h2,
                        h3 {
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

                        th,
                        td {
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

                        .status-open {
                            color: #e67e22;
                            font-weight: bold;
                        }

                        .status-inprogress {
                            color: #3498db;
                            font-weight: bold;
                        }

                        .status-resolved {
                            color: green;
                            font-weight: bold;
                        }

                        .status-closed {
                            color: #7f8c8d;
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

                        .no-complaints {
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
                        <h1>PowerPay Admin - View Complaints</h1>
                    </div>

                    <div class="container">
                        <h2>Manage Customer Complaints</h2>

                        <div class="search-section">
                            <h3>Search Complaints</h3>
                            <form action="viewComplaints.jsp" method="get">
                                <div class="form-group">
                                    <label for="searchCustomerId">Customer ID:</label>
                                    <input type="text" id="searchCustomerId" name="searchCustomerId">
                                </div>

                                <div class="form-group">
                                    <label for="searchStatus">Complaint Status:</label>
                                    <select id="searchStatus" name="searchStatus">
                                        <option value="">All Statuses</option>
                                        <option value="Open">Open</option>
                                        <option value="In Progress">In Progress</option>
                                        <option value="Resolved">Resolved</option>
                                        <option value="Closed">Closed</option>
                                    </select>
                                </div>

                                <button type="submit" class="btn">Search</button>
                                <a href="viewComplaints.jsp" class="btn btn-secondary">Clear Filters</a>
                            </form>
                        </div>

                        <% // This is a placeholder - in a real application, you would fetch complaints from the
                            database // based on search criteria String
                            searchCustomerId=request.getParameter("searchCustomerId"); String
                            searchStatus=request.getParameter("searchStatus"); // Create a dummy list of complaints for
                            demonstration List<Complaint> complaints = new ArrayList<>();

                                // Simulate some complaints
                                if (true) { // In a real app, this would be: if (complaints != null &&
                                !complaints.isEmpty())
                                // Add some dummy data for demonstration
                                Complaint complaint1 = new Complaint();
                                complaint1.setId(1001);
                                complaint1.setCustomerId(101);
                                complaint1.setCustomerName("John Doe");
                                complaint1.setSubject("Power Outage");
                                complaint1.setDescription("Frequent power cuts in my area for the past week.");
                                complaint1.setStatus("Open");
                                complaint1.setCreatedDate("2023-01-10");

                                Complaint complaint2 = new Complaint();
                                complaint2.setId(1002);
                                complaint2.setCustomerId(102);
                                complaint2.setCustomerName("Jane Smith");
                                complaint2.setSubject("Billing Issue");
                                complaint2.setDescription("I was charged for more units than I consumed.");
                                complaint2.setStatus("In Progress");
                                complaint2.setCreatedDate("2023-01-15");

                                Complaint complaint3 = new Complaint();
                                complaint3.setId(1003);
                                complaint3.setCustomerId(103);
                                complaint3.setCustomerName("Robert Johnson");
                                complaint3.setSubject("Meter Malfunction");
                                complaint3.setDescription("My meter is showing incorrect readings.");
                                complaint3.setStatus("Resolved");
                                complaint3.setCreatedDate("2023-01-05");
                                complaint3.setResolvedDate("2023-01-12");

                                // Add complaints to the list
                                complaints.add(complaint1);
                                complaints.add(complaint2);
                                complaints.add(complaint3);

                                // Filter complaints based on search criteria (in a real app, this would be done in the
                                database query)
                                if (searchCustomerId != null && !searchCustomerId.isEmpty()) {
                                List<Complaint> filteredComplaints = new ArrayList<>();
                                        for (Complaint complaint : complaints) {
                                        if (String.valueOf(complaint.getCustomerId()).contains(searchCustomerId)) {
                                        filteredComplaints.add(complaint);
                                        }
                                        }
                                        complaints = filteredComplaints;
                                        }

                                        if (searchStatus != null && !searchStatus.isEmpty()) {
                                        List<Complaint> filteredComplaints = new ArrayList<>();
                                                for (Complaint complaint : complaints) {
                                                if (complaint.getStatus().equals(searchStatus)) {
                                                filteredComplaints.add(complaint);
                                                }
                                                }
                                                complaints = filteredComplaints;
                                                }
                                                %>

                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Customer</th>
                                                            <th>Subject</th>
                                                            <th>Created Date</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (Complaint complaint : complaints) { String
                                                            statusClass="" ; if ("Open".equals(complaint.getStatus())) {
                                                            statusClass="status-open" ; } else if ("In
                                                            Progress".equals(complaint.getStatus())) {
                                                            statusClass="status-inprogress" ; } else if
                                                            ("Resolved".equals(complaint.getStatus())) {
                                                            statusClass="status-resolved" ; } else if
                                                            ("Closed".equals(complaint.getStatus())) {
                                                            statusClass="status-closed" ; } %>
                                                            <tr>
                                                                <td>
                                                                    <%= complaint.getId() %>
                                                                </td>
                                                                <td>
                                                                    <%= complaint.getCustomerName() %> (ID: <%=
                                                                            complaint.getCustomerId() %>)
                                                                </td>
                                                                <td>
                                                                    <%= complaint.getSubject() %>
                                                                </td>
                                                                <td>
                                                                    <%= complaint.getCreatedDate() %>
                                                                </td>
                                                                <td class="<%= statusClass %>">
                                                                    <%= complaint.getStatus() %>
                                                                </td>
                                                                <td class="action-buttons">
                                                                    <a href="complaintDetails.jsp?id=<%= complaint.getId() %>"
                                                                        class="btn">View</a>
                                                                    <% if (!"Resolved".equals(complaint.getStatus()) &&
                                                                        !"Closed".equals(complaint.getStatus())) { %>
                                                                        <a href="updateComplaintStatus.jsp?id=<%= complaint.getId() %>"
                                                                            class="btn btn-success">Update Status</a>
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
                                                    <div class="no-complaints">
                                                        <p>No complaints found matching your criteria.</p>
                                                    </div>
                                                    <% } %>

                                                        <div class="actions">
                                                            <a href="adminHome.jsp" class="btn btn-secondary">Back to
                                                                Dashboard</a>
                                                        </div>
                    </div>
                </body>

                </html>