<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.anshroshan.electric.models.Complaint" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaints - PowerPay</title>
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
    </style>
</head>
<body class="min-h-screen text-gray-100">
    <%-- Get customer information from session --%>
    <% 
        String customerName = (String) session.getAttribute("customerName");
        if (customerName == null) customerName = "Customer";
        
        String customerId = (String) session.getAttribute("customerId");
        if (customerId == null) customerId = "";
        
        // Get complaints list from request attribute (would be set by a servlet)
        List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
        
        // Date formatter
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
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

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-white">Your Complaints</h2>
                <a href="registerComplaint.jsp" 
                   class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    New Complaint
                </a>
            </div>
            
            <% if (complaints == null || complaints.isEmpty()) { %>
                <div class="bg-gray-800/50 rounded-lg p-8 text-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mx-auto text-gray-600 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    <h3 class="text-xl font-medium text-gray-300 mb-2">No Complaints Found</h3>
                    <p class="text-gray-400 mb-6">You haven't submitted any complaints yet.</p>
                    <a href="registerComplaint.jsp" class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow inline-flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                        Register a Complaint
                    </a>
                </div>
            <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-700">
                        <thead class="bg-gray-800">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                    Complaint ID
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                    Type
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                    Category
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                    Submission Date
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                    Status
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-gray-900 divide-y divide-gray-800">
                            <% for (Complaint complaint : complaints) { 
                                // Format complaint type for display
                                String displayType = "";
                                if (complaint.getCompType() != null) {
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
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-white">
                                        <%= complaint.getComplaintId() %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                        <%= displayType %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                        <%= complaint.getCategory() %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                        <%= complaint.getSubmissionDate() != null ? dateFormat.format(complaint.getSubmissionDate()) : "N/A" %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 py-1 text-xs font-semibold rounded-full <%= statusBgColor %> <%= statusTextColor %>">
                                            <%= complaint.getStatus() %>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">
                                        <a href="viewComplaintDetails.jsp?id=<%= complaint.getComplaintId() %>" 
                                           class="text-primary-400 hover:text-primary-300">
                                            View Details
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html> 