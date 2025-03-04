<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.anshroshan.electric.models.Bill" %>
<%@ page import="com.anshroshan.electric.models.Consumer" %>
<%@ page import="com.anshroshan.electric.models.Customer" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bills</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .status-paid {
            color: green;
            font-weight: bold;
        }
        .status-unpaid {
            color: red;
            font-weight: bold;
        }
        .btn {
            display: inline-block;
            padding: 8px 12px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 5px;
        }
        .btn-view {
            background-color: #2196F3;
        }
        .btn-pay {
            background-color: #4CAF50;
        }
        .btn-back {
            background-color: #555;
            margin-bottom: 20px;
        }
        .no-bills {
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Electricity Bills</h1>
        
        <a href="customerHome.jsp" class="btn btn-back">Back to Dashboard</a>
        
        <% 
            Customer customer = (Customer) session.getAttribute("customer");
            if (customer == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            boolean hasUnpaidBills = false;
            int totalConsumers = customer.getConsumerList().size();
        %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (totalConsumers == 0) { %>
            <div class="no-bills">
                <p>No consumers found. Please add a consumer to view bills.</p>
            </div>
        <% } else { %>
            <form method="post" action="viewBills">
                <table>
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAll" onchange="toggleAll(this)">
                                <label for="selectAll">Select</label>
                            </th>
                            <th>ConsumerID</th>
                            <th>Bill Number</th>
                            <th>Period</th>
                            <th>Due Date</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (Consumerconsumer : customer.getConsumerList()) {
                                for (Bill bill : consumer.getBills()) {
                                    double payableAmount = "Paid".equals(bill.getStatus()) ? 0 : bill.getAmount() + bill.getLateFee();
                                    if (!"Paid".equals(bill.getStatus())) {
                                        hasUnpaidBills = true;
                                    }
                        %>
                        <tr>
                            <td>
                                <input type="checkbox" name="selectedBills" value="<%= bill.getBillId() %>" 
                                       data-amount="<%= payableAmount %>" onchange="updateTotal()"
                                       <%= "Paid".equals(bill.getStatus()) ? "disabled" : "" %>>
                            </td>
                            <td><%= bill.getConsumerNumber() %></td>
                            <td><%= bill.getBillId() %></td>
                            <td><%= bill.getPeriod() %></td>
                            <td><%= bill.getDueDate() %></td>
                            <td>$<%= String.format("%.2f", bill.getAmount() + bill.getLateFee()) %></td>
                            <td class="<%= "Paid".equals(bill.getStatus()) ? "status-paid" : "status-unpaid" %>">
                                <%= bill.getStatus() %>
                            </td>
                            <td>
                                <a href="Bill/billDetails.jsp?billId=<%= bill.getBillId() %>" class="btn btn-view">View</a>
                                <% if (!"Paid".equals(bill.getStatus())) { %>
                                    <a href="Bill/payment.jsp?billId=<%= bill.getBillId() %>" class="btn btn-pay">Pay</a>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
                
                <div style="background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-top: 20px;">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <p>Total Payable Amount: $<span id="totalAmount">0.00</span></p>
                        </div>
                        <div>
                            <button type="submit" id="proceedBtn" class="btn btn-pay" <%= !hasUnpaidBills ? "disabled" : "" %>
                                    style="<%= !hasUnpaidBills ? "opacity: 0.5;" : "" %>">
                                Proceed to Pay
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        <% } %>
    </div>
    
    <script>
        function toggleAll(source) {
            const checkboxes = document.querySelectorAll('input[name="selectedBills"]:not([disabled])');
            for (let i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = source.checked;
            }
            updateTotal();
        }
        
        function updateTotal() {
            let total = 0;
            const checkboxes = document.querySelectorAll('input[name="selectedBills"]:checked');
            checkboxes.forEach(cb => {
                total += parseFloat(cb.getAttribute('data-amount'));
            });
            document.getElementById('totalAmount').innerText = total.toFixed(2);
            document.getElementById('proceedBtn').disabled = checkboxes.length === 0;
            document.getElementById('proceedBtn').style.opacity = checkboxes.length === 0 ? '0.5' : '1';
            
            // Update select all checkbox state
            const allCheckboxes = document.querySelectorAll('input[name="selectedBills"]:not([disabled])');
            const checkedCheckboxes = document.querySelectorAll('input[name="selectedBills"]:checked');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            if (allCheckboxes.length > 0) {
                selectAllCheckbox.checked = allCheckboxes.length === checkedCheckboxes.length;
                selectAllCheckbox.indeterminate = checkedCheckboxes.length > 0 && checkedCheckboxes.length < allCheckboxes.length;
            }
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateTotal();
        });
    </script>
</body>
</html>