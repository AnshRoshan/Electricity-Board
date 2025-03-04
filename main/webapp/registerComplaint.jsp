<%@ page import="com.anshroshan.electric.models.Customer" %>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Complaint - PowerPay</title>
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

    String customerEmail = (String) session.getAttribute("email");
    if (customerEmail == null) customerEmail = "";

    String customerPhone = (String) session.getAttribute("mobile");
    if (customerPhone == null) customerPhone = "";

    Customer customer = (Customer) session.getAttribute("customer");
    ArrayList<Consumer> consumers = customer.getConsumerList();
    ArrayList<Long> consumerNumbers = new ArrayList<>();
    for (Consumerc : consumers) {
        consumerNumbers.add(c.getConsumerNumber());
    }

    // Get error message if any
    String errorMessage = (String) request.getAttribute("errorMessage");
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
    <div class="card-gradient rounded-xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm">
        <h2 class="text-2xl font-bold text-white mb-6">Register a Complaint</h2>

        <%-- Display error message if any --%>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="bg-red-900/50 text-red-200 p-4 rounded-lg mb-6">
            <p><%= errorMessage %>
            </p>
        </div>
        <% } %>

        <form action="ComplaintServlet" method="post" class="space-y-6" id="complaintForm">
            <input type="hidden" name="customerId" value="<%= customerId %>">

            <div>
                <label for="consumerNumber" class="block text-sm font-medium text-gray-300 mb-1">Consumer
                    Number*</label>
                <select id="consumerNumber" name="consumerNumber"
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg py-2 px-3 text-white focus:outline-none focus:ring-2 focus:ring-primary-500"
                        required>
                    <option value="">Select ConsumerNumber</option>
                </select>
            </div>

            <div>
                <label for="complaintType" class="block text-sm font-medium text-gray-300 mb-1">Complaint Type*</label>
                <select id="complaintType" name="complaintType"
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg py-2 px-3 text-white focus:outline-none focus:ring-2 focus:ring-primary-500"
                        required onchange="updateCategories()">
                    <option value="">Select Complaint Type</option>
                    <option value="billing_issue">Billing Issue</option>
                    <option value="power_outage">Power Outage</option>
                    <option value="meter_reading_issue">Meter Reading Issue</option>
                </select>
            </div>

            <div>
                <label for="category" class="block text-sm font-medium text-gray-300 mb-1">Category*</label>
                <select id="category" name="category"
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg py-2 px-3 text-white focus:outline-none focus:ring-2 focus:ring-primary-500"
                        required>
                    <option value="">Select Category</option>
                </select>
            </div>

            <div>
                <label for="description" class="block text-sm font-medium text-gray-300 mb-1">Description* (max 500
                    characters)</label>
                <textarea id="description" name="description" rows="4" maxlength="500"
                          class="w-full bg-gray-800 border border-gray-700 rounded-lg py-2 px-3 text-white focus:outline-none focus:ring-2 focus:ring-primary-500"
                          required></textarea>
                <div class="text-xs text-gray-400 mt-1">
                    <span id="charCount">0</span>/500 characters
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-300 mb-2">Preferred Contact Method*</label>
                <div class="flex space-x-4">
                    <div class="flex items-center">
                        <input type="radio" id="contactEmail" name="contactMethod" value="email"
                               class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 bg-gray-800"
                               checked>
                        <label for="contactEmail" class="ml-2 text-sm text-gray-300">Email</label>
                    </div>
                    <div class="flex items-center">
                        <input type="radio" id="contactPhone" name="contactMethod" value="phone"
                               class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 bg-gray-800">
                        <label for="contactPhone" class="ml-2 text-sm text-gray-300">Phone</label>
                    </div>
                </div>
            </div>

            <div>
                <label for="contact" class="block text-sm font-medium text-gray-300 mb-1">Contact Details*</label>
                <input type="text" id="contact" name="contact" value="<%= customerEmail %>"
                       class="w-full bg-gray-800 border border-gray-700 rounded-lg py-2 px-3 text-white focus:outline-none focus:ring-2 focus:ring-primary-500"
                       required>
                <div class="text-xs text-gray-400 mt-1" id="contactHelp">
                    Please provide your email address
                </div>
            </div>

            <div class="flex space-x-4 pt-4">
                <button type="submit"
                        class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                    </svg>
                    Submit Complaint
                </button>
                <button type="reset" onclick="resetForm()"
                        class="px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                    </svg>
                    Reset
                </button>
            </div>
        </form>
    </div>
</div>

<script>

    var x = document.getElementById("consumerNumber");
    let categories = <%= consumerNumbers%>
        categories.forEach(category => {
            const option = document.createElement("option");
            option.value = category;
            option.textContent = category;
            x.appendChild(option);
        })


    // Update categories based on complaint type
    function updateCategories() {
        const complaintType = document.getElementById("complaintType").value;
        const categorySelect = document.getElementById("category");

        // Clear existing options
        categorySelect.innerHTML = '<option value="">Select Category</option>';

        // Add new options based on complaint type
        let categories = [];

        if (complaintType === "billing_issue") {
            categories = ["Overcharging", "Payment Error", "Bill Dispute"];
        } else if (complaintType === "power_outage") {
            categories = ["Partial Outage", "Complete Outage", "Frequent Outages"];
        } else if (complaintType === "meter_reading_issue") {
            categories = ["Incorrect Reading", "Meter Failure", "Access Issue"];
        }

        // Add options to select
        categories.forEach(category => {
            const option = document.createElement("option");
            option.value = category;
            option.textContent = category;
            categorySelect.appendChild(option);
        });
    }

    // Character counter for description
    const descriptionField = document.getElementById("description");
    const charCount = document.getElementById("charCount");

    descriptionField.addEventListener("input", function () {
        charCount.textContent = this.value.length;
    });

    // Update contact help text based on selected contact method
    const contactEmail = document.getElementById("contactEmail");
    const contactPhone = document.getElementById("contactPhone");
    const contactHelp = document.getElementById("contactHelp");
    const contactField = document.getElementById("contact");

    contactEmail.addEventListener("change", function () {
        if (this.checked) {
            contactHelp.textContent = "Please provide your email address";
            contactField.value = "<%= customerEmail %>";
            contactField.type = "email";
        }
    });

    contactPhone.addEventListener("change", function () {
        if (this.checked) {
            contactHelp.textContent = "Please provide your phone number";
            contactField.value = "<%= customerPhone %>";
            contactField.type = "tel";
        }
    });

    // Form validation
    document.getElementById("complaintForm").addEventListener("submit", function (event) {
        const complaintType = document.getElementById("complaintType").value;
        const category = document.getElementById("category").value;
        const description = document.getElementById("description").value;
        const contact = document.getElementById("contact").value;
        const contactMethod = document.querySelector('input[name="contactMethod"]:checked').value;

        let isValid = true;
        let errorMessage = "";

        if (!complaintType) {
            errorMessage += "Please select a complaint type. ";
            isValid = false;
        }

        if (!category) {
            errorMessage += "Please select a category. ";
            isValid = false;
        }

        if (!description || description.trim().length === 0) {
            errorMessage += "Please provide a description. ";
            isValid = false;
        }

        if (!contact || contact.trim().length === 0) {
            errorMessage += "Please provide contact details. ";
            isValid = false;
        }

        // Email validation
        if (contactMethod === "email") {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(contact)) {
                errorMessage += "Please provide a valid email address. ";
                isValid = false;
            }
        }

        // Phone validation
        if (contactMethod === "phone") {
            const phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(contact.replace(/\D/g, ''))) {
                errorMessage += "Please provide a valid 10-digit phone number. ";
                isValid = false;
            }
        }

        if (!isValid) {
            alert(errorMessage);
            event.preventDefault();
        }
    });

    // Reset form
    function resetForm() {
        document.getElementById("complaintForm").reset();
        document.getElementById("category").innerHTML = '<option value="">Select Category</option>';
        document.getElementById("charCount").textContent = "0";
        document.getElementById("contactHelp").textContent = "Please provide your email address";
        document.getElementById("contact").value = "<%= customerEmail %>";
        document.getElementById("contact").type = "email";
    }
</script>
</body>
</html>