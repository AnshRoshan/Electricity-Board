package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.ConsumerDAO;
import com.anshroshan.electric.models.Consumer;

import java.sql.SQLException;
import java.util.List;

/**
 * Service class for handling consumer-related business logic
 */
public class ConsumerService {

    private final ConsumerDAO consumerDAO;

    public ConsumerService() {
        this.consumerDAO = new ConsumerDAO();
    }

    /**
     * Get all consumers for a customer
     * 
     * @param customerId The customer ID
     * @return List of all consumers for the customer
     * @throws SQLException If a database error occurs
     */
    public List<Consumer> getConsumersByCustomerId(String customerId) throws SQLException {
        return consumerDAO.getConsumersByCustomerId(customerId);
    }

    /**
     * Check if a consumer number already exists
     * 
     * @param consumerNumber The consumer number to check
     * @return true if the consumer number exists, false otherwise
     * @throws SQLException If a database error occurs
     */
    public boolean isConsumerNumberExists(long consumerNumber) throws SQLException {
        return consumerDAO.isConsumerNumberExists(consumerNumber);
    }

    /**
     * Add a new consumer
     * 
     * @param consumer The consumer to add
     * @return true if successful, false otherwise
     * @throws SQLException If a database error occurs
     */
    public boolean addConsumer(Consumerconsumer) throws SQLException {
        return consumerDAO.addConsumer(consumer);
    }
}