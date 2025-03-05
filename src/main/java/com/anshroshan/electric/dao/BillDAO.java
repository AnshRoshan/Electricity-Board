package com.anshroshan.electric.dao;

import com.anshroshan.electric.models.Bill;
import com.anshroshan.electric.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class BillDAO {

    public Bill getLatestUnpaidBill(String customerId) throws SQLException {
        String query = "SELECT B.BILLID, B.CONSUMERNUMBER, B.AMOUNT, B.PERIOD, B.BILLDATE, " +
                "B.DUEDATE, B.DISCONNECTION, B.LATEFEE, B.STATUS," +
                "C.CONSUMERTYPE, C.STATUS AS CONSUMER_STATUS " +
                "FROM BILL B JOIN CONSUMER C ON B.CONSUMERNUMBER = C.CONSUMERNUMBER " +
                "WHERE C.CUSTOMERID = ? AND B.STATUS = 'Unpaid' " +
                "ORDER BY B.BILLDATE DESC LIMIT 1";
        try (Connection conn = DatabaseUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE"),
                            rs.getDate("DUEDATE"),
                            rs.getDate("DISCONNECTION"),
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS"),
                            rs.getString("CONSUMERTYPE"),
                            rs.getString("CONSUMER_STATUS"));
                }
                return null; // No unpaid bills found
            }
        }
    }

    public List<Bill> getAllBills(String customerId) throws SQLException {
        String query = "SELECT B.BILLID, B.CONSUMERNUMBER, B.AMOUNT, B.PERIOD, B.BILLDATE, " +
                "B.DUEDATE, B.DISCONNECTION, B.LATEFEE, B.STATUS, " +
                "C.CONSUMERTYPE, C.STATUS AS CONSUMER_STATUS " +
                "FROM BILL B JOIN CONSUMER C ON B.CONSUMERNUMBER = C.CONSUMERNUMBER " +
                "WHERE C.CUSTOMERID = ?";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE"),
                            rs.getDate("DUEDATE"),
                            rs.getDate("DISCONNECTION"),
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS"),
                            rs.getString("CONSUMERTYPE"),
                            rs.getString("CONSUMER_STATUS"));
                    bills.add(bill);
                    System.out.println(bill.toString());
                }
                return bills;
            }
        }
    }

    public List<Bill> getAllBillsByConsumerNumber(Long consumerNumber) throws SQLException {
        String query = "SELECT B.BILLID, B.CONSUMERNUMBER, B.AMOUNT, B.PERIOD, B.BILLDATE, " +
                "B.DUEDATE, B.DISCONNECTION, B.LATEFEE, B.STATUS, " +
                "C.CONSUMERTYPE, C.STATUS AS CONSUMER_STATUS " +
                "FROM BILL B JOIN CONSUMER C ON B.CONSUMERNUMBER = C.CONSUMERNUMBER " +
                "WHERE B.CONSUMERNUMBER = ?";

        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setLong(1, consumerNumber);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE"),
                            rs.getDate("DUEDATE"),
                            rs.getDate("DISCONNECTION"),
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS"),
                            rs.getString("CONSUMERTYPE"),
                            rs.getString("CONSUMER_STATUS"));
                    bills.add(bill);
                    // System.out.println(bill.toString()); // Optional for debugging
                }
            }
        }
        return bills;
    }

    public Bill getBillByBillId(String billId) throws SQLException {
        String query = "SELECT B.BILLID, B.CONSUMERNUMBER, B.AMOUNT, B.PERIOD, B.BILLDATE, " +
                "B.DUEDATE, B.DISCONNECTION, B.LATEFEE, B.STATUS, " +
                "C.CONSUMERTYPE, C.STATUS AS CONSUMER_STATUS " +
                "FROM BILL B JOIN CONSUMER C ON B.CONSUMERNUMBER = C.CONSUMERNUMBER " +
                "WHERE B.BILLID = ?";

        try (Connection conn = DatabaseUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, billId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE"),
                            rs.getDate("DUEDATE"),
                            rs.getDate("DISCONNECTION"),
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS"),
                            rs.getString("CONSUMERTYPE"),
                            rs.getString("CONSUMER_STATUS"));
                    return bill;
                }
            }
        }
        return null;
    }

    // New method to update bill status
    public boolean updateBillStatus(String billId, String status, Date paymentDate) throws SQLException {
        String query = "UPDATE BILL SET STATUS = ?, PAYMENTDATE = ? WHERE BILLID = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status); // Set the new status (e.g., "Paid")
            stmt.setString(2, billId); // Identify the bill by BILLID
            stmt.setDate(3, paymentDate); // Identify the bill by BILLID
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("No bill found with BILLID: " + billId);
                return false;
            }
        }
        return true;
    }

    // New method for bill history with date range
    public List<Bill> getBillsByDateRange(String customerId, Date startDate, Date endDate) throws SQLException {
        String query = "SELECT B.BILLID, B.CONSUMERNUMBER, B.AMOUNT, B.PERIOD, B.BILLDATE, " +
                "B.DUEDATE, B.DISCONNECTION, B.LATEFEE, B.STATUS, " +
                "C.CONSUMERTYPE, C.STATUS AS CONSUMERSTATUS, " +
                "P.TRANSACTIONDATE AS PAYMENTDATE " +
                "FROM BILL B " +
                "LEFT JOIN PAYMENT P ON B.BILLID = ANY(P.BILLS) " +
                "JOIN CONSUMER C ON B.CONSUMERNUMBER = C.CONSUMERNUMBER " +
                "WHERE C.CUSTOMERID = ? AND B.BILLDATE BETWEEN ? AND ?";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, customerId);
            stmt.setDate(2, startDate);
            stmt.setDate(3, endDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getString("BILLID"),
                        rs.getLong("CONSUMERNUMBER"),
                        rs.getDouble("AMOUNT"),
                        rs.getString("PERIOD"),
                        rs.getDate("BILLDATE"),
                        rs.getDate("DUEDATE"),
                        rs.getDate("DISCONNECTION"),
                        rs.getDouble("LATEFEE"),
                        rs.getString("STATUS"),
                        rs.getString("CONSUMERTYPE"),
                        rs.getString("CONSUMER_STATUS"),
                        rs.getDate("PAYMENTDATE"));
                bills.add(bill);
            }
            return bills;
        }
    }

    private String generateBillId() {
        return "BILL-" + UUID.randomUUID().toString();
    }

    public String createBill(long consumerNumber, double amount, String period, Date billDate, Date dueDate,
                             Date disconsumerDate, double lateFee) throws SQLException {
        String query = "INSERT INTO BILL ( BILLID , CONSUMERNUMBER , AMOUNT , PERIOD , BILLDATE , DUEDATE , DISCONNECTION , LATEFEE , STATUS ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ? )";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            String billId = generateBillId();
            stmt.setString(1, billId);
            stmt.setLong(2, consumerNumber);
            stmt.setDouble(3, amount);
            stmt.setString(4, period);
            stmt.setDate(5, billDate);
            stmt.setDate(6, dueDate);
            stmt.setDate(7, disconsumerDate);
            stmt.setDouble(8, lateFee);
            stmt.setString(9, "Unpaid");
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("Failed to create bill");
                return null;
            }
            return billId;
        }
    }
}