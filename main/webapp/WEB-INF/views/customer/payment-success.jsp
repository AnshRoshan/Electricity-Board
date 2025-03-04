<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Payment Successful</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }

            .success-container {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .success-header {
                text-align: center;
                margin-bottom: 20px;
            }

            .success-icon {
                font-size: 48px;
                color: #4CAF50;
                margin-bottom: 10px;
            }

            .success-message {
                margin-bottom: 30px;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 4px;
            }

            .transaction-details {
                margin-bottom: 30px;
            }

            .transaction-details table {
                width: 100%;
                border-collapse: collapse;
            }

            .transaction-details th,
            .transaction-details td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .transaction-details th {
                width: 40%;
                background-color: #f2f2f2;
            }

            .btn {
                display: inline-block;
                padding: 10px 15px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }

            .btn-home {
                background-color: #2196F3;
            }
        </style>
    </head>

    <body>
        <div class="success-container">
            <div class="success-header">
                <div class="success-icon">✓</div>
                <h1>Payment Successful</h1>
            </div>

            <div class="success-message">
                <p>Your payment has been processed successfully. Thank you for your payment!</p>
            </div>

            <div class="transaction-details">
                <h2>Transaction Details</h2>
                <table>
                    <tr>
                        <th>Transaction ID:</th>
                        <td>
                            <%= request.getAttribute("transactionId") %>
                        </td>
                    </tr>
                    <tr>
                        <th>Date:</th>
                        <td>
                            <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()) %>
                        </td>
                    </tr>
                    <tr>
                        <th>Status:</th>
                        <td>Completed</td>
                    </tr>
                </table>
            </div>

            <div style="text-align: center;">
                <a href="<%= request.getContextPath() %>/view-bills" class="btn">View Bills</a>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-home">Go to Dashboard</a>
            </div>
        </div>
    </body>

    </html>