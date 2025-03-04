package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.BillDAO;
import com.anshroshan.electric.models.Bill;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for handling bill-related business logic
 */
public class BillService {

    private final BillDAO billDAO;

    public BillService() {
        this.billDAO = new BillDAO();
    }

    /**
     * Get the latest unpaid bill for a customer
     * 
     * @param customerId The customer ID
     * @return The latest unpaid bill, or null if none exists
     * @throws SQLException If a database error occurs
     */
    public Bill getLatestUnpaidBill(String customerId) throws SQLException {
        return billDAO.getLatestUnpaidBill(customerId);
    }

    /**
     * Get all bills for a customer
     * 
     * @param customerId The customer ID
     * @return List of all bills for the customer
     * @throws SQLException If a database error occurs
     */
    public List<Bill> getAllBills(String customerId) throws SQLException {
        return billDAO.getAllBills(customerId);
    }

    /**
     * Get all bills for a specific consumer number
     * 
     * @param consumerNumber The consumer number
     * @return List of all bills for the consumer
     * @throws SQLException If a database error occurs
     */
    public List<Bill> getAllBillsByConsumerNumber(Long consumerNumber) throws SQLException {
        return billDAO.getAllBillsByConsumerNumber(consumerNumber);
    }

    /**
     * Get a bill by its ID
     * 
     * @param billId The bill ID
     * @return The bill if found, null otherwise
     * @throws SQLException If a database error occurs
     */
    public Bill getBillByBillId(String billId) throws SQLException {
        return billDAO.getBillByBillId(billId);
    }

    /**
     * Create a new bill
     * 
     * @param consumerNumber  The consumer number
     * @param amount          The bill amount
     * @param period          The billing period
     * @param billDate        The bill date
     * @param dueDate         The due date
     * @param disconsumerDate The disconsumer date
     * @param lateFee         The late fee
     * @return The created bill ID
     * @throws SQLException If a database error occurs
     */
    public String createBill(long consumerNumber, double amount, String period,
            Date billDate, Date dueDate, Date disconsumerDate,
            double lateFee) throws SQLException {
        return billDAO.createBill(consumerNumber, amount, period, billDate, dueDate,
                disconsumerDate, lateFee);
    }

    /**
     * Update a bill's status
     * 
     * @param billId      The bill ID
     * @param status      The new status
     * @param paymentDate The payment date (if paid)
     * @return true if successful, false otherwise
     * @throws SQLException If a database error occurs
     */
    public boolean updateBillStatus(String billId, String status, Date paymentDate) throws SQLException {
        return billDAO.updateBillStatus(billId, status, paymentDate);
    }

    /**
     * Get bills by date range for a customer
     * 
     * @param customerId The customer ID
     * @param startDate  The start date
     * @param endDate    The end date
     * @return List of bills within the date range
     * @throws SQLException If a database error occurs
     */
    public List<Bill> getBillsByDateRange(String customerId, Date startDate, Date endDate) throws SQLException {
        return billDAO.getBillsByDateRange(customerId, startDate, endDate);
    }

    public List<Bill> getBillsByBillIds(String[] billIds) {
        if (billIds == null || billIds.length == 0) {
            return new ArrayList<>(); // Return empty list if input is null or empty
        }
        List<Bill> bills = new ArrayList<>();
        try {
            for (String billId : billIds) {
                Bill billList = getBillByBillId(billId);
                bills.addAll(billList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bills;
    }
}