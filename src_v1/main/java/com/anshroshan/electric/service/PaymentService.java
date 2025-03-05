package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.PaymentDAO;
import com.anshroshan.electric.model.Payment;

public class PaymentService {

    private PaymentDAO paymentDAO;

    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
    }

    // Save a payment (US005)
    public void savePayment(Payment payment) throws Exception {
        paymentDAO.savePayment(payment);
    }
}