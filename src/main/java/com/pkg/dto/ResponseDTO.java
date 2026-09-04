package com.pkg.dto;

import java.sql.Timestamp;

public class ResponseDTO {
    private Long id;
    private Long requestId;
    private Long helperId;
    private String content;
    private boolean isHelpful;
    private Timestamp createdAt;
    
    // Additional fields for display
    private String helperFirstName;
    private String helperLastName;
    private String helperEmail;
    
    public ResponseDTO() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Long getRequestId() { return requestId; }
    public void setRequestId(Long requestId) { this.requestId = requestId; }
    
    public Long getHelperId() { return helperId; }
    public void setHelperId(Long helperId) { this.helperId = helperId; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public boolean isIsHelpful() { return isHelpful; }
    public void setIsHelpful(boolean isHelpful) { this.isHelpful = isHelpful; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getHelperFirstName() { return helperFirstName; }
    public void setHelperFirstName(String helperFirstName) { this.helperFirstName = helperFirstName; }
    
    public String getHelperLastName() { return helperLastName; }
    public void setHelperLastName(String helperLastName) { this.helperLastName = helperLastName; }
    
    public String getHelperEmail() { return helperEmail; }
    public void setHelperEmail(String helperEmail) { this.helperEmail = helperEmail; }
    
    public String getHelperFullName() {
        return helperFirstName + " " + helperLastName;
    }
}