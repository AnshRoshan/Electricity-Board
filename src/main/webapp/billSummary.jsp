<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.anshroshan.electric.models.Bill" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>PowerPay - Bill Summary</title>
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

                    .input-focus:focus {
                        box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.5);
                        border-color: #8b5cf6;
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

                    .delay-100 {
                        animation-delay: 0.1s;
                    }

                    .delay-200 {
                        animation-delay: 0.2s;
                    }

                    .delay-300 {
                        animation-delay: 0.3s;
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

                    /* Credit card styles */
                    .card-element {
                        background: linear-gradient(135deg, #1e293b, #0f172a);
                        border-radius: 16px;
                        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
                        backdrop-filter: blur(5px);
                        border: 1px solid rgba(139, 92, 246, 0.3);
                    }

                    .card-shine {
                        position: absolute;
                        top: 0;
                        right: 0;
                        bottom: 0;
                        left: 0;
                        border-radius: 16px;
                        background: linear-gradient(135deg,
                                rgba(255, 255, 255, 0) 0%,
                                rgba(255, 255, 255, 0.05) 40%,
                                rgba(255, 255, 255, 0) 60%);
                        transform: translateY(-100%);
                        animation: shine 5s infinite;
                    }

                    @keyframes shine {
                        0% {
                            transform: translateY(-100%);
                        }

                        20% {
                            transform: translateY(100%);
                        }

                        100% {
                            transform: translateY(100%);
                        }
                    }

                    .card-logo {
                        position: absolute;
                        right: 20px;
                        bottom: 20px;
                        height: 40px;
                        opacity: 0.8;
                    }

                    .toast {
                        position: fixed;
                        top: 20px;
                        left: 50%;
                        transform: translateX(-50%);
                        padding: 1rem 2rem;
                        border-radius: 8px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                        z-index: 1000;
                        opacity: 0;
                        transition: opacity 0.3s ease-in-out;
                    }

                    .toast.show {
                        opacity: 1;
                        animation: fadeInUp 0.5s ease-out;
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
                                <a href="logout"
                                    class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Logout</a>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                    <div
                        class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-6 backdrop-blur-sm opacity-0 animate-fadeInUp">
                        <div class="flex items-center mb-6">
                            <div class="h-12 w-12 rounded-lg bg-primary-900/50 flex items-center justify-center">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-400" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
                                </svg>
                            </div>
                            <h2 class="ml-3 text-2xl font-bold text-white">Bill Summary</h2>
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

                                <% List<Bill> selectedBills = (List<Bill>) request.getAttribute("selectedBills");
                                        if (selectedBills == null || selectedBills.isEmpty()) {
                                        response.sendRedirect("viewBills.jsp");
                                        return;
                                        }
                                        %>

                                        <form method="post" action="billSummary" id="paymentForm"
                                            onsubmit="return validateForm()">
                                            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                                <!-- Bill Summary Section -->
                                                <div>
                                                    <h3 class="text-lg font-semibold text-white mb-4">Selected Bills
                                                    </h3>
                                                    <div class="overflow-x-auto custom-scrollbar mb-6">
                                                        <table class="min-w-full divide-y divide-gray-700">
                                                            <thead class="bg-gray-800">
                                                                <tr>
                                                                    <th scope="col"
                                                                        class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                                        <div class="flex items-center">
                                                                            <input type="checkbox" id="selectAll"
                                                                                checked
                                                                                class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 rounded bg-gray-800/50">
                                                                            <label for="selectAll"
                                                                                class="ml-2">Select</label>
                                                                        </div>
                                                                    </th>
                                                                    <th scope="col"
                                                                        class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                                        ConsumerID</th>
                                                                    <th scope="col"
                                                                        class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                                        Bill Period</th>
                                                                    <th scope="col"
                                                                        class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                                        Due Date</th>
                                                                    <th scope="col"
                                                                        class="px-4 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">
                                                                        Amount</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="bg-gray-800/30 divide-y divide-gray-700">
                                                                <% for (Bill bill : selectedBills) { double
                                                                    totalAmount=bill.getAmount() + bill.getLateFee(); %>
                                                                    <tr>
                                                                        <td class="px-4 py-3 whitespace-nowrap">
                                                                            <input type="checkbox" name="selectedBills"
                                                                                value="<%= bill.getBillId() %>"
                                                                                data-amount="<%= totalAmount %>" checked
                                                                                onchange="updateTotal()"
                                                                                class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 rounded bg-gray-800/50">
                                                                        </td>
                                                                        <td
                                                                            class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                            <%= bill.getConsumerNumber() %>
                                                                        </td>
                                                                        <td
                                                                            class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                            <%= bill.getPeriod() %>
                                                                        </td>
                                                                        <td
                                                                            class="px-4 py-3 whitespace-nowrap text-sm text-gray-300">
                                                                            <%= bill.getDueDate() %>
                                                                        </td>
                                                                        <td class="px-4 py-3 whitespace-nowrap">
                                                                            <div
                                                                                class="bg-gray-800 rounded px-3 py-1 text-sm font-medium text-primary-400">
                                                                                $<%= String.format("%.2f", totalAmount)
                                                                                    %>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div
                                                        class="bg-gray-800/50 rounded-lg border border-gray-700 p-4 mb-6">
                                                        <div class="flex items-center">
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
                                                                <p class="text-sm text-gray-400">Total Amount to Pay</p>
                                                                <p class="text-xl font-bold text-white">$<span
                                                                        id="totalAmount">0.00</span></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Payment Method Section -->
                                                <div>
                                                    <h3 class="text-lg font-semibold text-white mb-4">Payment Method
                                                    </h3>

                                                    <div class="space-y-4 mb-6">
                                                        <div class="flex items-center space-x-3">
                                                            <input type="radio" id="creditCard" name="paymentMethod"
                                                                value="creditCard" checked
                                                                class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 bg-gray-800/50"
                                                                onchange="togglePaymentMethod('credit')">
                                                            <label for="creditCard" class="flex items-center">
                                                                <span class="mr-2">Credit Card</span>
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                    class="h-6 w-6 text-primary-400" fill="none"
                                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                                                </svg>
                                                            </label>
                                                        </div>

                                                        <div class="flex items-center space-x-3">
                                                            <input type="radio" id="debitCard" name="paymentMethod"
                                                                value="debitCard"
                                                                class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 bg-gray-800/50"
                                                                onchange="togglePaymentMethod('debit')">
                                                            <label for="debitCard" class="flex items-center">
                                                                <span class="mr-2">Debit Card</span>
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                    class="h-6 w-6 text-primary-400" fill="none"
                                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                                                </svg>
                                                            </label>
                                                        </div>

                                                        <div class="flex items-center space-x-3">
                                                            <input type="radio" id="netBanking" name="paymentMethod"
                                                                value="netBanking"
                                                                class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 bg-gray-800/50"
                                                                onchange="togglePaymentMethod('netbanking')">
                                                            <label for="netBanking" class="flex items-center">
                                                                <span class="mr-2">Net Banking</span>
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                    class="h-6 w-6 text-primary-400" fill="none"
                                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z" />
                                                                </svg>
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <!-- Credit/Debit Card Form -->
                                                    <div id="cardPaymentForm" class="space-y-4">
                                                        <!-- Virtual Card Preview -->
                                                        <div class="relative h-48 w-full card-element p-5 mb-6">
                                                            <div class="card-shine"></div>
                                                            <div class="absolute top-4 left-4">
                                                                <div class="text-xs text-gray-400 mb-1">Card Number
                                                                </div>
                                                                <div id="cardNumberPreview"
                                                                    class="text-lg font-medium tracking-wider">•••• ••••
                                                                    •••• ••••</div>
                                                            </div>
                                                            <div class="absolute bottom-4 left-4 right-20">
                                                                <div class="flex justify-between">
                                                                    <div>
                                                                        <div class="text-xs text-gray-400 mb-1">Card
                                                                            Holder</div>
                                                                        <div id="cardHolderPreview" class="font-medium">
                                                                            YOUR NAME</div>
                                                                    </div>
                                                                    <div>
                                                                        <div class="text-xs text-gray-400 mb-1">Expires
                                                                        </div>
                                                                        <div id="expiryPreview" class="font-medium">
                                                                            MM/YY</div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="cardLogo" class="card-logo">
                                                                <!-- Card logo will be inserted here by JS -->
                                                            </div>
                                                        </div>

                                                        <div>
                                                            <label for="cardNumber"
                                                                class="block text-sm font-medium text-gray-300 mb-1">Card
                                                                Number</label>
                                                            <div class="relative">
                                                                <div
                                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                                        class="h-5 w-5 text-gray-500" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                                                    </svg>
                                                                </div>
                                                                <input type="text" id="cardNumber" name="cardNumber"
                                                                    maxlength="19" placeholder="1234 5678 9012 3456"
                                                                    class="block w-full pl-10 pr-10 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                                                    oninput="formatCardNumber(this); updateCardPreview();">
                                                                <div
                                                                    class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                                                    <div id="cardTypeIcon"
                                                                        class="h-5 w-5 text-gray-500"></div>
                                                                </div>
                                                            </div>
                                                            <span id="cardNumberError"
                                                                class="hidden text-red-400 text-xs mt-1"></span>
                                                        </div>

                                                        <div>
                                                            <label for="cardHolder"
                                                                class="block text-sm font-medium text-gray-300 mb-1">Card
                                                                Holder Name</label>
                                                            <div class="relative">
                                                                <div
                                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                                        class="h-5 w-5 text-gray-500" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                                    </svg>
                                                                </div>
                                                                <input type="text" id="cardHolder" name="cardHolder"
                                                                    placeholder="John Doe"
                                                                    class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                                                    oninput="updateCardPreview();">
                                                            </div>
                                                            <span id="cardHolderError"
                                                                class="hidden text-red-400 text-xs mt-1"></span>
                                                        </div>

                                                        <div class="grid grid-cols-2 gap-4">
                                                            <div>
                                                                <label for="expiryDate"
                                                                    class="block text-sm font-medium text-gray-300 mb-1">Expiry
                                                                    Date</label>
                                                                <div class="relative">
                                                                    <div
                                                                        class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                                            class="h-5 w-5 text-gray-500" fill="none"
                                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                                        </svg>
                                                                    </div>
                                                                    <input type="text" id="expiryDate" name="expiryDate"
                                                                        maxlength="5" placeholder="MM/YY"
                                                                        class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                                                        oninput="formatExpiryDate(this); updateCardPreview();">
                                                                </div>
                                                                <span id="expiryDateError"
                                                                    class="hidden text-red-400 text-xs mt-1"></span>
                                                            </div>

                                                            <div>
                                                                <label for="cvv"
                                                                    class="block text-sm font-medium text-gray-300 mb-1">CVV</label>
                                                                <div class="relative">
                                                                    <div
                                                                        class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                                            class="h-5 w-5 text-gray-500" fill="none"
                                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                                                        </svg>
                                                                    </div>
                                                                    <input type="password" id="cvv" name="cvv"
                                                                        maxlength="4" placeholder="123"
                                                                        class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus">
                                                                </div>
                                                                <span id="cvvError"
                                                                    class="hidden text-red-400 text-xs mt-1"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Net Banking Form -->
                                                    <div id="netBankingForm" class="space-y-4 hidden">
                                                        <div>
                                                            <label for="bankName"
                                                                class="block text-sm font-medium text-gray-300 mb-1">Select
                                                                Bank</label>
                                                            <div class="relative">
                                                                <div
                                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                                        class="h-5 w-5 text-gray-500" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z" />
                                                                    </svg>
                                                                </div>
                                                                <select id="bankName" name="bankName"
                                                                    class="block w-full pl-10 pr-10 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white appearance-none input-focus">
                                                                    <option value="">Select your bank</option>
                                                                    <option value="sbi">State Bank of India</option>
                                                                    <option value="hdfc">HDFC Bank</option>
                                                                    <option value="icici">ICICI Bank</option>
                                                                    <option value="axis">Axis Bank</option>
                                                                    <option value="pnb">Punjab National Bank</option>
                                                                </select>
                                                                <div
                                                                    class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                                                    <svg class="h-5 w-5 text-gray-500"
                                                                        xmlns="http://www.w3.org/2000/svg"
                                                                        viewBox="0 0 20 20" fill="currentColor">
                                                                        <path fill-rule="evenodd"
                                                                            d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                </div>
                                                            </div>
                                                            <span id="bankNameError"
                                                                class="hidden text-red-400 text-xs mt-1"></span>
                                                        </div>

                                                        <div>
                                                            <label for="accountNumber"
                                                                class="block text-sm font-medium text-gray-300 mb-1">Account
                                                                Number</label>
                                                            <div class="relative">
                                                                <div
                                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                                        class="h-5 w-5 text-gray-500" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                                                                    </svg>
                                                                </div>
                                                                <input type="text" id="accountNumber"
                                                                    name="accountNumber" placeholder="Account Number"
                                                                    class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus">
                                                            </div>
                                                            <span id="accountNumberError"
                                                                class="hidden text-red-400 text-xs mt-1"></span>
                                                        </div>

                                                        <div>
                                                            <label for="ifscCode"
                                                                class="block text-sm font-medium text-gray-300 mb-1">IFSC
                                                                Code</label>
                                                            <div class="relative">
                                                                <div
                                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                                        class="h-5 w-5 text-gray-500" fill="none"
                                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2" />
                                                                    </svg>
                                                                </div>
                                                                <input type="text" id="ifscCode" name="ifscCode"
                                                                    placeholder="IFSC Code"
                                                                    class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus">
                                                            </div>
                                                            <span id="ifscCodeError"
                                                                class="hidden text-red-400 text-xs mt-1"></span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-8 flex justify-between">
                                                    <a href="viewBills.jsp"
                                                        class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2"
                                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                                        </svg>
                                                        Back to Bills
                                                    </a>
                                                    <button type="submit" id="paymentBtn"
                                                        class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow disabled:opacity-50 disabled:cursor-not-allowed flex items-center">
                                                        Complete Payment
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2"
                                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                    </button>
                                                </div>
                                        </form>
                    </div>
                </div>
                </div>
                </div>
                </div>
                </div>
                </div>
                </div>
                </div>
                </div>

                <!-- Toast Notification -->
                <div id="toast" class="toast hidden"></div>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Initial setup
                        updateTotal();

                        // Animate elements on load
                        setTimeout(() => {
                            document.querySelector('.card-gradient').style.opacity = '1';
                        }, 100);

                        // Check for error message
                        const error = '<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>';
                        if (error && error !== "null") {
                            showToast(error, 'error');
                        }

                        // Set up form validation
                        document.getElementById('paymentForm').addEventListener('submit', function (e) {
                            if (!validatePaymentForm()) {
                                e.preventDefault();
                                showToast('Please correct the errors in the form', 'error');
                            }
                        });

                        // Set default payment method
                        document.getElementById('creditCard').checked = true;
                        togglePaymentMethod('credit');
                    });

                    function updateTotal() {
                        let total = 0;
                        const checkboxes = document.querySelectorAll('input[name="selectedBills"]:checked');
                        checkboxes.forEach(cb => {
                            total += parseFloat(cb.getAttribute('data-amount'));
                        });
                        document.getElementById('totalAmount').innerText = total.toFixed(2);
                        document.getElementById('paymentBtn').disabled = checkboxes.length === 0;
                    }

                    function togglePaymentMethod(method) {
                        const cardForm = document.getElementById('cardPaymentForm');
                        const netBankingForm = document.getElementById('netBankingForm');

                        if (method === 'credit' || method === 'debit') {
                            cardForm.classList.remove('hidden');
                            netBankingForm.classList.add('hidden');
                        } else if (method === 'netbanking') {
                            cardForm.classList.add('hidden');
                            netBankingForm.classList.remove('hidden');
                        }
                    }

                    function formatCardNumber(input) {
                        // Remove non-digit characters
                        let value = input.value.replace(/\D/g, '');

                        // Add spaces after every 4 digits
                        let formattedValue = '';
                        for (let i = 0; i < value.length; i++) {
                            if (i > 0 && i % 4 === 0) {
                                formattedValue += ' ';
                            }
                            formattedValue += value[i];
                        }

                        input.value = formattedValue;

                        // Detect card type
                        detectCardType(value);
                    }

                    function detectCardType(number) {
                        const cardTypeIcon = document.getElementById('cardTypeIcon');
                        const cardLogo = document.getElementById('cardLogo');

                        // Clear previous content
                        cardTypeIcon.innerHTML = '';
                        cardLogo.innerHTML = '';

                        let cardType = '';
                        let cardColor = '';

                        // Visa
                        if (/^4/.test(number)) {
                            cardType = 'Visa';
                            cardColor = '#1434CB';
                            cardTypeIcon.innerHTML = '<svg class="h-5 w-5" viewBox="0 0 24 24" fill="#1434CB"><path d="M15.24 14.217h-1.707l1.067-6.537h1.704l-1.064 6.537zm7.076-6.4l-1.475 3.824h-.086l-.21-3.824h-1.877l-1.12 6.537h1.41l.807-4.97h.05l.36 4.97h1.186l1.853-4.97h.05l-.772 4.97h1.483l1.12-6.537h-1.78zm-9.933 4.403c.01-.83-.504-1.46-1.617-1.983-.67-.34-1.077-.566-1.073-.91.002-.305.36-.63 1.136-.63.645-.008 1.11.13 1.473.277l.177.083.267-1.557c-.387-.143-.993-.296-1.747-.296-1.924 0-3.274 1.02-3.286 2.48-.013 1.08.966 1.68 1.702 2.04.756.367 1.01.603 1.006.93-.005.503-.603.732-1.16.732-.776 0-1.186-.113-1.82-.39l-.25-.118-.272 1.67c.453.208 1.292.39 2.163.4 2.04 0 3.37-1.01 3.382-2.57l.02-.007zm-8.208 2.134h1.653l1.03-6.537H5.17l-1.03 6.537z"/></svg>';
                            cardLogo.innerHTML = '<svg viewBox="0 0 48 48" height="40" fill="#1434CB"><path d="M15.24 14.217h-1.707l1.067-6.537h1.704l-1.064 6.537zm7.076-6.4l-1.475 3.824h-.086l-.21-3.824h-1.877l-1.12 6.537h1.41l.807-4.97h.05l.36 4.97h1.186l1.853-4.97h.05l-.772 4.97h1.483l1.12-6.537h-1.78zm-9.933 4.403c.01-.83-.504-1.46-1.617-1.983-.67-.34-1.077-.566-1.073-.91.002-.305.36-.63 1.136-.63.645-.008 1.11.13 1.473.277l.177.083.267-1.557c-.387-.143-.993-.296-1.747-.296-1.924 0-3.274 1.02-3.286 2.48-.013 1.08.966 1.68 1.702 2.04.756.367 1.01.603 1.006.93-.005.503-.603.732-1.16.732-.776 0-1.186-.113-1.82-.39l-.25-.118-.272 1.67c.453.208 1.292.39 2.163.4 2.04 0 3.37-1.01 3.382-2.57l.02-.007zm-8.208 2.134h1.653l1.03-6.537H5.17l-1.03 6.537z"/></svg>';
                        }
                        // Mastercard
                        else if (/^5[1-5]/.test(number)) {
                            cardType = 'Mastercard';
                            cardColor = '#EB001B';
                            cardTypeIcon.innerHTML = '<svg class="h-5 w-5" viewBox="0 0 24 24"><circle cx="7" cy="12" r="6" fill="#EB001B"/><circle cx="17" cy="12" r="6" fill="#F79E1B"/><path d="M12 16.5a6 6 0 000-9 6 6 0 000 9z" fill="#FF5F00"/></svg>';
                            cardLogo.innerHTML = '<svg viewBox="0 0 48 48" height="40"><circle cx="16" cy="24" r="10" fill="#EB001B"/><circle cx="32" cy="24" r="10" fill="#F79E1B"/><path d="M24 31a10 10 0 000-14 10 10 0 000 14z" fill="#FF5F00"/></svg>';
                        }
                        // Amex
                        else if (/^3[47]/.test(number)) {
                            cardType = 'American Express';
                            cardColor = '#2E77BC';
                            cardTypeIcon.innerHTML = '<svg class="h-5 w-5" viewBox="0 0 24 24" fill="#2E77BC"><path d="M21.5 12a.5.5 0 01-.5.5h-1.5v2h-1v-2h-1v2h-1v-2h-1.5a.5.5 0 01-.5-.5v-4a.5.5 0 01.5-.5H21a.5.5 0 01.5.5v4zM10 18h4v-1h-3v-2h3v-1h-3v-2h3V11h-4a1 1 0 00-1 1v5a1 1 0 001 1zm-5 0h3a1 1 0 001-1v-5a1 1 0 00-1-1H5a1 1 0 00-1 1v5a1 1 0 001 1zm0-6h2v4H5v-4z"/></svg>';
                            cardLogo.innerHTML = '<svg viewBox="0 0 48 48" height="40" fill="#2E77BC"><path d="M43 24a.5.5 0 01-.5.5h-3.5v4h-2v-4h-2v4h-2v-4h-3.5a.5.5 0 01-.5-.5v-8a.5.5 0 01.5-.5H42a.5.5 0 01.5.5v8zM20 36h8v-2h-6v-4h6v-2h-6v-4h6v-2h-8a2 2 0 00-2 2v10a2 2 0 002 2zm-10 0h6a2 2 0 002-2V24a2 2 0 00-2-2h-6a2 2 0 00-2 2v10a2 2 0 002 2zm0-12h4v8h-4v-8z"/></svg>';
                        }
                        // Discover
                        else if (/^6(?:011|5)/.test(number)) {
                            cardType = 'Discover';
                            cardColor = '#FF6000';
                            cardTypeIcon.innerHTML = '<svg class="h-5 w-5" viewBox="0 0 24 24" fill="#FF6000"><path d="M12 12a4 4 0 100 8 4 4 0 000-8zm9-3h-1V8a1 1 0 00-1-1H5a1 1 0 00-1 1v8a1 1 0 001 1h14a1 1 0 001-1v-1h1a1 1 0 001-1v-4a1 1 0 00-1-1z"/></svg>';
                            cardLogo.innerHTML = '<svg viewBox="0 0 48 48" height="40" fill="#FF6000"><path d="M24 24a8 8 0 100 16 8 8 0 000-16zm18-6h-2v-2a2 2 0 00-2-2H10a2 2 0 00-2 2v16a2 2 0 002 2h28a2 2 0 002-2v-2h2a2 2 0 002-2v-8a2 2 0 00-2-2z"/></svg>';
                        }
                        // Default
                        else {
                            cardTypeIcon.innerHTML = '<svg class="h-5 w-5 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" /></svg>';
                        }

                        // Update card preview with card type color
                        if (cardColor) {
                            document.querySelector('.card-element').style.borderColor = cardColor;
                        } else {
                            document.querySelector('.card-element').style.borderColor = 'rgba(139, 92, 246, 0.3)';
                        }
                    }

                    function formatExpiryDate(input) {
                        // Remove non-digit characters
                        let value = input.value.replace(/\D/g, '');

                        // Format as MM/YY
                        if (value.length > 2) {
                            value = value.substring(0, 2) + '/' + value.substring(2, 4);
                        }

                        input.value = value;
                    }

                    function updateCardPreview() {
                        const cardNumber = document.getElementById('cardNumber').value;
                        const cardHolder = document.getElementById('cardHolder').value;
                        const expiryDate = document.getElementById('expiryDate').value;

                        // Update card number preview
                        let cardNumberPreview = '•••• •••• •••• ••••';
                        if (cardNumber) {
                            // Show last 4 digits and mask the rest
                            const parts = cardNumber.split(' ');
                            if (parts.length === 4) {
                                cardNumberPreview = `•••• •••• •••• ${parts[3]}`;
                            }
                        }
                        document.getElementById('cardNumberPreview').textContent = cardNumberPreview;

                        // Update card holder preview
                        document.getElementById('cardHolderPreview').textContent = cardHolder || 'YOUR NAME';

                        // Update expiry preview
                        document.getElementById('expiryPreview').textContent = expiryDate || 'MM/YY';
                    }

                    function validatePaymentForm() {
                        let isValid = true;
                        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;

                        // Clear previous errors
                        const errorElements = document.querySelectorAll('[id$="Error"]');
                        errorElements.forEach(el => {
                            el.classList.add('hidden');
                        });

                        if (paymentMethod === 'creditCard' || paymentMethod === 'debitCard') {
                            // Validate card number
                            const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
                            if (!cardNumber || cardNumber.length < 13 || cardNumber.length > 19 || !/^\d+$/.test(cardNumber)) {
                                showError('cardNumberError', 'Please enter a valid card number');
                                isValid = false;
                            }

                            // Validate card holder
                            const cardHolder = document.getElementById('cardHolder').value.trim();
                            if (!cardHolder || cardHolder.length < 3) {
                                showError('cardHolderError', 'Please enter the card holder name');
                                isValid = false;
                            }

                            // Validate expiry date
                            const expiryDate = document.getElementById('expiryDate').value;
                            if (!expiryDate || !/^\d{2}\/\d{2}$/.test(expiryDate)) {
                                showError('expiryDateError', 'Please enter a valid expiry date (MM/YY)');
                                isValid = false;
                            } else {
                                // Check if card is expired
                                const [month, year] = expiryDate.split('/');
                                const expiryMonth = parseInt(month, 10);
                                const expiryYear = parseInt('20' + year, 10);

                                const now = new Date();
                                const currentMonth = now.getMonth() + 1; // getMonth() is 0-indexed
                                const currentYear = now.getFullYear();

                                if (expiryYear < currentYear || (expiryYear === currentYear && expiryMonth < currentMonth)) {
                                    showError('expiryDateError', 'Your card has expired');
                                    isValid = false;
                                }
                            }

                            // Validate CVV
                            const cvv = document.getElementById('cvv').value;
                            if (!cvv || !/^\d{3,4}$/.test(cvv)) {
                                showError('cvvError', 'Please enter a valid CVV (3-4 digits)');
                                isValid = false;
                            }
                        } else if (paymentMethod === 'netBanking') {
                            // Validate bank selection
                            const bankName = document.getElementById('bankName').value;
                            if (!bankName) {
                                showError('bankNameError', 'Please select your bank');
                                isValid = false;
                            }

                            // Validate account number
                            const accountNumber = document.getElementById('accountNumber').value.trim();
                            if (!accountNumber || accountNumber.length < 8) {
                                showError('accountNumberError', 'Please enter a valid account number');
                                isValid = false;
                            }

                            // Validate IFSC code
                            const ifscCode = document.getElementById('ifscCode').value.trim();
                            if (!ifscCode || !/^[A-Z]{4}0[A-Z0-9]{6}$/.test(ifscCode)) {
                                showError('ifscCodeError', 'Please enter a valid IFSC code (e.g., SBIN0123456)');
                                isValid = false;
                            }
                        }

                        return isValid;
                    }

                    function showError(elementId, message) {
                        const errorElement = document.getElementById(elementId);
                        errorElement.textContent = message;
                        errorElement.classList.remove('hidden');
                    }

                    function showToast(message, type = 'error') {
                        const toast = document.getElementById('toast');
                        toast.textContent = message;
                        toast.classList.remove('hidden');

                        if (type === 'error') {
                            toast.className = 'toast bg-red-900/90 border border-red-700 text-red-200 show';
                        } else if (type === 'success') {
                            toast.className = 'toast bg-green-900/90 border border-green-700 text-green-200 show';
                        } else {
                            toast.className = 'toast bg-primary-900/90 border border-primary-700 text-primary-200 show';
                        }

                        // Hide toast after 4 seconds
                        setTimeout(() => {
                            toast.classList.remove('show');
                            setTimeout(() => toast.classList.add('hidden'), 300);
                        }, 4000);
                    }
                </script>
            </body>

            </html>