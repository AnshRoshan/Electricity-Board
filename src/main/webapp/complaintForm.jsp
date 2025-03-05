<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Complaint</title>
    <script>
        function updateCategories() {
            var complaintType = document.getElementById("complaintType").value;
            var category = document.getElementById("category");
            category.innerHTML = "";

            var categories = {
                <c:forEach items="${categories}" var="entry">
                "${entry.key}": ${entry.value},
                </c:forEach>
            };

            if (categories[complaintType]) {
                categories[complaintType].forEach(function(cat) {
                    var option = document.createElement("option");
                    option.value = cat;
                    option.text = cat;
                    category.appendChild(option);
                });
            }
        }
    </script>
</head>
<body>
<h2>Register Complaint</h2>
<c:if test="${not empty error}">
    <div style="color: red">${error}</div>
</c:if>

<form action="ComplaintServlet" method="post">
    <label>ConsumerNumber:</label>
    <input type="number" name="consumerNumber" required><br>

    <label>Customer ID:</label>
    <input type="text" name="customerId" value="${sessionScope.customerId}" required><br>

    <label>Complaint Type:</label>
    <select name="complaintType" id="complaintType" onchange="updateCategories()" required>
        <option value="">Select Type</option>
        <option value="billing issue">Billing Issue</option>
        <option value="power outage">Power Outage</option>
        <option value="meter reading issue">Meter Reading Issue</option>
    </select><br>

    <label>Category:</label>
    <select name="category" id="category" required>
        <option value="">Select Category</option>
    </select><br>

    <label>Description:</label>
    <textarea name="description" rows="4" cols="50" maxlength="1024" required></textarea><br>

    <label>Preferred Contact Method:</label>
    <input type="radio" name="contactMethod" value="email" required>Email
    <input type="radio" name="contactMethod" value="phone">Phone<br>

    <label>Contact:</label>
    <input type="text" name="contact" value="${sessionScope.userContact}" maxlength="128" required><br>

    <input type="submit" value="Submit">
    <input type="reset" value="Reset">
</form>
</body>
</html>