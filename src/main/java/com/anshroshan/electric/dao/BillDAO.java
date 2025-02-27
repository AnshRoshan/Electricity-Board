package com.anshroshan.electric.dao;

import com.anshroshan.electric.model.Bill;
import com.anshroshan.electric.util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public void addBill(Bill bill) throws Exception {
        String sql = "INSERT INTO bills (bill_id, consumer_number, bill_number, billing_period, bill_date, due_date, disconnection_date, bill_amount, late_fee, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bill.getBillId());
            stmt.setString(2, bill.getConsumerNumber());
            stmt.setString(3, bill.getBillNumber());
            stmt.setString(4, bill.getBillingPeriod());
            stmt.setString(5, bill.getBillDate());
            stmt.setString(6, bill.getDueDate());
            stmt.setString(7, bill.getDisconnectionDate());
            stmt.setDouble(8, bill.getBillAmount());
            stmt.setDouble(9, bill.getLateFee());
            stmt.setString(10, bill.getStatus());
            stmt.executeUpdate();
        }
    }

    public Bill getBillByConsumerAndPeriod(String consumerId, String billingPeriod) throws Exception {
        String sql = "SELECT * FROM bills WHERE consumer_number = ? AND billing_period = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerId);
            stmt.setString(2, billingPeriod);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractBillFromResultSet(rs);
            }
            return null;
        }
    }

    public List<Bill> getBillsByConsumerNumber(String consumerNumber) throws Exception {
        String sql = "SELECT b.*, c.mobile_number, c.customer_type FROM bills b " +
                     "JOIN consumers c ON b.consumer_number = c.consumer_id " +
                     "WHERE b.consumer_number = ? ORDER BY b.bill_date DESC";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerNumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bills.add(extractBillFromResultSet(rs));
            }
            return bills;
        }
    }

    public List<Bill> getBillsByIds(List<String> billIds) throws Exception {
        String sql = "SELECT b.*, c.mobile_number, c.customer_type FROM bills b " +
                     "JOIN consumers c ON b.consumer_number = c.consumer_id " +
                     "WHERE b.bill_id IN (" + String.join(",", billIds.stream().map(id -> "?").toArray(String[]::new)) + ")";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < billIds.size(); i++) {
                stmt.setString(i + 1, billIds.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bills.add(extractBillFromResultSet(rs));
            }
            return bills;
        }
    }

    public Bill getBillById(String billId) throws Exception {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, billId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractBillFromResultSet(rs);
            }
            return null;
        }
    }

    public void updateBill(Bill bill) throws Exception {
        String sql = "UPDATE bills SET status = ?, payment_date = ? WHERE bill_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bill.getStatus());
            stmt.setString(2, bill.getPaymentDate());
            stmt.setString(3, bill.getBillId());
            stmt.executeUpdate();
        }
    }

    public List<Bill> getBillHistory(String consumerNumber, String periodFilter, String statusFilter) throws Exception {
        String sql = "SELECT b.*, p.transaction_date FROM bills b " +
                     "LEFT JOIN payments p ON b.bill_id = ANY(string_to_array(p.bill_ids, ',')) " +
                     "WHERE b.consumer_number = ?";
        if (periodFilter != null && !periodFilter.isEmpty()) {
            sql += " AND b.billing_period LIKE ?";
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND b.status = ?";
        }
        sql += " ORDER BY b.billing_period DESC";

        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerNumber);
            int paramIndex = 2;
            if (periodFilter != null && !periodFilter.isEmpty()) {
                stmt.setString(paramIndex++, "%" + periodFilter + "%");
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                stmt.setString(paramIndex, statusFilter);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bills.add(extractBillFromResultSet(rs));
            }
            return bills;
        }
    }

    public Bill getLatestBillByConsumerNumber(String consumerNumber) throws Exception {
        String sql = "SELECT * FROM bills WHERE consumer_number = ? ORDER BY due_date DESC LIMIT 1";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consumerNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractBillFromResultSet(rs);
            }
            return null;
        }
    }

    private Bill extractBillFromResultSet(ResultSet rs) throws Exception {
        Bill bill = new Bill();
        bill.setBillId(rs.getString("bill_id"));
        bill.setConsumerNumber(rs.getString("consumer_number"));
        bill.setBillNumber(rs.getString("bill_number"));
        bill.setBillingPeriod(rs.getString("billing_period"));
        bill.setBillDate(rs.getString("bill_date"));
        bill.setDueDate(rs.getString("due_date"));
        bill.setDisconnectionDate(rs.getString("disconnection_date"));
        bill.setBillAmount(rs.getDouble("bill_amount"));
        bill.setLateFee(rs.getDouble("late_fee"));
        bill.setStatus(rs.getString("status"));
        bill.setPaymentDate(rs.getString("payment_date"));
        return bill;
    }
}