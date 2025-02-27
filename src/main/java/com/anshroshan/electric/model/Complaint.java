package com.anshroshan.electric.model;

public class Complaint {
    private String complaintId;     // Unique identifier for the complaint
    private String consumerNumber;  // Consumer ID linked to the complaint
    private String complaintType;   // e.g., "billing_issue", "power_outage"
    private String category;        // Specific category based on type
    private String description;     // Details of the complaint
    private String contactMethod;   // "email" or "phone"
    private String contactDetails;  // Contact info for resolution
    private String status;          // "Pending", "In Progress", "Resolved", "Closed"
    private String submissionDate;  // Date complaint was submitted
    private String lastUpdatedDate; // Last update timestamp (for admin)
    private String notes;           // Optional admin notes

    // Default constructor
    public Complaint() {}

    // Getters and Setters
    public String getComplaintId() { return complaintId; }
    public void setComplaintId(String complaintId) { this.complaintId = complaintId; }

    public String getConsumerNumber() { return consumerNumber; }
    public void setConsumerNumber(String consumerNumber) { this.consumerNumber = consumerNumber; }

    public String getComplaintType() { return complaintType; }
    public void setComplaintType(String complaintType) { this.complaintType = complaintType; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContactMethod() { return contactMethod; }
    public void setContactMethod(String contactMethod) { this.contactMethod = contactMethod; }

    public String getContactDetails() { return contactDetails; }
    public void setContactDetails(String contactDetails) { this.contactDetails = contactDetails; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getSubmissionDate() { return submissionDate; }
    public void setSubmissionDate(String submissionDate) { this.submissionDate = submissionDate; }

    public String getLastUpdatedDate() { return lastUpdatedDate; }
    public void setLastUpdatedDate(String lastUpdatedDate) { this.lastUpdatedDate = lastUpdatedDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}