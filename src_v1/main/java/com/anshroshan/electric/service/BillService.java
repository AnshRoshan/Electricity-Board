package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.BillDAO;
import com.anshroshan.electric.model.Bill;

import java.util.List;

public class BillService {

    private BillDAO billDAO;

    public BillService() {
        this.billDAO = new BillDAO();
    }

    // Add a new bill (US014)
    public void addBill(Bill bill) throws Exception {
        billDAO.addBill(bill);
    }

    // Check if a bill exists for a consumer and period (US014 - Duplicate Prevention)
    public boolean isBillExists(String consumerId, String billingPeriod) throws Exception {
        return billDAO.getBillByConsumerAndPeriod(consumerId, billingPeriod) != null;
    }

    // Get bills by consumer number (US003 - View Bills)
    public List<Bill> getBillsByConsumerNumber(String consumerNumber) throws Exception {
        return billDAO.getBillsByConsumerNumber(consumerNumber);
    }

    // Get bills by IDs (US004 - Bill Summary)
    public List<Bill> getBillsByIds(List<String> billIds) throws Exception {
        return billDAO.getBillsByIds(billIds);
    }

    // Update bill status after payment (US005 - Pay Bill)
    public void updateBillStatus(String[] billIds, String status) throws Exception {
        for (String billId : billIds) {
            Bill bill = billDAO.getBillById(billId);
            if (bill != null) {
                bill.setStatus(status);
                billDAO.updateBill(bill);
            }
        }
    }

    // Get bill history with filters (US006, US015 - Bill History)
    public List<Bill> getBillHistory(String consumerNumber, String periodFilter, String statusFilter) throws Exception {
        return billDAO.getBillHistory(consumerNumber, periodFilter, statusFilter);
    }

    // Get the latest bill for a consumer (US002 - Home Page)
    public Bill getLatestBill(String consumerNumber) throws Exception {
        return billDAO.getLatestBillByConsumerNumber(consumerNumber);
    }
}