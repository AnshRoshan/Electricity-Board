<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.anshroshan.electric.models.Bill" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>PowerPay - Bill History</title>
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
                                    <svg class="h-8 w-8 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M13 10V3L4 14h7v7l9-11h-7z" />
                                    </svg>
                                    <span class="ml-2 text-xl font-bold">PowerPay</span>
                                </a>
                            </div>
                            <div class="flex items-center space-x-4">
                                <a href="customerHome.jsp"
                                    class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
                                <a href="viewBills.jsp"
                                    class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Bills</a>
                                <a href="logout"
                                    class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Logout</a>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                    <% HttpSession sessionObj=request.getSession(false); if (sessionObj==null ||
                        sessionObj.getAttribute("customer")==null) { response.sendRedirect("login.jsp"); return; } %>

                        <div
                            class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-6 backdrop-blur-sm opacity-0 animate-fadeInUp">
                            <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6">
                                <h2 class="text-2xl font-bold text-white mb-4 md:mb-0">Bill History</h2>

                                <form id="historyForm" method="get" action="billHistory" class="w-full md:w-auto">
                                    <div class="flex flex-col md:flex-row space-y-4 md:space-y-0 md:space-x-4">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-400 mb-1">From</label>
                                            <input type="date" name="startDate" value="<%= request.getAttribute("startDate") %>"
                                            class="bg-gray-800/50 border border-gray-700 rounded-lg px-3 py-2 text-white
                                            focus:outline-none focus:ring-2 focus:ring-primary-500">
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-400 mb-1">To</label>
                                            <input type="date" name="endDate" value="<%= request.getAttribute("endDate") %>"
                                            class="bg-gray-800/50 border border-gray-700 rounded-lg px-3 py-2 text-white
                                            focus:outline-none focus:ring-2 focus:ring-primary-500">
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-400 mb-1">Status</label>
                                            <label>
                                                <select name="statusFilter" onchange="submitForm()"
                                                    class="bg-gray-800/50 border border-gray-700 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-primary-500">
                                                    <option value="All" <%="All"
                                                        .equals(request.getParameter("statusFilter")) ||
                                                        request.getParameter("statusFilter")==null ? "selected" : "" %>
                                                        >All
                                                    </option>
                                                    <option value="Paid" <%="Paid"
                                                        .equals(request.getParameter("statusFilter")) ? "selected" : ""
                                                        %>
                                                        >Paid</option>
                                                    <option value="Unpaid" <%="Unpaid"
                                                        .equals(request.getParameter("statusFilter")) ? "selected" : ""
                                                        %>
                                                        >Unpaid</option>
                                                </select>
                                            </label>
                                        </div>
                                        <div class="self-end">
                                            <button type="submit"
                                                class="px-4 py-2 bg-primary-600 hover:bg-primary-700 text-white rounded-lg font-medium transition-colors button-glow">
                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                    class="h-5 w-5 inline-block mr-1" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z">
                                                    </path>
                                                </svg>
                                                Filter
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="overflow-x-auto custom-scrollbar">
                                <% List<Bill> bills = (List<Bill>) request.getAttribute("bills");
                                        %>
                                        <table class="min-w-full divide-y divide-gray-700">
                                            <thead>
                                                <tr>
                                                    <th onclick="document.getElementById('sortBy').value='billDate'; submitForm()"
                                                        class="px-6 py-3 bg-gray-800/50 text-left text-xs font-medium text-gray-300 uppercase tracking-wider cursor-pointer hover:bg-gray-700/50">
                                                        <div class="flex items-center">
                                                            Bill Date
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1"
                                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4">
                                                                </path>
                                                            </svg>
                                                        </div>
                                                    </th>
                                                    <th onclick="document.getElementById('sortBy').value='period'; submitForm()"
                                                        class="px-6 py-3 bg-gray-800/50 text-left text-xs font-medium text-gray-300 uppercase tracking-wider cursor-pointer hover:bg-gray-700/50">
                                                        <div class="flex items-center">
                                                            Billing Period
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1"
                                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
                                                            </svg>
                                                        </div>
                                                    </th>
                                                    <th onclick="document.getElementById('sortBy').value='dueDate'; submitForm()"
                                                        class="px-6 py-3 bg-gray-800/50 text-left text-xs font-medium text-gray-300 uppercase tracking-wider cursor-pointer hover:bg-gray-700/50">
                                                        <div class="flex items-center">
                                                            Due Date
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1"
                                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
                                                            </svg>
                                                        </div>
                                                    </th>
                                                    <th onclick="document.getElementById('sortBy').value='amount'; submitForm()"
                                                        class="px-6 py-3 bg-gray-800/50 text-left text-xs font-medium text-gray-300 uppercase tracking-wider cursor-pointer hover:bg-gray-700/50">
                                                        <div class="flex items-center">
                                                            Bill Amount
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1"
                                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
                                                            </svg>
                                                        </div>
                                                    </th>
                                                    <th
                                                        class="px-6 py-3 bg-gray-800/50 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                                        Payment Status
                                                    </th>
                                                    <th
                                                        class="px-6 py-3 bg-gray-800/50 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-gray-800/20 divide-y divide-gray-700">
                                                <% if (bills !=null && !bills.isEmpty()) { for (Bill bill : bills) { %>
                                                    <tr class="hover:bg-gray-700/30 transition-colors">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                                            <%= bill.getBillDate() %>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                                            <%= bill.getPeriod() %>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                                            <%= bill.getDueDate() %>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">$
                                                            <%= String.format("%.2f", bill.getAmount() +
                                                                bill.getLateFee()) %>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <% if ("Paid".equals(bill.getStatus())) { %>
                                                                <span
                                                                    class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-900/50 text-green-300">
                                                                    Paid
                                                                </span>
                                                                <% } else { %>
                                                                    <span
                                                                        class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-900/50 text-red-300">
                                                                        Unpaid
                                                                    </span>
                                                                    <% } %>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                                            <button onclick="downloadBillPDF('<%= bill.getBillId() %>')"
                                                                class="text-primary-400 hover:text-primary-300 mr-3">
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                    class="h-5 w-5 inline-block" fill="none"
                                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10" />
                                                                </svg>
                                                                Download
                                                            </button>
                                                            <% if (!"Paid".equals(bill.getStatus())) { %>
                                                                <a href="viewBills.jsp"
                                                                    class="text-primary-400 hover:text-primary-300">
                                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                                        class="h-5 w-5 inline-block" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                                                    </svg>
                                                                    Pay Now
                                                                </a>
                                                                <% } %>
                                                        </td>
                                                    </tr>
                                                    <% } } else { %>
                                                        <tr>
                                                            <td colspan="6"
                                                                class="px-6 py-10 text-center text-sm text-gray-400">
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                    class="h-10 w-10 mx-auto mb-2 text-gray-500"
                                                                    fill="none" viewBox="0 0 24 24"
                                                                    stroke="currentColor">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                                </svg>
                                                                <p>No billing data found for the selected range.</p>
                                                                <p class="mt-2">Try adjusting your filters or check back
                                                                    later.</p>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                            </tbody>
                                        </table>
                            </div>

                            <div class="mt-6 flex justify-between">
                                <a href="customerHome.jsp"
                                    class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                    </svg>
                                    Back to Dashboard
                                </a>
                                <a href="viewBills.jsp"
                                    class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center">
                                    View Current Bills
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M14 5l7 7m0 0l-7 7m7-7H3" />
                                    </svg>
                                </a>
                            </div>
                        </div>

                        <% if (request.getAttribute("error") !=null) { %>
                            <div class="mt-4 p-4 bg-red-900/50 border border-red-700 rounded-lg text-red-200">
                                <div class="flex items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                    <%= request.getAttribute("error") %>
                                </div>
                            </div>
                            <% } %>
                </div>

                <input type="hidden" id="sortBy" name="sortBy" value="<%= request.getParameter(" sortBy") !=null ?
                    request.getParameter("sortBy") : "" %>">

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Animate elements on load
                        setTimeout(() => {
                            document.querySelector('.card-gradient').style.opacity = '1';
                        }, 100);
                    });

                    function submitForm() {
                        document.getElementById("historyForm").submit();
                    }

                    function downloadBillPDF(billId) {
                        // Redirect to a servlet that will handle the bill PDF generation and download
                        window.location.href = 'downloadBill?billId=' + billId;
                    }
                </script>
            </body>

            </html>