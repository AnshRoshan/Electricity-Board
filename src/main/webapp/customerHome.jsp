<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.anshroshan.electric.models.Customer" %>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electric - Customer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
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
                            950: '#2e1065',
                        },
                        dark: {
                            100: '#1e1e2f',
                            200: '#171727',
                            300: '#13131f',
                            400: '#0f0f1a',
                            500: '#0a0a12',
                        }
                    },
                    animation: {
                        'pulse-slow': 'pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                        'float': 'float 3s ease-in-out infinite',
                    },
                    keyframes: {
                        float: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-10px)' },
                        }
                    },
                    boxShadow: {
                        'neon': '0 0 5px theme("colors.primary.400"), 0 0 20px theme("colors.primary.600")',
                        'neon-lg': '0 0 10px theme("colors.primary.400"), 0 0 30px theme("colors.primary.600")',
                    }
                }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-image:
                    radial-gradient(circle at 10% 20%, rgba(111, 63, 251, 0.1) 0%, rgba(70, 30, 190, 0.05) 90%),
                    linear-gradient(135deg, #0f0f1a 0%, #1a1a2e 100%);
            background-attachment: fixed;
        }

        .glass {
            background: rgba(30, 30, 47, 0.6);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(123, 74, 226, 0.1);
        }

        .glass-card {
            background: rgba(19, 19, 31, 0.7);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(123, 74, 226, 0.15);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px -5px rgba(123, 74, 226, 0.3);
            border: 1px solid rgba(123, 74, 226, 0.3);
        }

        .nav-link {
            position: relative;
            transition: all 0.3s ease;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background: linear-gradient(90deg, #8b5cf6, #6d28d9);
            transition: width 0.3s ease;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .glow-button {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .glow-button::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            z-index: -1;
            background: linear-gradient(45deg, #8b5cf6, #6d28d9, #4c1d95, #6d28d9, #8b5cf6);
            background-size: 400%;
            border-radius: 0.5rem;
            animation: glowing 20s linear infinite;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .glow-button:hover::before {
            opacity: 1;
        }

        @keyframes glowing {
            0% {
                background-position: 0 0;
            }

            50% {
                background-position: 400% 0;
            }

            100% {
                background-position: 0 0;
            }
        }

        .animate-in {
            animation: fadeInUp 0.6s ease forwards;
            opacity: 0;
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
    </style>
</head>

<body class="min-h-screen text-gray-200">
<% Customer customer=(Customer) session.getAttribute("customer"); Bill latestBill=(Bill)
        session.getAttribute("latestBill"); if (customer==null) { response.sendRedirect("login.jsp");
    return; } %>

<div class="container mx-auto px-4 py-8">
    <!-- Header with Logo -->
    <header class="flex justify-between items-center mb-8 animate-in"
            style="animation-delay: 0.1s;">
        <div class="flex items-center">
            <div class="text-primary-500 mr-3">
                <i class="fas fa-bolt text-3xl"></i>
            </div>
            <div>
                <h1
                        class="text-2xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-primary-400 to-primary-600">
                    Electric</h1>
                <p class="text-xs text-gray-400">Smart Energy Solutions</p>
            </div>
        </div>
        <div class="flex items-center space-x-4">
            <div class="hidden md:flex items-center mr-4">
                <div class="h-2 w-2 rounded-full bg-green-400 animate-pulse mr-2"></div>
                <span class="text-sm text-gray-400">Online</span>
            </div>
            <div class="flex items-center">
                <div
                        class="w-10 h-10 rounded-full bg-gradient-to-r from-primary-600 to-primary-800 flex items-center justify-center text-white font-bold mr-3">
                    <%= customer.getName().substring(0, 1).toUpperCase() %>
                </div>
                <div class="hidden md:block">
                    <p class="text-sm font-medium">
                        <%= customer.getName() %>
                    </p>
                    <p class="text-xs text-gray-400">ID: <%= customer.getCustomerId() %>
                    </p>
                </div>
            </div>
            <a href="logout"
               class="bg-dark-200 hover:bg-dark-100 text-gray-300 px-4 py-2 rounded-lg transition-all duration-300 flex items-center">
                <i class="fas fa-sign-out-alt mr-2"></i>
                <span class="hidden md:inline">Logout</span>
            </a>
        </div>
    </header>

    <div class="flex flex-col lg:flex-row gap-6">
        <!-- Sidebar Navigation -->
        <div class="lg:w-1/4 animate-in" style="animation-delay: 0.2s;">
            <div class="glass rounded-2xl p-6 sticky top-8">
                <div class="mb-6">
                    <h2 class="text-xl font-semibold mb-2">Welcome Back!</h2>
                    <p class="text-gray-400 text-sm">Manage your electricity account with ease.</p>
                </div>

                <nav class="space-y-2">
                    <a href="index.jsp"
                       class="flex items-center p-3 rounded-xl bg-gradient-to-r from-primary-900/50 to-primary-800/30 text-primary-300 border border-primary-700/30">
                        <i class="fas fa-home w-5 text-center mr-3"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="viewBills.jsp"
                       class="nav-link flex items-center p-3 rounded-xl hover:bg-dark-200 transition-all duration-300">
                        <i class="fas fa-file-invoice-dollar w-5 text-center mr-3"></i>
                        <span>View Bills</span>
                    </a>
                    <a href="paysuccess.jsp"
                       class="nav-link flex items-center p-3 rounded-xl hover:bg-dark-200 transition-all duration-300">
                        <i class="fas fa-credit-card w-5 text-center mr-3"></i>
                        <span>Pay Bill</span>
                    </a>
                    <a href="billHistory.jsp"
                       class="nav-link flex items-center p-3 rounded-xl hover:bg-dark-200 transition-all duration-300">
                        <i class="fas fa-history w-5 text-center mr-3"></i>
                        <span>Bill History</span>
                    </a>
                    <a href="registerComplaint.jsp"
                       class="nav-link flex items-center p-3 rounded-xl hover:bg-dark-200 transition-all duration-300">
                        <i class="fas fa-exclamation-circle w-5 text-center mr-3"></i>
                        <span>Register Complaint</span>
                    </a>
                    <a href="complaintStatus.jsp"
                       class="nav-link flex items-center p-3 rounded-xl hover:bg-dark-200 transition-all duration-300">
                        <i class="fas fa-tasks w-5 text-center mr-3"></i>
                        <span>Complaint Status</span>
                    </a>
                    <a href="profile.jsp"
                       class="nav-link flex items-center p-3 rounded-xl hover:bg-dark-200 transition-all duration-300">
                        <i class="fas fa-user w-5 text-center mr-3"></i>
                        <span>Profile</span>
                    </a>
                </nav>

                <div
                        class="mt-8 p-4 rounded-xl bg-gradient-to-br from-primary-900/40 to-primary-800/20 border border-primary-700/20">
                    <div class="flex items-center mb-3">
                        <i class="fas fa-lightbulb text-yellow-400 mr-2"></i>
                        <h3 class="font-medium">Energy Tip</h3>
                    </div>
                    <p class="text-sm text-gray-400">Switch to LED bulbs to save up to 80% on
                        lighting costs compared to traditional incandescent bulbs.</p>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="lg:w-3/4 space-y-6">
            <!-- Profile Card -->
            <div class="glass-card rounded-2xl p-6 animate-in" style="animation-delay: 0.3s;">
                <div class="flex items-center mb-4">
                    <div class="p-2 rounded-lg bg-primary-900/30 text-primary-400 mr-3">
                        <i class="fas fa-user-circle text-xl"></i>
                    </div>
                    <h2 class="text-xl font-semibold">Profile Information</h2>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="space-y-4">
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Customer ID</span>
                            <span class="font-medium">
                                                    <%= customer.getCustomerId() %>
                                                </span>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Full Name</span>
                            <span class="font-medium">
                                                    <%= customer.getName() %>
                                                </span>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Email Address</span>
                            <span class="font-medium">
                                                    <%= customer.getEmail() %>
                                                </span>
                        </div>
                    </div>
                    <div class="space-y-4">
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Mobile Number</span>
                            <span class="font-medium">
                                                    <%= customer.getMobile() %>
                                                </span>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Address</span>
                            <span class="font-medium">
                                                    <%= customer.getAddress() %>
                                                </span>
                        </div>
                        <div class="flex justify-end mt-4">
                            <a href="profile.jsp"
                               class="text-primary-400 hover:text-primary-300 text-sm flex items-center">
                                <span>Edit Profile</span>
                                <i class="fas fa-chevron-right ml-1 text-xs"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Current Bill Summary -->
            <div class="glass-card rounded-2xl p-6 animate-in" style="animation-delay: 0.4s;">
                <div class="flex items-center mb-4">
                    <div class="p-2 rounded-lg bg-primary-900/30 text-primary-400 mr-3">
                        <i class="fas fa-file-invoice text-xl"></i>
                    </div>
                    <h2 class="text-xl font-semibold">Current Bill Summary</h2>
                </div>

                <% if (latestBill !=null) { %>
                <div class="bg-dark-300/50 rounded-xl p-5 border border-primary-900/20">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Billing Period</span>
                            <span class="font-medium">
                                                        <%= latestBill.getPeriod() %>
                                                    </span>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Due Date</span>
                            <span class="font-medium text-yellow-400">
                                                        <%= latestBill.getDueDate() %>
                                                    </span>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-sm text-gray-400 mb-1">Amount Due</span>
                            <span class="text-xl font-semibold text-primary-400">$<%=
                            String.format("%.2f", latestBill.getAmount()) %></span>
                        </div>
                    </div>

                    <div class="mt-6 flex justify-end">
                        <a href="paysuccess.jsp?billId=<%= latestBill.getBillId() %>"
                           class="glow-button bg-gradient-to-r from-primary-600 to-primary-800 hover:from-primary-500 hover:to-primary-700 text-white py-3 px-6 rounded-lg font-medium flex items-center">
                            <i class="fas fa-credit-card mr-2"></i>
                            Pay Now
                        </a>
                    </div>
                </div>
                <% } else { %>
                <div
                        class="bg-dark-300/50 rounded-xl p-5 border border-primary-900/20 flex flex-col items-center justify-center py-10">
                    <div class="text-primary-400 mb-3">
                        <i class="fas fa-check-circle text-4xl"></i>
                    </div>
                    <p class="text-center text-gray-300 mb-1">No unpaid bills found</p>
                    <p class="text-center text-gray-400 text-sm">You're all caught up with
                        your payments!</p>
                </div>
                <% } %>
            </div>

            <!-- Quick Actions -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 animate-in"
                 style="animation-delay: 0.5s;">
                <div class="glass-card rounded-2xl p-5 text-center">
                    <div
                            class="w-12 h-12 mx-auto mb-3 rounded-full bg-primary-900/30 flex items-center justify-center text-primary-400">
                        <i class="fas fa-history text-xl"></i>
                    </div>
                    <h3 class="font-medium mb-1">Bill History</h3>
                    <p class="text-sm text-gray-400 mb-4">View your past payments</p>
                    <a href="billHistory.jsp"
                       class="text-primary-400 hover:text-primary-300 text-sm">View History</a>
                </div>

                <div class="glass-card rounded-2xl p-5 text-center">
                    <div
                            class="w-12 h-12 mx-auto mb-3 rounded-full bg-primary-900/30 flex items-center justify-center text-primary-400">
                        <i class="fas fa-exclamation-circle text-xl"></i>
                    </div>
                    <h3 class="font-medium mb-1">Report Issue</h3>
                    <p class="text-sm text-gray-400 mb-4">Register a new complaint</p>
                    <a href="registerComplaint.jsp"
                       class="text-primary-400 hover:text-primary-300 text-sm">Register Now</a>
                </div>

                <div class="glass-card rounded-2xl p-5 text-center">
                    <div
                            class="w-12 h-12 mx-auto mb-3 rounded-full bg-primary-900/30 flex items-center justify-center text-primary-400">
                        <i class="fas fa-tasks text-xl"></i>
                    </div>
                    <h3 class="font-medium mb-1">Complaint Status</h3>
                    <p class="text-sm text-gray-400 mb-4">Check your complaint status</p>
                    <a href="complaintStatus.jsp"
                       class="text-primary-400 hover:text-primary-300 text-sm">Check Status</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="mt-12 text-center text-gray-400 text-sm animate-in"
            style="animation-delay: 0.6s;">
        <p>© 2024 Electric - Smart Energy Solutions. All rights reserved.</p>
    </footer>
</div>

<script>
    // Animation on page load
    document.addEventListener('DOMContentLoaded', () => {
        const animatedElements = document.querySelectorAll('.animate-in');
        animatedElements.forEach(element => {
            element.style.animationPlayState = 'running';
        });
    });
</script>
</body>

</html>