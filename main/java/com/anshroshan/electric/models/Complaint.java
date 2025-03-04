package com.anshroshan.electric.models;

import java.util.Date;

public class Complaint {
    private String complaintId;
    private long consumerNumber;
    private String customerId;
    private String compType;
    private String category;
    private String description;
    private String contactMethod;
    private String contact;
    private String status;
    private Date submissionDate;
    private Date lastUpdate;
    private String note;
    private Date resolutionDate;
    private String resolutionDetails;
    private int estimatedResolutionTime;

    // Constructors
    public Complaint() {
    }

    // Getters and Setters
    public String getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(String complaintId) {
        this.complaintId = complaintId;
    }

    public long getConsumerNumber() {
        return consumerNumber;
    }

    public void setConsumerNumber(long consumerNumber) {
        this.consumerNumber = consumerNumber;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getCompType() {
        return compType;
    }

    public void setCompType(String compType) {
        this.compType = compType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContactMethod() {
        return contactMethod;
    }

    public void setContactMethod(String contactMethod) {
        this.contactMethod = contactMethod;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(Date submissionDate) {
        this.submissionDate = submissionDate;
    }

    public Date getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getResolutionDate() {
        return resolutionDate;
    }

    public void setResolutionDate(Date resolutionDate) {
        this.resolutionDate = resolutionDate;
    }

    public String getResolutionDetails() {
        return resolutionDetails;
    }

    public void setResolutionDetails(String resolutionDetails) {
        this.resolutionDetails = resolutionDetails;
    }

    public int getEstimatedResolutionTime() {
        return estimatedResolutionTime;
    }

    public void setEstimatedResolutionTime(int estimatedResolutionTime) {
        this.estimatedResolutionTime = estimatedResolutionTime;
    }

    // Helper method for JSP pages
    public Date getLastUpdateDate() {
        return lastUpdate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdate = lastUpdateDate;
    }
}