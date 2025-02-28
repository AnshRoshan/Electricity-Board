package com.anshroshan.electrictymanagement.dao;

import com.anshroshan.electrictymanagement.models.Bill;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class BillDAO {
    private static final Logger LOGGER = Logger.getLogger(BillDAO.class.getName());

    public String addBill(Bill bill) {
        String sql = "INSERT INTO BILL (BILLID, CONSUMERNUMBER, AMOUNT, PERIOD, BILLDATE, DUEDATE, DISCONNECTION, LATEFEE, STATUS) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING BILLID";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            String billId = "BILL-" + System.currentTimeMillis(); // Simple unique ID generation
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, billId);
                stmt.setLong(2, bill.getConsumerNumber());
                stmt.setDouble(3, bill.getAmount());
                stmt.setString(4, bill.getPeriod());
                stmt.setDate(5, Date.valueOf(bill.getBillDate()));
                stmt.setDate(6, Date.valueOf(bill.getDueDate()));
                stmt.setDate(7, bill.getDisconnection() != null ? Date.valueOf(bill.getDisconnection()) : null);
                stmt.setDouble(8, bill.getLateFee());
                stmt.setString(9, bill.getStatus());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    LOGGER.info("Bill added successfully: " + billId);
                    return rs.getString("BILLID");
                }
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error adding bill: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Bill> getBillsByConsumerNumber(long consumerNumber) {
        String sql = "SELECT * FROM BILL WHERE CONSUMERNUMBER = ? ORDER BY BILLDATE DESC";
        List<Bill> bills = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE").toLocalDate(),
                            rs.getDate("DUEDATE").toLocalDate(),
                            rs.getDate("DISCONNECTION") != null ? rs.getDate("DISCONNECTION").toLocalDate() : null,
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS")
                    );
                    bills.add(bill);
                }
                LOGGER.info("Bills retrieved for consumer: " + consumerNumber);
                return bills;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving bills: " + e.getMessage());
            return bills;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Bill> getBillsByDateRange(long consumerNumber, LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT * FROM BILL WHERE CONSUMERNUMBER = ? AND BILLDATE BETWEEN ? AND ? ORDER BY BILLDATE DESC";
        List<Bill> bills = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                stmt.setDate(2, Date.valueOf(startDate));
                stmt.setDate(3, Date.valueOf(endDate));
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE").toLocalDate(),
                            rs.getDate("DUEDATE").toLocalDate(),
                            rs.getDate("DISCONNECTION") != null ? rs.getDate("DISCONNECTION").toLocalDate() : null,
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS")
                    );
                    bills.add(bill);
                }
                LOGGER.info("Bills retrieved for consumer " + consumerNumber + " between " + startDate + " and " + endDate);
                return bills;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving bills by date range: " + e.getMessage());
            return bills;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public List<Bill> getBillsByStatus(long consumerNumber, String status) {
        String sql = "SELECT * FROM BILL WHERE CONSUMERNUMBER = ? AND STATUS = ? ORDER BY BILLDATE DESC";
        List<Bill> bills = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                stmt.setString(2, status);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE").toLocalDate(),
                            rs.getDate("DUEDATE").toLocalDate(),
                            rs.getDate("DISCONNECTION") != null ? rs.getDate("DISCONNECTION").toLocalDate() : null,
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS")
                    );
                    bills.add(bill);
                }
                LOGGER.info("Bills retrieved for consumer " + consumerNumber + " with status: " + status);
                return bills;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving bills by status: " + e.getMessage());
            return bills;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean isBillUnique(long consumerNumber, String period) {
        String sql = "SELECT COUNT(*) FROM BILL WHERE CONSUMERNUMBER = ? AND PERIOD = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, consumerNumber);
                stmt.setString(2, period);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error checking bill uniqueness: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public Bill getBillById(String billId) {
        String sql = "SELECT * FROM BILL WHERE BILLID = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, billId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Bill bill = new Bill(
                            rs.getString("BILLID"),
                            rs.getLong("CONSUMERNUMBER"),
                            rs.getDouble("AMOUNT"),
                            rs.getString("PERIOD"),
                            rs.getDate("BILLDATE").toLocalDate(),
                            rs.getDate("DUEDATE").toLocalDate(),
                            rs.getDate("DISCONNECTION") != null ? rs.getDate("DISCONNECTION").toLocalDate() : null,
                            rs.getDouble("LATEFEE"),
                            rs.getString("STATUS")
                    );
                    LOGGER.info("Bill retrieved: " + billId);
                    return bill;
                }
                LOGGER.warning("No bill found with ID: " + billId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving bill: " + e.getMessage());
            return null;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }

    public boolean updateBill(Bill bill) {
        String sql = "UPDATE BILL SET AMOUNT = ?, PERIOD = ?, BILLDATE = ?, DUEDATE = ?, DISCONNECTION = ?, LATEFEE = ?, STATUS = ? WHERE BILLID = ?";
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setDouble(1, bill.getAmount());
                stmt.setString(2, bill.getPeriod());
                stmt.setDate(3, Date.valueOf(bill.getBillDate()));
                stmt.setDate(4, Date.valueOf(bill.getDueDate()));
                stmt.setDate(5, bill.getDisconnection() != null ? Date.valueOf(bill.getDisconnection()) : null);
                stmt.setDouble(6, bill.getLateFee());
                stmt.setString(7, bill.getStatus());
                stmt.setString(8, bill.getBillId());
                int rows = stmt.executeUpdate();
                LOGGER.info("Bill updated successfully: " + bill.getBillId());
                return rows > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error updating bill: " + e.getMessage());
            return false;
        } finally {
            DatabaseUtil.closeConnection(conn);
        }
    }
}