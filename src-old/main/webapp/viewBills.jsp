<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bills - Electricity Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .bg-gradient {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<nav class="bg-gradient text-white py-4 shadow-md">
    <div class="container mx-auto px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold">Electricity Management</h1>
        <div class="space-x-4">
            <a href="home" class="hover:text-blue-200">Home</a>
            <a href="complaint" class="hover:text-blue-200">Register Complaint</a>
            <a href="profile" class="hover:text-blue-200">Profile</a>
            <a href="logout" class="hover:text-blue-200">Logout</a>
        </div>
    </div>
</nav>

<div class="container mx-auto px-6 py-8">
    <h2 class="text-3xl font-bold text-gray-800 mb-6">Your Bills</h2>
    <% if (request.getAttribute("error") != null) { %>
    <p class="text-red-500 text-center mb-4"><%= request.getAttribute("error") %></p>
    <% } %>
    <form method="post" action="home">
        <input type="hidden" name="action" value="payBills">
        <table class="w-full border-collapse bg-white rounded-lg shadow-lg">
            <thead>
            <tr class="bg-gray-200">
                <th class="p-3 text-left">Select</th>
                <th class="p-3 text-left">Bill ID</th>
                <th class="p-3 text-left">Period</th>
                <th class="p-3 text-left">Amount</th>
                <th class="p-3 text-left">Due Date</th>
                <th class="p-3 text-left">Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="bill" items="${bills}">
                <tr class="border-b">
                    <td class="p-3">
                        <input type="checkbox" name="selectedBills" value="${bill.billId}" ${bill.status == 'Paid' ? 'disabled' : ''}>
                    </td>
                    <td class="p-3">${bill.billId}</td>
                    <td class="p-3">${bill.period}</td>
                    <td class="p-3">${bill.amount + bill.lateFee}</td>
                    <td class="p-3">${bill.dueDate}</td>
                    <td class="p-3">${bill.status}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <button type="submit" class="mt-4 bg-blue-600 text-white font-semibold py-2 px-4 rounded-md hover:bg-blue-700 transition duration-300">
            Proceed to Pay
        </button>
    </form>
    <a href="home" class="mt-4 inline-block text-blue-600 hover:underline">Back to Home</a>
</div>

<footer class="bg-gray-800 text-white py-6 mt-8">
    <div class="container mx-auto px-6 text-center">
        <p>© <%= java.time.Year.now() %> Electricity Management. All rights reserved.</p>
    </div>
</footer>
</body>
</html>