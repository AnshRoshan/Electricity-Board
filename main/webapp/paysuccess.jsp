<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.anshroshan.electric.models.Payment" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PowerPay - Payment Confirmation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.2/html2pdf.bundle.min.js" integrity="sha512-MpDFIChbcXl2QgipQrt1VcPHMldRILetapBl5MPCA9Y8r7qvlwx1/Mc9hNTzY+kS5kX6PdoDq41ws1HiVNLdZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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

        .delay-100 {
            animation-delay: 0.1s;
        }

        .delay-200 {
            animation-delay: 0.2s;
        }

        .delay-300 {
            animation-delay: 0.3s;
        }

        @keyframes checkmark {
            0% {
                stroke-dashoffset: 100;
            }

            100% {
                stroke-dashoffset: 0;
            }
        }

        .animate-checkmark {
            stroke-dasharray: 100;
            stroke-dashoffset: 100;
            animation: checkmark 1s ease-in-out forwards;
        }

        @keyframes pulse {

            0%,
            100% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.05);
            }
        }

        .animate-pulse-slow {
            animation: pulse 2s infinite;
        }

        /* For receipt printing */
        @media print {
            body {
                background: white;
                color: black;
            }

            .no-print {
                display: none;
            }

            .print-only {
                display: block;
            }

            .card-gradient {
                background: white;
                border: 1px solid #ddd;
            }

            .receipt {
                color: black;
                background: white;
            }
        }

        .print-only {
            display: none;
        }
    </style>
</head>

<body class="min-h-screen text-gray-100">
<% // First try to get payment from request attribute
    Payment payment = (Payment) request.getAttribute("payment"); // If not in request, try to get from session
    if (payment == null) {
        payment = (Payment) session.getAttribute("payment");
    } // Set payment amount variable
    double paymentAmount = 0.0;
    if (payment != null) {
        paymentAmount = payment.getAmount();
    } // Store payment data for
    String transactionId = payment != null ? payment.getTransactionId() : "N/A";
    String transactionDate = payment != null ? payment.getTransactionDate().toString() : "N/A";
    String paymentMethod = payment != null ? payment.getMethod() : "N/A";
    String paymentStatus = payment != null ? payment.getStatus() : "N/A";
    String billNumbers = payment != null && payment.getBills() != null ? String.join(", ", payment.getBills()) : " N/A";
    String formattedAmount = String.format("%.2f", paymentAmount);
    String customerName = (String) session.getAttribute("customerName");
    if (customerName == null) customerName = "Customer";
    String
            customerId = (String) session.getAttribute("customerId");
    if (customerId == null) customerId = "N/A"; %>

<!-- Navbar -->
<nav class="bg-gray-900 border-b border-gray-800 shadow-lg no-print">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex items-center">
                <a href="index.jsp" class="flex-shrink-0 flex items-center">
                    <svg class="h-8 w-8 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M13 10V3L4 14h7v7l9-11h-7z"></path>
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

<div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <% if (payment == null) { %>
    <div
            class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm opacity-0 animate-fadeInUp">
        <div class="flex flex-col items-center justify-center text-center">
            <div class="h-20 w-20 rounded-full bg-red-900/50 flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-red-400" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
            </div>
            <h2 class="text-2xl font-bold text-white mb-2">No Payment Details Found</h2>
            <p class="text-gray-400 mb-6">We couldn't find the payment information you're looking
                for.</p>
            <div class="flex space-x-4">
                <a href="viewBills.jsp"
                   class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    View Bills
                </a>
                <a href="customerHome.jsp"
                   class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M3 12l2-2m0 0l7-7 7 7m-7-7v14"/>
                    </svg>
                    Dashboard
                </a>
            </div>
        </div>
    </div>
    <% } else { %>
    <!-- Success Card -->
    <div
            class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm opacity-0 animate-fadeInUp">
        <div class="flex flex-col items-center justify-center text-center mb-8">
            <div
                    class="h-20 w-20 rounded-full bg-green-900/50 flex items-center justify-center mb-4 animate-pulse-slow">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-green-400"
                     fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path class="animate-checkmark" stroke-linecap="round"
                          stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                </svg>
            </div>
            <h2 class="text-2xl font-bold text-white mb-2">Payment Successful!</h2>
            <p class="text-gray-400">Your electricity bill payment has been processed
                successfully.</p>
        </div>

        <!-- Receipt Card -->
        <div id="receipt"
             class="receipt bg-gray-800/50 rounded-lg border border-gray-700 p-6 mb-6">
            <div class="flex justify-between items-center mb-6">
                <div class="flex items-center">
                    <div
                            class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400"
                             fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  stroke-width="2"
                                  d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                            </path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-white">Payment Receipt</h3>
                </div>
                <div class="print-only">
                    <img src="path/to/logo.png" alt="PowerPay Logo" class="h-10">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                <div>
                    <p class="text-sm text-gray-400">Transaction ID</p>
                    <p class="text-base font-medium text-white" id="displayTransactionId">
                        <%= transactionId %>
                    </p>
                </div>
                <div>
                    <p class="text-sm text-gray-400">Receipt Number</p>
                    <p class="text-base font-medium text-white" id="displayReceiptNumber">
                        <%= transactionId.length() > 8 ? transactionId.substring(0, 8) :
                                transactionId %>
                    </p>
                </div>
                <div>
                    <p class="text-sm text-gray-400">Transaction Date</p>
                    <p class="text-base font-medium text-white" id="displayTransactionDate">
                        <%= transactionDate %>
                    </p>
                </div>
                <div>
                    <p class="text-sm text-gray-400">Payment Method</p>
                    <p class="text-base font-medium text-white" id="displayPaymentMethod">
                        <%= paymentMethod.equalsIgnoreCase("netBanking") ? "Net Banking"
                                : "Card" %>
                    </p>
                </div>
            </div>

            <div class="border-t border-gray-700 pt-4 mb-4">
                <h4 class="text-sm font-medium text-gray-300 mb-3">Bill Details</h4>
                <div class="bg-gray-900/50 rounded-lg p-3 mb-4">
                    <div class="flex justify-between mb-2">
                        <span class="text-sm text-gray-400">Bill Numbers</span>
                        <span class="text-sm font-medium text-white" id="displayBillNumbers">
                                                    <%= billNumbers %>
                                                </span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-400">Transaction Status</span>
                        <span
                                class="px-2 py-1 text-xs font-semibold rounded-full bg-green-900 text-green-300"
                                id="displayStatus">
                                                    <%= paymentStatus %>
                                                </span>
                    </div>
                </div>
            </div>

            <div class="border-t border-gray-700 pt-4">
                <div class="flex justify-between items-center">
                    <span class="text-base font-medium text-gray-300">Total Amount Paid</span>
                    <span class="text-xl font-bold text-primary-400" id="displayAmount">$<%=
                    formattedAmount %></span>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div
                class="flex flex-col sm:flex-row justify-center space-y-3 sm:space-y-0 sm:space-x-4 no-print">
            <button onclick="downloadReceipt()"
                    class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                </svg>
                Download PDF
            </button>

            <button onclick="downloadTextReceipt()"
                    class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                </svg>
                Download Text Receipt
            </button>
            <button onclick="printReceipt()"
                    class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                </svg>
                Print Receipt
            </button>
            <a href="customerHome.jsp"
               class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M3 12l2-2m0 0l7-7 7 7m-7-7v14"/>
                </svg>
                Dashboard
            </a>
        </div>
    </div>

    <!-- What's Next Section -->
    <div
            class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-6 backdrop-blur-sm opacity-0 animate-fadeInUp delay-200 mt-6 no-print">
        <h3 class="text-lg font-semibold text-white mb-4">What's Next?</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <a href="billHistory.jsp"
               class="bg-gray-800/50 hover:bg-gray-700/50 rounded-lg p-4 transition-colors">
                <div
                        class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400"
                         fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                    </svg>
                </div>
                <h4 class="text-base font-medium text-white mb-1">View Bill History</h4>
                <p class="text-sm text-gray-400">Check your past payments and billing history
                </p>
            </a>
            <a href="viewBills.jsp"
               class="bg-gray-800/50 hover:bg-gray-700/50 rounded-lg p-4 transition-colors">
                <div
                        class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400"
                         fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
                <h4 class="text-base font-medium text-white mb-1">Check Other Bills</h4>
                <p class="text-sm text-gray-400">View and pay any remaining electricity bills
                </p>
            </a>
            <a href="customerHome.jsp"
               class="bg-gray-800/50 hover:bg-gray-700/50 rounded-lg p-4 transition-colors">
                <div
                        class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400"
                         fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M3 12l2-2m0 0l7-7 7 7m-7-7v14"/>
                    </svg>
                </div>
                <h4 class="text-base font-medium text-white mb-1">Return to Dashboard</h4>
                <p class="text-sm text-gray-400">Go back to your account dashboard</p>
            </a>
        </div>
    </div>
    <% } %>
</div>

<script>
    // Store payment data in JavaScript variables for use in functions
    const paymentData = {
        transactionId: "<%= transactionId %>",
        receiptNumber: "<%= transactionId.length() > 8 ? transactionId.substring(0, 8) : transactionId %>",
        timestamp: "<%= transactionDate %>",
        userName: "<%= customerName %>",
        userId: "<%= customerId %>",
        billAmount: "<%= formattedAmount %>",
        amount: "<%= formattedAmount %>",
        pgCharge: "0.00",
        billNumbers: "<%= billNumbers %>",
        paymentMethod: "<%= paymentMethod.equalsIgnoreCase("netBanking") ? "Net Banking" : "Card" %>",
        status: "<%= paymentStatus %>"
    };

    document.addEventListener('DOMContentLoaded', function () {
        // Animate elements on load
        setTimeout(() => {
            const elements = document.querySelectorAll('.animate-fadeInUp');
            elements.forEach(el => {
                el.style.opacity = '1';
            });
        }, 100);
    });

    function printReceipt() {
        // Simple print functionality that uses the browser's print dialog
        window.print();
    }

    function downloadReceipt() {
        const currentYear = new Date().getFullYear();

        const receiptContent = document.createElement('div');
        receiptContent.innerHTML = `
        <div class="receipt" style="font-family: 'Arial', sans-serif; padding: 0.5in; height: 14in;  width: 7.5in; background: #1e293b; color: #e2e8f0; box-sizing: border-box;">
            <!-- Header with Logo -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5in; border-bottom: 2px solid #7c3aed; padding-bottom: 0.3in;">
                <div style="display: flex; align-items: center;">
                    <div style="margin-right: 0.3in;">
                        <svg width="40" height="40" viewBox="0 0 24 24" style="fill: #7c3aed;">
                            <path d="M13 10V3L4 14h7v7l9-11h-7z"/>
                        </svg>
                    </div>
                    <div>
                        <h1 style="margin: 0; color: #a78bfa; font-size: 20px;">PowerPay</h1>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Your Trusted Electricity Payment Partner</p>
                    </div>
                </div>
                <div style="text-align: right;">
                    <h2 style="margin: 0; color: #a78bfa; font-size: 24px;">RECEIPT</h2>
                    <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">${transactionId.length > 8 ? transactionId.substring(0, 8) : transactionId}</p>
                </div>
            </div>

            <!-- Customer Information -->
            <div style="margin-bottom: 0.5in; padding: 0.3in; background: #0f172a; border-radius: 6px;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 0.3in;">
                    <div>
                        <h3 style="margin: 0 0 0.2in 0; color: #a78bfa; font-size: 14px;">CUSTOMER DETAILS</h3>
                        <p style="margin: 0; color: #e2e8f0; font-size: 13px;">${paymentData.userName}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Customer ID: ${paymentData.userId}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Email: ${paymentData.userEmail}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Mobile: ${paymentData.userMobile}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Address: ${paymentData.userAddress}</p>
                    </div>
                    <div style="text-align: right;">
                        <h3 style="margin: 0 0 0.2in 0; color: #a78bfa; font-size: 14px;">PAYMENT DETAILS</h3>
                        <p style="margin: 0; color: #e2e8f0; font-size: 13px;">Transaction ID: ${transactionId}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Date: ${paymentData.timestamp}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Payment Method: ${paymentData.paymentMethod}</p>
                        <p style="margin: 0.1in 0; color: #94a3b8; font-size: 12px;">Status: ${paymentData.status}</p>
                    </div>
                </div>
            </div>

            <!-- Bill Details Table -->
            <div style="margin-bottom: 0.5in; border-radius: 6px; overflow: hidden;">
                <table style="width: 100%; border-collapse: collapse; background: #0f172a; font-size: 12px;">
                    <thead>
                        <tr style="background: #7c3aed; color: white;">
                            <th style="padding: 0.2in 0.25in; text-align: left;">DESCRIPTION</th>
                            <th style="padding: 0.2in 0.25in; text-align: right;">AMOUNT</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style="border-bottom: 1px solid #334155;">
                            <td style="padding: 0.2in 0.25in; color: #e2e8f0;">Electricity Bill Payment</td>
                            <td style="padding: 0.2in 0.25in; text-align: right; color: #e2e8f0;">$${paymentData.billAmount}</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #334155;">
                            <td style="padding: 0.2in 0.25in; color: #e2e8f0;">Bill Numbers</td>
                            <td style="padding: 0.2in 0.25in; text-align: right; color: #e2e8f0;">${billNumbers}</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #334155;">
                            <td style="padding: 0.2in 0.25in; color: #e2e8f0;">Payment Gateway Charge</td>
                            <td style="padding: 0.2in 0.25in; text-align: right; color: #e2e8f0;">$${paymentData.pgCharge}</td>
                        </tr>
                        <tr style="background: #1e293b; font-weight: bold;">
                            <td style="padding: 0.2in 0.25in; color: #a78bfa;">Total Amount Paid</td>
                            <td style="padding: 0.2in 0.25in; text-align: right; color: #a78bfa;">$${paymentData.amount}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Payment Status -->
            <div style="margin-bottom: 0.5in; padding: 0.25in; background: ${paymentData.status == "Completed" ? "#064e3b" : "#7f1d1d"}; border-radius: 6px; text-align: center;">
                <p style="margin: 0; color: ${paymentData.status == "Completed" ? "#6ee7b7" : "#fca5a5"}; font-size: 14px; font-weight: bold;">
                    Payment Status: ${paymentData.status}
                </p>
            </div>

        </div>
    `;

        try {
            const opt = {
                margin: [.5,.5], // Increased margins to prevent cutoff
                filename: `PowerPay_Receipt_<%=transactionId.substring(0, 8) %>.pdf`,
                image: { type: 'png', quality: 1 },
                html2canvas: {
                    scale: 1, // Increased scale for better quality
                    useCORS: true,
                    logging: true,
                    letterRendering: true,
                    dpi: 900 // Higher DPI for better resolution
                },
                jsPDF: {
                    unit: 'in',
                    format: 'a4',
                    orientation: 'portrait',
                    putOnlyUsedFonts: true,
                    floatPrecision: 32,
                    compression: true // Enable compression for smaller file size
                }
            };

            html2pdf().set(opt).from(receiptContent).save();
        } catch (error) {
            console.error('Error generating PDF:', error);
        }
    }

    // Alternative download method that creates a simple text file
    function downloadTextReceipt() {
        // Create a simple text receipt
        const textReceipt = `
            =======================================================
                            POWERPAY RECEIPT
            =======================================================
            Transaction ID: ${paymentData.transactionId}
            Receipt Number: ${paymentData.receiptNumber}
            Date: ${paymentData.timestamp}
            Payment Method: ${paymentData.paymentMethod}
            -------------------------------------------------------
            BILLED TO:
            Customer: ${paymentData.userName}
            Customer ID: ${paymentData.userId}
            -------------------------------------------------------
            BILL DETAILS:
            Bill Numbers: ${paymentData.billNumbers}
            Transaction Status: ${paymentData.status}
            -------------------------------------------------------
            PAYMENT SUMMARY:
            Electricity Bill Payment: $${paymentData.billAmount}
            Payment Gateway Charge: $${paymentData.pgCharge}
            -------------------------------------------------------
            TOTAL AMOUNT PAID: $${paymentData.amount}
            -------------------------------------------------------
            Thank you for your payment!
            For any queries, please contact our support team.
            =======================================================
            `;

        // Create a Blob with the text content
        const blob = new Blob([textReceipt], {type: 'text/plain'});

        // Create a download link
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = `PowerPay_Receipt_${paymentData.receiptNumber}.txt`;

        // Append to the document, click it, and remove it
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
</script>
</body>

</html>