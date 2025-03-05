<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.anshroshan.electric.models.Bill" %>
        <%@ page import="com.anshroshan.electric.models.Consumer" %>
            <%@ page import="com.anshroshan.electric.models.Customer" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>PowerPay - View Bills</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <script>
                        tailwind.config = {
                            darkMode: 'class',
                            theme: {
                                extend: {
                                    colors: {
                                        primary: {
                                            50: '#f5f3ff',
                                            100: '#ede9fe',
                                            200: '#ddd6fe',
                                            300: '#c4b5fd',
                                            400: '#a78bfa',
                                            500: '#8b5cf6',
                                            600: '#7c3aed',
                                            700: '#6d28d9',
                                            800: '#5b21b6',
                                            900: '#4c1d95',
                                        },
                                    },
                                }
                            }
                        }
                    </script>
                    <style>
                        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

                        body {
                            font-family: 'Inter', sans-serif;
                            background: #0f172a;
                        }

                        .card-gradient {
                            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
                        }

                        .button-glow:hover {
                            box-shadow: 0 0 15px rgba(139, 92, 246, 0.5);
                            transform: translateY(-2px);
                            transition: all 0.3s ease;
                        }

                        @keyframes fadeInUp {
                            from {
                                opacity: 0;
                                transform: translateY(20px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .animate-fadeInUp {
                            animation: fadeInUp 0.6s ease-out forwards;
                        }

                        /* Custom scrollbar for webkit browsers */
                        .custom-scrollbar::-webkit-scrollbar {
                            width: 8px;
                            height: 8px;
                        }

                        .custom-scrollbar::-webkit-scrollbar-track {
                            background: #1e293b;
                            border-radius: 4px;
                        }

                        .custom-scrollbar::-webkit-scrollbar-thumb {
                            background: #4c1d95;
                            border-radius: 4px;
                        }

                        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
                            background: #6d28d9;
                        }
                    </style>
                </head>

                <body class="min-h-screen text-gray-100">
                    <!-- Navbar -->
                    <nav class="bg-gray-900 border-b border-gray-800 shadow-lg">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="flex justify-between h-16">
                                <div class="flex items-center">
                                    <a href="index.jsp" class="flex-shrink-0 flex items-center">
                                        <svg class="h-8 w-8 text-primary-500" xmlns="http://www.w3.org/2000/svg"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 10V3L4 14h7v7l9-11h-7z" />
                                        </svg>
                                        <span class="ml-2 text-xl font-bold">PowerPay</span>
                                    </a>
                                </div>
                                <div class="flex items-center space-x-4">
                                    <a href="customerHome.jsp"
                                        class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
                                    <a href="logout"
                                        class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Logout</a>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <div
                            class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-6 backdrop-blur-sm opacity-0 animate-fadeInUp">
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center">
                                    <div
                                        class="h-12 w-12 rounded-lg bg-primary-900/50 flex items-center justify-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-400"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                    </div>
                                    <h2 class="ml-3 text-2xl font-bold text-white">Your Electricity Bills</h2>
                                </div>

                                <% Customer customer=(Customer) session.getAttribute("customer"); if (customer==null) {
                                    response.sendRedirect("login.jsp"); return; } int
                                    totalConsumers=customer.getConsumerList().size(); %>

                                    <div
                                        class="flex items-center bg-gray-800/50 px-4 py-2 rounded-lg border border-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400 mr-2"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                        </svg>
                                        <span class="text-gray-300">Consumers: <span class="text-white font-semibold">
                                                <%= totalConsumers %>
                                            </span></span>
                                    </div>
                            </div>

                            <% if (request.getAttribute("error") !=null) { %>
                                <div class="mb-6 p-4 bg-red-900/50 border border-red-700 rounded-lg text-red-200">
                                    <div class="flex">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-400 mr-2"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                        <%= request.getAttribute("error") %>
                                    </div>
                                </div>
                                <% } %>

                                    <form method="post" action="viewBills">
                                        <div class="overflow-x-auto custom-scrollbar">
                                            <table class="min-w-full divide-y divide-gray-700">
                                                <thead class="bg-gray-800">
                                                    <tr>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            <div class="flex items-center">
                                                                <input type="checkbox" id="selectAll"
                                                                    class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 rounded bg-gray-800/50">
                                                                <label for="selectAll" class="ml-2">Select</label>
                                                            </div>
                                                        </th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            ConsumerID</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Bill Number</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Status</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Consumer Type</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Consumer Status</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Mobile</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Period</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Bill Date</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Due Date</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Disconsumer Date</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Due Amount</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Late Fees</th>
                                                        <th scope="col"
                                                            class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                            Payable Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="bg-gray-800/30 divide-y divide-gray-700">
                                                    <% boolean hasUnpaidBills=false; for (Consumer consumer :
                                                        customer.getConsumerList()) { for (Bill bill :
                                                        consumer.getBills()) { double payableAmount="Paid"
                                                        .equals(bill.getStatus()) ? 0 : bill.getAmount() +
                                                        bill.getLateFee(); if (!"Paid".equals(bill.getStatus())) {
                                                        hasUnpaidBills=true; } String rowClass="Paid"
                                                        .equals(bill.getStatus()) ? "opacity-60" : "" ; %>
                                                        <tr class="<%= rowClass %>">
                                                            <td class="px-4 py-3 whitespace-nowrap">
                                                                <input type="checkbox" name="selectedBills"
                                                                    value="<%= bill.getBillId() %>"
                                                                    data-amount="<%= payableAmount %>"
                                                                    onchange="updateTotal()"
                                                                    class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 rounded bg-gray-800/50"
                                                                    <%="Paid" .equals(bill.getStatus()) ? "disabled"
                                                                    : "" %>>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= bill.getConsumerNumber() %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= bill.getBillId() %>
                                                            </td>
                                                            <td class="px-4 py-3 whitespace-nowrap">
                                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        <%= " Paid".equals(bill.getStatus()) ? "bg-green-900 text-green-300"
                                                                    : "bg-yellow-900 text-yellow-300" %>">
                                                                    <%= bill.getStatus() %>
                                                                </span>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= consumer.getConsumerType() !=null ?
                                                                    consumer.getConsumerType() : "N/A" %>
                                                            </td>
                                                            <td class="px-4 py-3 whitespace-nowrap">
                                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        <%= " Active".equals(consumer.getStatus()) ? "bg-green-900 text-green-300"
                                                                    : "bg-red-900 text-red-300" %>">
                                                                    <%= consumer.getStatus() !=null ?
                                                                        consumer.getStatus() : "N/A" %>
                                                                </span>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= customer.getMobile() %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= bill.getPeriod() %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= bill.getBillDate() %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= bill.getDueDate() %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                <%= bill.getDisconsumerDate() !=null ?
                                                                    bill.getDisconsumerDate() : "N/A" %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-300">
                                                                $<%= String.format("%.2f", bill.getAmount()) %>
                                                            </td>
                                                            <td
                                                                class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-300">
                                                                $<%= String.format("%.2f", bill.getLateFee()) %>
                                                            </td>
                                                            <td class="px-4 py-3 whitespace-nowrap">
                                                                <div class="bg-gray-800 rounded px-3 py-1 text-sm font-medium
                                                                    <%= " Paid".equals(bill.getStatus()) ? "text-green-400"
                                                                    : "text-primary-400" %>">
                                                                    $<%= String.format("%.2f", payableAmount) %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <% } } %>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="mt-8 bg-gray-800/50 rounded-lg border border-gray-700 p-4">
                                            <div class="flex flex-col md:flex-row justify-between items-center">
                                                <div class="flex items-center mb-4 md:mb-0">
                                                    <div
                                                        class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mr-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                            class="h-5 w-5 text-primary-400" fill="none"
                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                        </svg>
                                                    </div>
                                                    <div>
                                                        <p class="text-sm text-gray-400">Total Payable Amount</p>
                                                        <p class="text-xl font-bold text-white">$<span
                                                                id="totalAmount">0.00</span></p>
                                                    </div>
                                                </div>

                                                <div class="flex space-x-4">
                                                    <a href="customerHome.jsp"
                                                        class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2"
                                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                                        </svg>
                                                        Back to Home
                                                    </a>
                                                    <button type="submit" id="proceedBtn"
                                                        class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow disabled:opacity-50 disabled:cursor-not-allowed flex items-center"
                                                        <%=!hasUnpaidBills ? "disabled" : "" %>>
                                                        Proceed to Pay
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2"
                                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                                                        </svg>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                        </div>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Select all checkbox functionality
                            const selectAllCheckbox = document.getElementById('selectAll');
                            const checkboxes = document.querySelectorAll('input[name="selectedBills"]:not([disabled])');

                            selectAllCheckbox.addEventListener('change', function () {
                                checkboxes.forEach(checkbox => {
                                    checkbox.checked = selectAllCheckbox.checked;
                                });
                                updateTotal();
                            });

                            // Animate elements on load
                            setTimeout(() => {
                                document.querySelector('.card-gradient').style.opacity = '1';
                            }, 100);

                            // Initial calculation
                            updateTotal();
                        });

                        function updateTotal() {
                            let total = 0;
                            const checkboxes = document.querySelectorAll('input[name="selectedBills"]:checked');
                            checkboxes.forEach(cb => {
                                total += parseFloat(cb.getAttribute('data-amount'));
                            });
                            document.getElementById('totalAmount').innerText = total.toFixed(2);
                            document.getElementById('proceedBtn').disabled = checkboxes.length === 0;

                            // Update select all checkbox state
                            const allCheckboxes = document.querySelectorAll('input[name="selectedBills"]:not([disabled])');
                            const checkedCheckboxes = document.querySelectorAll('input[name="selectedBills"]:checked');
                            const selectAllCheckbox = document.getElementById('selectAll');

                            if (allCheckboxes.length > 0) {
                                selectAllCheckbox.checked = allCheckboxes.length === checkedCheckboxes.length;
                                selectAllCheckbox.indeterminate = checkedCheckboxes.length > 0 && checkedCheckboxes.length < allCheckboxes.length;
                            }
                        }
                    </script>
                </body>

                </html>