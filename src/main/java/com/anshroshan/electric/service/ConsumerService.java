package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.ConsumerDAO;
import com.anshroshan.electric.model.Consumer;

import java.util.List;

public class ConsumerService {

    private ConsumerDAO consumerDAO;

    public ConsumerService() {
        this.consumerDAO = new ConsumerDAO();
    }

    // Add a new consumer (US011)
    public void addConsumer(Consumer consumer) throws Exception {
        consumerDAO.addConsumer(consumer);
    }

    // Check if consumer ID exists (US011, US014, US015, US016)
    public boolean isConsumerIdExists(String consumerId) throws Exception {
        return consumerDAO.getConsumerById(consumerId) != null;
    }

    // Get consumers by customer ID (US011)
    public List<Consumer> getConsumersByCustomerId(String customerId) throws Exception {
        return consumerDAO.getConsumersByCustomerId(customerId);
    }

    // Get consumer by ID (US012)
    public Consumer getConsumerById(String consumerId) throws Exception {
        return consumerDAO.getConsumerById(consumerId);
    }

    // Update consumer details (US012)
    public void updateConsumer(Consumer consumer) throws Exception {
        consumerDAO.updateConsumer(consumer);
    }

    // Soft delete a consumer (US013)
    public void softDeleteConsumer(String consumerId) throws Exception {
        consumerDAO.softDeleteConsumer(consumerId);
    }
}