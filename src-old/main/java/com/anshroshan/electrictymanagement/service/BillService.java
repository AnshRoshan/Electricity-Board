package com.anshroshan.electrictymanagement.service;

import com.anshroshan.electrictymanagement.dao.BillDAO;
import com.anshroshan.electrictymanagement.dao.ConsumerDAO;
import com.anshroshan.electrictymanagement.models.Bill;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class BillService {
    private static final Logger LOGGER = Logger.getLogger(BillService.class.getName());
    private final BillDAO billDAO;
    private final ConsumerDAO consumerDAO;

    // Constructor injection for DAOs
    public BillService() {
        this.billDAO = new BillDAO();
        this.consumerDAO = new ConsumerDAO();
    }

    // For testing or dependency injection
    public BillService(BillDAO billDAO, ConsumerDAO consumerDAO) {
        this.billDAO = billDAO;
        this.consumerDAO = consumerDAO;
    }

    public String addBill(long consumerNumber, double amount, String period, LocalDate billDate, LocalDate dueDate, LocalDate disconnectionDate, double lateFee) {
        // Validation
        if (consumerDAO.getConsumerByNumber(consumerNumber) == null) {
            LOGGER.warning("Consumer not found: " + consumerNumber);
            throw new IllegalArgumentException("Consumer Number does not exist.");
        }
        if (amount < 0 || lateFee < 0) {
            LOGGER.warning("Invalid amount or late fee: " + amount + ", " + lateFee);
            throw new IllegalArgumentException("Bill Amount and Late Fee must be positive.");
        }
        if (billDate.isAfter(dueDate)) {
            LOGGER.warning("Bill date after due date: " + billDate + ", " + dueDate);
            throw new IllegalArgumentException("Bill Date must be before Due Date.");
        }
        if (disconnectionDate != null && disconnectionDate.isBefore(dueDate)) {
            LOGGER.warning("Disconnection date before due date: " + disconnectionDate + ", " + dueDate);
            throw new IllegalArgumentException("Disconnection Date must be after Due Date.");
        }
        if (!billDAO.isBillUnique(consumerNumber, period)) {
            LOGGER.warning("Duplicate bill for consumer " + consumerNumber + " and period " + period);
            throw new IllegalArgumentException("A bill for this consumer and period already exists.");
        }

        Bill bill = new Bill(null, consumerNumber, amount, period, billDate, dueDate, disconnectionDate, lateFee, "Unpaid");
        String billId = billDAO.addBill(bill);
        if (billId != null) {
            LOGGER.info("Bill added successfully: " + billId);
            return billId;
        } else {
            LOGGER.severe("Failed to add bill for consumer: " + consumerNumber);
            throw new RuntimeException("Failed to add bill.");
        }
    }

    public List<Bill> getBills(long consumerNumber) {
        List<Bill> bills = billDAO.getBillsByConsumerNumber(consumerNumber);
        if (!bills.isEmpty()) {
            LOGGER.info("Bills fetched for consumer: " + consumerNumber);
        } else {
            LOGGER.warning("No bills found for consumer: " + consumerNumber);
        }
        return bills;
    }

    public List<Bill> getBillsByDateRange(long consumerNumber, LocalDate startDate, LocalDate endDate) {
        if (startDate.isAfter(endDate)) {
            LOGGER.warning("Start date after end date: " + startDate + ", " + endDate);
            throw new IllegalArgumentException("Start Date must be before End Date.");
        }
        List<Bill> bills = billDAO.getBillsByDateRange(consumerNumber, startDate, endDate);
        if (!bills.isEmpty()) {
            LOGGER.info("Bills fetched for consumer " + consumerNumber + " between " + startDate + " and " + endDate);
        } else {
            LOGGER.warning("No bills found for consumer " + consumerNumber + " in range " + startDate + " to " + endDate);
        }
        return bills;
    }

    public List<Bill> getBillsByStatus(long consumerNumber, String status) {
        if (!"Paid".equalsIgnoreCase(status) && !"Unpaid".equalsIgnoreCase(status)) {
            LOGGER.warning("Invalid status: " + status);
            throw new IllegalArgumentException("Status must be Paid or Unpaid.");
        }
        List<Bill> bills = billDAO.getBillsByStatus(consumerNumber, status);
        if (!bills.isEmpty()) {
            LOGGER.info("Bills fetched for consumer " + consumerNumber + " with status " + status);
        } else {
            LOGGER.warning("No bills found for consumer " + consumerNumber + " with status " + status);
        }
        return bills;
    }

    public double calculateTotalAmount(List<String> billIds) {
        if (billIds == null || billIds.isEmpty()) {
            LOGGER.warning("No bill IDs provided for total calculation.");
            throw new IllegalArgumentException("No bills selected.");
        }
        double total = 0;
        for (String billId : billIds) {
            Bill bill = getBillById(billId);
            if (bill == null) {
                LOGGER.warning("Bill not found for ID: " + billId);
                throw new IllegalArgumentException("Bill ID " + billId + " not found.");
            }
            if ("Paid".equalsIgnoreCase(bill.getStatus())) {
                LOGGER.warning("Bill already paid: " + billId);
                throw new IllegalArgumentException("Bill " + billId + " is already paid.");
            }
            total += bill.getAmount() + bill.getLateFee();
        }
        LOGGER.info("Total amount calculated: " + total);
        return total;
    }

    public Bill getBillById(String billId) {
        Bill bill = billDAO.getBillById(billId); // Requires new DAO method
        if (bill != null) {
            LOGGER.info("Bill fetched by ID: " + billId);
            return bill;
        } else {
            LOGGER.warning("Bill not found for ID: " + billId);
            return null;
        }
    }

    public void updateBillStatus(String billId, String status) {
        if (!"Paid".equalsIgnoreCase(status) && !"Unpaid".equalsIgnoreCase(status)) {
            LOGGER.warning("Invalid status: " + status);
            throw new IllegalArgumentException("Status must be Paid or Unpaid.");
        }
        Bill bill = getBillById(billId);
        if (bill == null) {
            LOGGER.warning("Bill not found for ID: " + billId);
            throw new IllegalArgumentException("Bill not found.");
        }
        bill.setStatus(status);
        if (billDAO.updateBill(bill)) { // Requires new DAO method
            LOGGER.info("Bill status updated to " + status + " for ID: " + billId);
        } else {
            LOGGER.severe("Failed to update bill status for ID: " + billId);
            throw new RuntimeException("Failed to update bill status.");
        }
    }

    public List<Bill> sortBills(long consumerNumber, String sortBy) {
        List<Bill> bills = getBills(consumerNumber);
        if (bills.isEmpty()) {
            return bills;
        }
        switch (sortBy.toLowerCase()) {
            case "billdate":
                bills = bills.stream()
                        .sorted(Comparator.comparing(Bill::getBillDate))
                        .collect(Collectors.toList());
                break;
            case "duedate":
                bills = bills.stream()
                        .sorted(Comparator.comparing(Bill::getDueDate))
                        .collect(Collectors.toList());
                break;
            case "amount":
                bills = bills.stream()
                        .sorted(Comparator.comparingDouble(b -> b.getAmount() + b.getLateFee()))
                        .collect(Collectors.toList());
                break;
            default:
                LOGGER.warning("Invalid sort criteria: " + sortBy);
                throw new IllegalArgumentException("Sort by must be billdate, duedate, or amount.");
        }
        LOGGER.info("Bills sorted by " + sortBy + " for consumer: " + consumerNumber);
        return bills;
    }

    public Bill getLatestBill(long consumerNumber) {
        List<Bill> bills = getBills(consumerNumber);
        if (bills.isEmpty()) {
            LOGGER.warning("No bills found for consumer: " + consumerNumber);
            return null;
        }
        Bill latest = bills.stream()
                .max(Comparator.comparing(Bill::getBillDate))
                .orElse(null);
        LOGGER.info("Latest bill fetched for consumer: " + consumerNumber);
        return latest;
    }
}