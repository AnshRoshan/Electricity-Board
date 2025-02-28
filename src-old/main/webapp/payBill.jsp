<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay Bill - Electricity Management</title>
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
    <h2 class="text-3xl font-bold text-gray-800 mb-6">Payment Summary</h2>
    <% if (request.getAttribute("error") != null) { %>
    <p class="text-red-500 text-center mb-4"><%= request.getAttribute("error") %></p>
    <% } %>
    <p class="text-lg mb-4"><strong>Total Amount:</strong> ${totalAmount}</p>
    <form method="post" action="payBill" class="bg-white p-6 rounded-lg shadow-lg space-y-4">
        <c:forEach var="billId" items="${selectedBillIds}">
            <input type="hidden" name="billIds" value="${billId}">
        </c:forEach>
        <input type="hidden" name="totalAmount" value="${totalAmount}">
        <div>
            <label for="method" class="block text-sm font-medium text-gray-700">Payment Method</label>
            <select id="method" name="method" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                <option value="Credit">Credit Card</option>
                <option value="Debit">Debit Card</option>
                <option value="Net Banking">Net Banking</option>
            </select>
        </div>
        <div>
            <label for="cardNumber" class="block text-sm font-medium text-gray-700">Card Number</label>
            <input type="text" id="cardNumber" name="cardNumber" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
        </div>
        <div>
            <label for="expiryDate" class="block text-sm font-medium text-gray-700">Expiry Date (YYYY-MM)</label>
            <input type="text" id="expiryDate" name="expiryDate" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
        </div>
        <div>
            <label for="cvv" class="block text-sm font-medium text-gray-700">CVV</label>
            <input type="text" id="cvv" name="cvv" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
        </div>
        <button type="submit" class="w-full bg-blue-600 text-white font-semibold py-2 px-4 rounded-md hover:bg-blue-700 transition duration-300">
            Pay
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