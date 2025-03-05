<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Complaint" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Confirmation - PowerPay</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
    </style>
</head>
<body class="min-h-screen text-gray-100">
    <%-- Get complaint information from request --%>
    <% 
        String complaintId = (String) request.getAttribute("complaintId");
        String estimatedTime = (String) request.getAttribute("estimatedTime");
        String complaintSummary = (String) request.getAttribute("complaintSummary");
        Complaint complaint = (Complaint) request.getAttribute("complaint");
        
        // Format complaint type for display
        String displayType = "";
        if (complaint != null && complaint.getCompType() != null) {
            String type = complaint.getCompType();
            if (type.equals("billing_issue")) {
                displayType = "Billing Issue";
            } else if (type.equals("power_outage")) {
                displayType = "Power Outage";
            } else if (type.equals("meter_reading_issue")) {
                displayType = "Meter Reading Issue";
            } else {
                displayType = type;
            }
        }
    %>

    <!-- Navbar -->
    <nav class="bg-gray-900 border-b border-gray-800 shadow-lg">
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
        <div class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm opacity-0 animate-fadeInUp">
            <div class="flex flex-col items-center justify-center text-center mb-8">
                <div class="h-20 w-20 rounded-full bg-green-900/50 flex items-center justify-center mb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-green-400"
                         fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path class="animate-checkmark" stroke-linecap="round"
                              stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                    </svg>
                </div>
                <h2 class="text-2xl font-bold text-white mb-2">Complaint Registered Successfully!</h2>
                <p class="text-gray-400">Your complaint has been submitted and will be addressed shortly.</p>
            </div>

            <!-- Complaint Details Card -->
            <div class="bg-gray-800/50 rounded-lg border border-gray-700 p-6 mb-6">
                <div class="flex justify-between items-center mb-6">
                    <div class="flex items-center">
                        <div class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mr-3">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400"
                                 fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                                </path>
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-white">Complaint Details</h3>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                    <div>
                        <p class="text-sm text-gray-400">Complaint ID</p>
                        <p class="text-base font-medium text-white">
                            <%= complaintId %>
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-400">Estimated Resolution Time</p>
                        <p class="text-base font-medium text-white">
                            <%= estimatedTime %>
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-400">Complaint Type</p>
                        <p class="text-base font-medium text-white">
                            <%= displayType %>
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-400">Category</p>
                        <p class="text-base font-medium text-white">
                            <%= complaint != null ? complaint.getCategory() : "" %>
                        </p>
                    </div>
                </div>

                <div class="border-t border-gray-700 pt-4 mb-4">
                    <h4 class="text-sm font-medium text-gray-300 mb-3">Description</h4>
                    <div class="bg-gray-900/50 rounded-lg p-3 mb-4">
                        <p class="text-sm text-white whitespace-pre-line">
                            <%= complaint != null ? complaint.getDescription() : "" %>
                        </p>
                    </div>
                </div>

                <div class="border-t border-gray-700 pt-4">
                    <div class="flex justify-between items-center">
                        <span class="text-base font-medium text-gray-300">Status</span>
                        <span class="px-2 py-1 text-xs font-semibold rounded-full bg-yellow-900 text-yellow-300">
                            Pending
                        </span>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row justify-center space-y-3 sm:space-y-0 sm:space-x-4">
                <a href="customerHome.jsp"
                   class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M3 12l2-2m0 0l7-7 7 7m-7-7v14"/>
                    </svg>
                    Return to Dashboard
                </a>
                <a href="viewComplaints.jsp"
                   class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                    </svg>
                    View All Complaints
                </a>
            </div>
        </div>

        <!-- What's Next Section -->
        <div class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-6 backdrop-blur-sm opacity-0 animate-fadeInUp mt-6">
            <h3 class="text-lg font-semibold text-white mb-4">What's Next?</h3>
            <div class="space-y-4">
                <div class="bg-gray-800/50 rounded-lg p-4">
                    <div class="flex items-start">
                        <div class="h-8 w-8 rounded-full bg-primary-900/50 flex items-center justify-center mr-3 mt-1">
                            <span class="text-primary-400 font-bold">1</span>
                        </div>
                        <div>
                            <h4 class="text-base font-medium text-white mb-1">Review Process</h4>
                            <p class="text-sm text-gray-400">Our team will review your complaint and begin working on a resolution.</p>
                        </div>
                    </div>
                </div>
                <div class="bg-gray-800/50 rounded-lg p-4">
                    <div class="flex items-start">
                        <div class="h-8 w-8 rounded-full bg-primary-900/50 flex items-center justify-center mr-3 mt-1">
                            <span class="text-primary-400 font-bold">2</span>
                        </div>
                        <div>
                            <h4 class="text-base font-medium text-white mb-1">Status Updates</h4>
                            <p class="text-sm text-gray-400">You'll receive updates on your complaint status via your preferred contact method.</p>
                        </div>
                    </div>
                </div>
                <div class="bg-gray-800/50 rounded-lg p-4">
                    <div class="flex items-start">
                        <div class="h-8 w-8 rounded-full bg-primary-900/50 flex items-center justify-center mr-3 mt-1">
                            <span class="text-primary-400 font-bold">3</span>
                        </div>
                        <div>
                            <h4 class="text-base font-medium text-white mb-1">Resolution</h4>
                            <p class="text-sm text-gray-400">Once resolved, you'll receive a confirmation and details of the resolution.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Animate elements on load
            setTimeout(() => {
                const elements = document.querySelectorAll('.animate-fadeInUp');
                elements.forEach(el => {
                    el.style.opacity = '1';
                });
            }, 100);
        });
    </script>
</body>
</html>