package com.anshroshan.electrictymanagement.models;

import java.time.LocalDate;

public class Complaint {
    private String complaintId;    // VARCHAR(64) PRIMARY KEY
    private long consumerNumber;   // BIGINT NOT NULL, FK to CONSUMER
    private String customerId;     // VARCHAR(64) NOT NULL, FK to CUSTOMER
    private String compType;       // VARCHAR(64)
    private String category;       // VARCHAR(64)
    private String description;    // VARCHAR(1024)
    private String contactMethod;  // VARCHAR(64)
    private String contact;        // VARCHAR(128)
    private String status;         // VARCHAR(64)
    private LocalDate submissionDate; // DATE
    private LocalDate lastUpdate;  // DATE
    private String note;           // VARCHAR(1024)

    // Default constructor
    public Complaint() {}

    // Parameterized constructor
    public Complaint(String complaintId, long consumerNumber, String customerId, String compType, String category,
                     String description, String contactMethod, String contact, String status, LocalDate submissionDate,
                     LocalDate lastUpdate, String note) {
        this.complaintId = complaintId;
        this.consumerNumber = consumerNumber;
        this.customerId = customerId;
        this.compType = compType;
        this.category = category;
        this.description = description;
        this.contactMethod = contactMethod;
        this.contact = contact;
        this.status = status;
        this.submissionDate = submissionDate;
        this.lastUpdate = lastUpdate;
        this.note = note;
    }

    // Getters and Setters
    public String getComplaintId() { return complaintId; }
    public void setComplaintId(String complaintId) { this.complaintId = complaintId; }

    public long getConsumerNumber() { return consumerNumber; }
    public void setConsumerNumber(long consumerNumber) { this.consumerNumber = consumerNumber; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getCompType() { return compType; }
    public void setCompType(String compType) { this.compType = compType; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContactMethod() { return contactMethod; }
    public void setContactMethod(String contactMethod) { this.contactMethod = contactMethod; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDate getSubmissionDate() { return submissionDate; }
    public void setSubmissionDate(LocalDate submissionDate) { this.submissionDate = submissionDate; }

    public LocalDate getLastUpdate() { return lastUpdate; }
    public void setLastUpdate(LocalDate lastUpdate) { this.lastUpdate = lastUpdate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    @Override
    public String toString() {
        return "Complaint{" +
                "complaintId='" + complaintId + '\'' +
                ", consumerNumber=" + consumerNumber +
                ", customerId='" + customerId + '\'' +
                ", compType='" + compType + '\'' +
                ", category='" + category + '\'' +
                ", description='" + description + '\'' +
                ", contactMethod='" + contactMethod + '\'' +
                ", contact='" + contact + '\'' +
                ", status='" + status + '\'' +
                ", submissionDate=" + submissionDate +
                ", lastUpdate=" + lastUpdate +
                ", note='" + note + '\'' +
                '}';
    }
}