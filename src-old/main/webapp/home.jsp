<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Electricity Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .bg-gradient {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<!-- Navbar -->
<nav class="bg-gradient text-white py-4 shadow-md">
    <div class="container mx-auto px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold">Electricity Management</h1>
        <div class="space-x-4">
            <form method="post" action="home" class="inline">
                <input type="hidden" name="action" value="viewBills">
                <input type="hidden" name="consumerNumber" value="${consumerNumber}">
                <button type="submit" class="hover:text-blue-200">View Bills</button>
            </form>
            <a href="complaint" class="hover:text-blue-200">Register Complaint</a>
            <a href="profile" class="hover:text-blue-200">Profile</a>
            <a href="logout" class="hover:text-blue-200">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto px-6 py-8">
    <h2 class="text-3xl font-bold text-gray-800 mb-6">Welcome, ${customer.name}!</h2>
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h3 class="text-xl font-semibold text-gray-800 mb-4">Latest Bill</h3>
        <c:choose>
            <c:when test="${latestBill != null}">
                <p><strong>Billing Period:</strong> ${latestBill.period}</p>
                <p><strong>Due Date:</strong> ${latestBill.dueDate}</p>
                <p><strong>Amount Due:</strong> ${latestBill.amount + latestBill.lateFee}</p>
                <p><strong>Status:</strong> ${latestBill.status}</p>
                <c:if test="${latestBill.status == 'Unpaid'}">
                    <form method="post" action="home" class="mt-4">
                        <input type="hidden" name="action" value="payBills">
                        <input type="hidden" name="selectedBills" value="${latestBill.billId}">
                        <button type="submit" class="bg-blue-600 text-white font-semibold py-2 px-4 rounded-md hover:bg-blue-700 transition duration-300">
                            Pay Now
                        </button>
                    </form>
                </c:if>
            </c:when>
            <c:otherwise>
                <p class="text-gray-600">No bills available yet.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-6 mt-8">
    <div class="container mx-auto px-6 text-center">
        <p>© <%= java.time.Year.now() %> Electricity Management. All rights reserved.</p>
    </div>
</footer>
</body>
</html>