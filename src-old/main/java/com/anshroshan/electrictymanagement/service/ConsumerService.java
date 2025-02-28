package com.anshroshan.electrictymanagement.service;

import com.anshroshan.electrictymanagement.dao.ConsumerDAO;
import com.anshroshan.electrictymanagement.models.Consumer;
import java.util.List;
import java.util.logging.Logger;

public class ConsumerService {
    private static final Logger LOGGER = Logger.getLogger(ConsumerService.class.getName());
    private final ConsumerDAO consumerDAO = new ConsumerDAO();

    public void addConsumer(long consumerNumber, String customerId, String address, String consumerType) {
        if (String.valueOf(consumerNumber).length() != 13) {
            LOGGER.warning("Invalid consumer number: " + consumerNumber);
            throw new IllegalArgumentException("Consumer Number must be 13 digits.");
        }
        if (!consumerDAO.isConsumerNumberUnique(consumerNumber)) {
            LOGGER.warning("Consumer number already exists: " + consumerNumber);
            throw new IllegalArgumentException("Consumer Number already exists.");
        }
        if (address == null || address.trim().isEmpty() || address.length() < 10) {
            LOGGER.warning("Invalid address: " + address);
            throw new IllegalArgumentException("Address is required, minimum 10 characters.");
        }
        if (!"Residential".equalsIgnoreCase(consumerType) && !"Commercial".equalsIgnoreCase(consumerType)) {
            LOGGER.warning("Invalid consumer type: " + consumerType);
            throw new IllegalArgumentException("Customer Type must be Residential or Commercial.");
        }

        Consumer consumer = new Consumer(consumerNumber, customerId, address, consumerType, "Active");
        if (consumerDAO.addConsumer(consumer)) {
            LOGGER.info("Consumer added successfully: " + consumerNumber);
        } else {
            LOGGER.severe("Failed to add consumer: " + consumerNumber);
            throw new RuntimeException("Failed to add consumer.");
        }
    }

    public void updateConsumer(long consumerNumber, String address, String consumerType) {
        Consumer consumer = consumerDAO.getConsumerByNumber(consumerNumber);
        if (consumer == null) {
            LOGGER.warning("Consumer not found: " + consumerNumber);
            throw new IllegalArgumentException("Consumer not found.");
        }
        if (address == null || address.trim().isEmpty() || address.length() < 10) {
            LOGGER.warning("Invalid address: " + address);
            throw new IllegalArgumentException("Address is required, minimum 10 characters.");
        }
        if (!"Residential".equalsIgnoreCase(consumerType) && !"Commercial".equalsIgnoreCase(consumerType)) {
            LOGGER.warning("Invalid consumer type: " + consumerType);
            throw new IllegalArgumentException("Customer Type must be Residential or Commercial.");
        }

        consumer.setAddress(address);
        consumer.setConsumerType(consumerType);
        if (consumerDAO.updateConsumer(consumer)) {
            LOGGER.info("Consumer updated successfully: " + consumerNumber);
        } else {
            LOGGER.severe("Failed to update consumer: " + consumerNumber);
            throw new RuntimeException("Failed to update consumer.");
        }
    }

    public void softDeleteConsumer(long consumerNumber) {
        Consumer consumer = consumerDAO.getConsumerByNumber(consumerNumber);
        if (consumer == null) {
            LOGGER.warning("Consumer not found: " + consumerNumber);
            throw new IllegalArgumentException("Consumer not found.");
        }
        if (consumerDAO.softDeleteConsumer(consumerNumber)) {
            LOGGER.info("Consumer soft-deleted successfully: " + consumerNumber);
        } else {
            LOGGER.severe("Failed to soft-delete consumer: " + consumerNumber);
            throw new RuntimeException("Failed to delete consumer.");
        }
    }

    public List<Consumer> getConsumersByCustomerId(String customerId) {
        List<Consumer> consumers = consumerDAO.getConsumersByCustomerId(customerId);
        if (!consumers.isEmpty()) {
            LOGGER.info("Consumers fetched for customer: " + customerId);
        } else {
            LOGGER.warning("No consumers found for customer: " + customerId);
        }
        return consumers;
    }

    public Consumer getConsumer(long consumerNumber) {
        Consumer consumer = consumerDAO.getConsumerByNumber(consumerNumber);
        if (consumer != null) {
            LOGGER.info("Consumer fetched: " + consumerNumber);
            return consumer;
        } else {
            LOGGER.warning("Consumer not found: " + consumerNumber);
            throw new IllegalArgumentException("Consumer not found.");
        }
    }
}