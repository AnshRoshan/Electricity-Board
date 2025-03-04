package com.anshroshan.electric.models;

import java.util.ArrayList;
import java.util.Collections;

public class Customer {
    private String customerId; // VARCHAR(64) PRIMARY KEY
    private String title; // VARCHAR(8) NOT NULL
    private String name; // VARCHAR(64) NOT NULL
    private String address; // VARCHAR(256) NOT NULL
    private long mobile; // BIGINT UNIQUE NOT NULL
    private String email; // VARCHAR(64) NOT NULL UNIQUE
    private String password; // VARCHAR(128) NOT NULL
    private ArrayList<Consumer> ConsumerList;
    private boolean isAdmin;

    // Constructors
    public Customer() {
    }

    public Customer(String customerId, String title, String name, String address, long mobile, String email,
            String password, ArrayList<Consumer> ConsumerList) {
        this.customerId = customerId;
        this.title = title;
        this.name = name;
        this.address = address;
        this.mobile = mobile;
        this.email = email;
        this.password = password;
        this.ConsumerList = ConsumerList;
        this.isAdmin = false;
    }

    public Customer(String customerId, String title, String name, String address, long mobile, String email,
            String password, Consumer consumer) {
        this.customerId = customerId;
        this.title = title;
        this.name = name;
        this.address = address;
        this.mobile = mobile;
        this.email = email;
        this.password = password;
        ArrayList<Consumer> consumers = new ArrayList<Consumer>();
        consumers.add(consumer);
        this.ConsumerList = consumers;
        this.isAdmin = false;
    }

    public ArrayList<Consumer> getConsumerList() {
        return ConsumerList;
    }

    public void setConsumerList(ArrayList<Consumer> consumerList) {
        ConsumerList = consumerList;
    }

    // Getters and Setters
    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getMobile() {
        return mobile;
    }

    public void setMobile(long mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}