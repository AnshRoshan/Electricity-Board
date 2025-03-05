<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Bills</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function updateTotal() {
            let total = 0;
            document.querySelectorAll('input[name="selectedBills"]:checked').forEach(checkbox => {
                total += parseFloat(checkbox.dataset.amount);
            });
            document.getElementById('totalAmount').innerText = total.toFixed(2);
        }
    </script>
</head>
<body class="bg-gray-100 text-gray-900">
<div class="container mx-auto p-6">
    <h2 class="text-2xl font-semibold mb-4 text-center">Your Bills</h2>

    <c:if test="${not empty error}">
        <p class="text-red-600 text-center">${error}</p>
    </c:if>

    <form action="view-bills" method="post" class="bg-white p-6 rounded-lg shadow-md">
        <div class="overflow-x-auto">
            <table class="w-full border-collapse border border-gray-300 text-sm">
                <thead>
                <tr class="bg-gray-200">
                    <th class="p-2 border">Select</th>
                    <th class="p-2 border">ConsumerID</th>
                    <th class="p-2 border">Bill Number</th>
                    <th class="p-2 border">Payment Status</th>
                    <th class="p-2 border">Consumer Type</th>
                    <th class="p-2 border">Consumer Status</th>
                    <th class="p-2 border">Mobile Number</th>
                    <th class="p-2 border">Bill Period</th>
                    <th class="p-2 border">Bill Date</th>
                    <th class="p-2 border">Due Date</th>
                    <th class="p-2 border">Disconsumer Date</th>
                    <th class="p-2 border">Due Amount</th>
                    <th class="p-2 border">Payable Amount</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="bill" items="${bills}">
                    <tr class="hover:bg-gray-100">
                        <td class="p-2 border text-center">
                            <input type="checkbox" name="selectedBills" value="${bill.billId}"
                                   data-amount="${bill.payableAmount}" onchange="updateTotal()"
                                   class="accent-blue-500 h-5 w-5"
                                   <c:if test="${bill.paymentStatus == 'PAID'}">disabled</c:if>>
                        </td>
                        <td class="p-2 border">${bill.consumerNumber}</td>
                        <td class="p-2 border">${bill.billNumber}</td>
                        <td class="p-2 border">${bill.paymentStatus}</td>
                        <td class="p-2 border">${bill.consumerType}</td>
                        <td class="p-2 border">${bill.consumerStatus}</td>
                        <td class="p-2 border">${bill.mobileNumber}</td>
                        <td class="p-2 border">${bill.billingPeriod}</td>
                        <td class="p-2 border">${bill.billDate}</td>
                        <td class="p-2 border">${bill.dueDate}</td>
                        <td class="p-2 border">${bill.disconsumerDate}</td>
                        <td class="p-2 border">${bill.dueAmount}</td>
                        <td class="p-2 border">
                            <input type="number" value="${bill.payableAmount}" readonly
                                   class="bg-gray-100 p-1 w-full text-center rounded">
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <p class="text-lg font-bold mt-4">Total Payable Amount: $<span id="totalAmount">0.00</span></p>
        <button type="submit" class="mt-4 bg-blue-500 text-white px-6 py-2 rounded-lg shadow-md hover:bg-blue-600 transition">Proceed to Pay</button>
    </form>
</div>
</body>
</html>
