<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Bill Management</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .bg-gradient {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<!-- Header -->
<header class="bg-gradient text-white py-6">
    <div class="container mx-auto px-6">
        <h1 class="text-3xl font-bold">Admin - Bill Management</h1>
        <a href="logout" class="text-white hover:underline float-right">Logout</a>
    </div>
</header>

<!-- Main Content -->
<div class="container mx-auto px-6 py-8">
    <% if (request.getAttribute("error") != null) { %>
    <p class="text-red-500 text-center mb-4"><%= request.getAttribute("error") %></p>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
    <p class="text-green-500 text-center mb-4"><%= request.getAttribute("message") %></p>
    <% } %>

    <!-- Add Bill Form -->
    <div class="bg-white p-6 rounded-lg shadow-lg mb-8">
        <h2 class="text-2xl font-semibold text-gray-800 mb-4">Add New Bill</h2>
        <form method="post" action="admin/bills" class="space-y-4">
            <div>
                <label for="consumerNumber" class="block text-sm font-medium text-gray-700">Consumer Number</label>
                <input type="number" id="consumerNumber" name="consumerNumber" required
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <div>
                <label for="amount" class="block text-sm font-medium text-gray-700">Amount</label>
                <input type="number" step="0.01" id="amount" name="amount" required
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <div>
                <label for="period" class="block text-sm font-medium text-gray-700">Billing Period</label>
                <input type="text" id="period" name="period" required placeholder="e.g., June 2025"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <div>
                <label for="billDate" class="block text-sm font-medium text-gray-700">Bill Date</label>
                <input type="date" id="billDate" name="billDate" required
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <div>
                <label for="dueDate" class="block text-sm font-medium text-gray-700">Due Date</label>
                <input type="date" id="dueDate" name="dueDate" required
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <div>
                <label for="disconnectionDate" class="block text-sm font-medium text-gray-700">Disconnection Date (Optional)</label>
                <input type="date" id="disconnectionDate" name="disconnectionDate"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <div>
                <label for="lateFee" class="block text-sm font-medium text-gray-700">Late Fee</label>
                <input type="number" step="0.01" id="lateFee" name="lateFee" value="0" required
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
            </div>
            <button type="submit"
                    class="w-full bg-blue-600 text-white font-semibold py-2 px-4 rounded-md hover:bg-blue-700 transition duration-300">
                Add Bill
            </button>
        </form>
    </div>

    <!-- View Bills -->
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-semibold text-gray-800 mb-4">View Bills</h2>
        <form method="get" action="admin/bills" class="mb-6">
            <div class="flex gap-4">
                <input type="number" name="consumerNumber" placeholder="Enter Consumer Number"
                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                <button type="submit"
                        class="bg-blue-600 text-white font-semibold py-2 px-4 rounded-md hover:bg-blue-700 transition duration-300">
                    View
                </button>
            </div>
        </form>
        <c:if test="${not empty bills}">
            <table class="w-full border-collapse">
                <thead>
                <tr class="bg-gray-200">
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
                        <td class="p-3">${bill.billId}</td>
                        <td class="p-3">${bill.period}</td>
                        <td class="p-3">${bill.amount + bill.lateFee}</td>
                        <td class="p-3">${bill.dueDate}</td>
                        <td class="p-3">${bill.status}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty bills and param.consumerNumber != null}">
            <p class="text-gray-600 text-center">No bills found for this consumer.</p>
        </c:if>
    </div>
</div>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-6">
    <div class="container mx-auto px-6 text-center">
        <p>© <%= java.time.Year.now() %> Electricity Management. All rights reserved.</p>
    </div>
</footer>
</body>
</html>