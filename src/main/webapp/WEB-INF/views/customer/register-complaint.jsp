<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register Complaint</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .form-group { margin: 10px 0; }
    </style>
    <script>
        function updateCategories() {
            const complaintType = document.getElementById("complaintType").value;
            const category = document.getElementById("category");
            category.innerHTML = "";
            let options = [];
            if (complaintType === "billing_issue") {
                options = ["Incorrect Amount", "Missing Bill", "Payment Issue"];
            } else if (complaintType === "power_outage") {
                options = ["Partial Outage", "Complete Outage"];
            } else if (complaintType === "meter_reading_issue") {
                options = ["Wrong Reading", "Meter Malfunction"];
            }
            options.forEach(opt => {
                const option = document.createElement("option");
                option.value = opt;
                option.text = opt;
                category.appendChild(option);
            });
        }
    </script>
</head>
<body>
    <h2>Register a Complaint</h2>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
        <p class="success"><%= request.getAttribute("success") %></p>
        <p><strong>Complaint ID:</strong> <%= request.getAttribute("complaintId") %></p>
        <p><strong>Estimated Resolution Time:</strong> <%= request.getAttribute("resolutionTime") %></p>
        <% 
            Complaint complaint = (Complaint)request.getAttribute("complaint");
            if (complaint != null) {
        %>
            <p><strong>Summary:</strong> <%= complaint.getCompType() %> - <%= complaint.getCategory() %> - <%= complaint.getDescription() %></p>
        <% } %>
        <a href="home">Back to Dashboard</a> | <a href="complaint-status">View Status</a>
    <% } else { %>
        <form action="register-complaint" method="post">
            <div class="form-group">
                <label>Complaint Type:</label>
                <select id="complaintType" name="complaintType" onchange="updateCategories()" required>
                    <option value="">Select Type</option>
                    <option value="billing_issue">Billing Issue</option>
                    <option value="power_outage">Power Outage</option>
                    <option value="meter_reading_issue">Meter Reading Issue</option>
                </select>
            </div>
            <div class="form-group">
                <label>Category:</label>
                <select id="category" name="category" required>
                    <option value="">Select Category</option>
                </select>
            </div>
            <div class="form-group">
                <label>Description (max 500 chars):</label>
                <textarea name="description" maxlength="500" required></textarea>
            </div>
            <div class="form-group">
                <label>Preferred Contact Method:</label>
                <input type="radio" name="contactMethod" value="email" required> Email
                <input type="radio" name="contactMethod" value="phone"> Phone
            </div>
            <div class="form-group">
                <label>Contact Details:</label>
                <input type="text" name="contactDetails" value="${customer.email}" required>
            </div>
            <button type="submit">Submit</button>
            <button type="reset" onclick="location.reload()">Reset</button>
        </form>
    <% } %>
</body>
</html>