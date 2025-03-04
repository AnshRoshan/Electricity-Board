<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Complaint" %>
<%@ page import="com.anshroshan.electric.service.ComplaintService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Details - PowerPay</title>
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
        .timeline-container {
            position: relative;
        }
        .timeline-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 18px;
            height: 100%;
            width: 2px;
            background: #334155;
        }
    </style>
</head>
<body class="min-h-screen text-gray-100">
    <%-- Get complaint ID from request parameter --%>
    <% 
        String complaintId = request.getParameter("id");
        Complaint complaint = null;
        String errorMessage = null;
        
        // Get customer information from session
        String customerName = (String) session.getAttribute("customerName");
        if (customerName == null) customerName = "Customer";
        
        String customerId = (String) session.getAttribute("customerId");
        if (customerId == null) customerId = "";
        
        // Date formatter
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
        
        // Retrieve complaint if ID is provided
        if (complaintId != null && !complaintId.isEmpty()) {
            try {
                ComplaintService complaintService = new ComplaintService();
                complaint = complaintService.getComplaintById(complaintId);
                
                // Verify that the complaint belongs to the logged-in customer
                if (complaint != null && !complaint.getCustomerId().equals(customerId)) {
                    complaint = null;
                    errorMessage = "You do not have permission to view this complaint.";
                }
            } catch (Exception e) {
                errorMessage = "Error retrieving complaint: " + e.getMessage();
            }
        } else {
            errorMessage = "No complaint ID provided.";
        }
        
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
                    <a href="viewComplaints"
                       class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Complaints</a>
                    <a href="logout"
                       class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <% if (errorMessage != null) { %>
            <div class="bg-red-900/50 border border-red-700 text-red-300 px-4 py-3 rounded-lg mb-6">
                <p><strong>Error:</strong> <%= errorMessage %></p>
                <div class="mt-4">
                    <a href="viewComplaints" class="text-white bg-red-700 hover:bg-red-800 px-4 py-2 rounded-lg">
                        Back to Complaints
                    </a>
                </div>
            </div>
        <% } else if (complaint != null) { %>
            <div class="mb-4">
                <a href="viewComplaints" class="inline-flex items-center text-gray-400 hover:text-white">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Back to Complaints
                </a>
            </div>
            
            <div class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm">
                <div class="flex justify-between items-start mb-6">
                    <div>
                        <h2 class="text-2xl font-bold text-white mb-2">Complaint #<%= complaint.getComplaintId() %></h2>
                        <p class="text-gray-400">Submitted on <%= complaint.getSubmissionDate() != null ? dateFormat.format(complaint.getSubmissionDate()) : "N/A" %></p>
                    </div>
                    
                    <% 
                        // Determine status badge color
                        String statusBgColor = "";
                        String statusTextColor = "";
                        if ("Pending".equalsIgnoreCase(complaint.getStatus())) {
                            statusBgColor = "bg-yellow-900";
                            statusTextColor = "text-yellow-300";
                        } else if ("In Progress".equalsIgnoreCase(complaint.getStatus())) {
                            statusBgColor = "bg-blue-900";
                            statusTextColor = "text-blue-300";
                        } else if ("Resolved".equalsIgnoreCase(complaint.getStatus())) {
                            statusBgColor = "bg-green-900";
                            statusTextColor = "text-green-300";
                        } else if ("Closed".equalsIgnoreCase(complaint.getStatus())) {
                            statusBgColor = "bg-gray-700";
                            statusTextColor = "text-gray-300";
                        } else {
                            statusBgColor = "bg-red-900";
                            statusTextColor = "text-red-300";
                        }
                    %>
                    <span class="px-3 py-1 text-sm font-semibold rounded-full <%= statusBgColor %> <%= statusTextColor %>">
                        <%= complaint.getStatus() %>
                    </span>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div>
                        <div class="bg-gray-800/50 rounded-lg p-6 mb-6">
                            <h3 class="text-lg font-semibold text-white mb-4">Complaint Information</h3>
                            
                            <div class="space-y-4">
                                <div>
                                    <p class="text-sm text-gray-400">Type</p>
                                    <p class="text-white"><%= displayType %></p>
                                </div>
                                
                                <div>
                                    <p class="text-sm text-gray-400">Category</p>
                                    <p class="text-white"><%= complaint.getCategory() %></p>
                                </div>
                                
                                <div>
                                    <p class="text-sm text-gray-400">Description</p>
                                    <p class="text-white whitespace-pre-line"><%= complaint.getDescription() %></p>
                                </div>
                                
                                <div>
                                    <p class="text-sm text-gray-400">Preferred Contact Method</p>
                                    <p class="text-white"><%= complaint.getContactMethod() %></p>
                                </div>
                                
                                <div>
                                    <p class="text-sm text-gray-400">Contact Information</p>
                                    <p class="text-white"><%= complaint.getContact() %></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="bg-gray-800/50 rounded-lg p-6">
                            <h3 class="text-lg font-semibold text-white mb-4">Resolution Information</h3>
                            
                            <div class="space-y-4">
                                <div>
                                    <p class="text-sm text-gray-400">Estimated Resolution Time</p>
                                    <p class="text-white"><%= complaint.getEstimatedResolutionTime() %> hours</p>
                                </div>
                                
                                <% if (complaint.getResolutionDate() != null) { %>
                                    <div>
                                        <p class="text-sm text-gray-400">Resolution Date</p>
                                        <p class="text-white"><%= dateFormat.format(complaint.getResolutionDate()) %></p>
                                    </div>
                                <% } %>
                                
                                <% if (complaint.getResolutionDetails() != null && !complaint.getResolutionDetails().isEmpty()) { %>
                                    <div>
                                        <p class="text-sm text-gray-400">Resolution Details</p>
                                        <p class="text-white whitespace-pre-line"><%= complaint.getResolutionDetails() %></p>
                                    </div>
                                <% } else if ("Resolved".equalsIgnoreCase(complaint.getStatus()) || "Closed".equalsIgnoreCase(complaint.getStatus())) { %>
                                    <div>
                                        <p class="text-sm text-gray-400">Resolution Details</p>
                                        <p class="text-white">Your complaint has been resolved. If you have any further questions, please contact customer support.</p>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="bg-gray-800/50 rounded-lg p-6 mb-6">
                            <h3 class="text-lg font-semibold text-white mb-4">Status Timeline</h3>
                            
                            <div class="timeline-container pl-10 space-y-6">
                                <div class="relative">
                                    <div class="absolute -left-10 mt-1.5">
                                        <div class="h-4 w-4 rounded-full bg-green-500 border-2 border-gray-800"></div>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-white">Complaint Submitted</p>
                                        <p class="text-xs text-gray-400"><%= complaint.getSubmissionDate() != null ? dateFormat.format(complaint.getSubmissionDate()) : "N/A" %></p>
                                    </div>
                                </div>
                                
                                <% if ("In Progress".equalsIgnoreCase(complaint.getStatus()) || 
                                      "Resolved".equalsIgnoreCase(complaint.getStatus()) || 
                                      "Closed".equalsIgnoreCase(complaint.getStatus())) { %>
                                    <div class="relative">
                                        <div class="absolute -left-10 mt-1.5">
                                            <div class="h-4 w-4 rounded-full bg-blue-500 border-2 border-gray-800"></div>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-white">Processing Started</p>
                                            <p class="text-xs text-gray-400"><%= complaint.getLastUpdateDate() != null ? dateFormat.format(complaint.getLastUpdateDate()) : "N/A" %></p>
                                            <p class="text-xs text-gray-400 mt-1">Your complaint is being reviewed by our team.</p>
                                        </div>
                                    </div>
                                <% } %>
                                
                                <% if ("Resolved".equalsIgnoreCase(complaint.getStatus()) || 
                                      "Closed".equalsIgnoreCase(complaint.getStatus())) { %>
                                    <div class="relative">
                                        <div class="absolute -left-10 mt-1.5">
                                            <div class="h-4 w-4 rounded-full bg-green-500 border-2 border-gray-800"></div>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-white">Complaint Resolved</p>
                                            <p class="text-xs text-gray-400"><%= complaint.getResolutionDate() != null ? dateFormat.format(complaint.getResolutionDate()) : "N/A" %></p>
                                        </div>
                                    </div>
                                <% } %>
                                
                                <% if ("Closed".equalsIgnoreCase(complaint.getStatus())) { %>
                                    <div class="relative">
                                        <div class="absolute -left-10 mt-1.5">
                                            <div class="h-4 w-4 rounded-full bg-gray-500 border-2 border-gray-800"></div>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-white">Case Closed</p>
                                            <p class="text-xs text-gray-400"><%= complaint.getLastUpdateDate() != null ? dateFormat.format(complaint.getLastUpdateDate()) : "N/A" %></p>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="bg-gray-800/50 rounded-lg p-6">
                            <h3 class="text-lg font-semibold text-white mb-4">Need Help?</h3>
                            
                            <p class="text-gray-300 mb-4">If you have any questions about this complaint or need further assistance, please contact our customer support team.</p>
                            
                            <div class="space-y-4">
                                <div class="flex items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                    </svg>
                                    <span class="text-gray-300">1-800-POWER-HELP</span>
                                </div>
                                
                                <div class="flex items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                    </svg>
                                    <span class="text-gray-300">support@powerpay.com</span>
                                </div>
                            </div>
                            
                            <div class="mt-6">
                                <% if (!"Closed".equalsIgnoreCase(complaint.getStatus())) { %>
                                    <a href="#" class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium button-glow inline-block">
                                        Contact Support
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html> 