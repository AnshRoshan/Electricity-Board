package com.anshroshan.electric.controller.admin;

import com.anshroshan.electric.model.Consumer;
import com.anshroshan.electric.model.Customer;
import com.anshroshan.electric.service.ConsumerService;
import com.anshroshan.electric.service.CustomerService;
import com.anshroshan.electric.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/add-consumer")
public class ConsumerManagementServlet extends HttpServlet {

    private CustomerService customerService;
    private ConsumerService consumerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
        consumerService = new ConsumerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            String consumerId = request.getParameter("consumerId");
            try {
                Consumer consumer = consumerService.getConsumerById(consumerId);
                if (consumer != null) {
                    Customer customer = customerService.getCustomerById(consumer.getCustomerId());
                    request.setAttribute("consumer", consumer);
                    request.setAttribute("customer", customer);
                    request.setAttribute("consumers", consumerService.getConsumersByCustomerId(consumer.getCustomerId()));
                    request.getRequestDispatcher("/WEB-INF/views/admin/update-consumer.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Consumer not found.");
                    request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error fetching consumer details.");
                request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
            }
        } else {
            String customerId = request.getParameter("customerId");
            if (customerId != null && !customerId.isEmpty()) {
                try {
                    Customer customer = customerService.getCustomerById(customerId);
                    if (customer != null) {
                        request.setAttribute("customer", customer);
                        request.setAttribute("consumers", consumerService.getConsumersByCustomerId(customerId));
                    } else {
                        request.setAttribute("error", "Customer not found. Please add the customer first.");
                    }
                } catch (Exception e) {
                    request.setAttribute("error", "Error fetching customer details.");
                }
            }
            request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            String consumerId = request.getParameter("consumerId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String customerType = request.getParameter("customerType");

            try {
                if (!ValidationUtil.isValidAddress(address)) {
                    request.setAttribute("error", "Address must be at least 10 characters long.");
                    doGet(request, response);
                    return;
                }
                if (!ValidationUtil.isValidMobileNumber(phoneNumber)) {
                    request.setAttribute("error", "Invalid phone number.");
                    doGet(request, response);
                    return;
                }
                if (!ValidationUtil.isValidEmail(email)) {
                    request.setAttribute("error", "Invalid email.");
                    doGet(request, response);
                    return;
                }

                Consumer consumer = consumerService.getConsumerById(consumerId);
                if (consumer == null) {
                    request.setAttribute("error", "Consumer not found.");
                    doGet(request, response);
                    return;
                }

                consumer.setAddress(address);
                consumer.setPhoneNumber(phoneNumber);
                consumer.setEmail(email);
                consumer.setCustomerType(customerType);

                consumerService.updateConsumer(consumer);

                request.setAttribute("success", "Consumer details updated successfully.");
                request.setAttribute("customer", customerService.getCustomerById(consumer.getCustomerId()));
                request.setAttribute("consumers", consumerService.getConsumersByCustomerId(consumer.getCustomerId()));
                request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to update consumer. Please try again.");
                doGet(request, response);
            }
        } else if ("delete".equals(action)) {
            String consumerId = request.getParameter("consumerId");
            try {
                Consumer consumer = consumerService.getConsumerById(consumerId);
                if (consumer != null) {
                    consumerService.softDeleteConsumer(consumerId);
                    request.setAttribute("success", "Consumer deactivated successfully.");
                    request.setAttribute("customer", customerService.getCustomerById(consumer.getCustomerId()));
                    request.setAttribute("consumers", consumerService.getConsumersByCustomerId(consumer.getCustomerId()));
                } else {
                    request.setAttribute("error", "Consumer not found.");
                }
                request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to deactivate consumer. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
            }
        } else {
            // Add new consumer
            String customerId = request.getParameter("customerId");
            String consumerId = request.getParameter("consumerId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String customerType = request.getParameter("customerType");

            try {
                Customer customer = customerService.getCustomerById(customerId);
                if (customer == null) {
                    request.setAttribute("error", "Customer not found. Please add the customer first.");
                    doGet(request, response);
                    return;
                }

                if (!ValidationUtil.isValidConsumerNumber(consumerId) || consumerService.isConsumerIdExists(consumerId)) {
                    request.setAttribute("error", "Invalid or duplicate Consumer ID.");
                    doGet(request, response);
                    return;
                }
                if (!ValidationUtil.isValidAddress(address)) {
                    request.setAttribute("error", "Address must be at least 10 characters long.");
                    doGet(request, response);
                    return;
                }
                if (!ValidationUtil.isValidMobileNumber(phoneNumber)) {
                    request.setAttribute("error", "Invalid phone number.");
                    doGet(request, response);
                    return;
                }
                if (!ValidationUtil.isValidEmail(email)) {
                    request.setAttribute("error", "Invalid email.");
                    doGet(request, response);
                    return;
                }

                Consumer consumer = new Consumer();
                consumer.setConsumerId(consumerId);
                consumer.setCustomerId(customerId);
                consumer.setAddress(address);
                consumer.setPhoneNumber(phoneNumber);
                consumer.setEmail(email);
                consumer.setCustomerType(customerType);

                consumerService.addConsumer(consumer);

                request.setAttribute("success", "Consumer " + consumerId + " linked to " + customer.getFullName() + " successfully.");
                request.setAttribute("customer", customer);
                request.setAttribute("consumers", consumerService.getConsumersByCustomerId(customerId));
                request.getRequestDispatcher("/WEB-INF/views/admin/add-consumer.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to add consumer. Please try again.");
                doGet(request, response);
            }
        }
    }
}