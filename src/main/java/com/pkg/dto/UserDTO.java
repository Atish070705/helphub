package com.pkg.dto;

import java.sql.Timestamp;

public class UserDTO {
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phone;
    private String city;
    private int karmaPoints;
    private Timestamp createdAt;
    private boolean enabled;
    
    // Statistics fields
    private int totalRequests;
    private int totalResponses;
    private int helpfulResponses;
    
    // Constructors
    public UserDTO() {}
    
    public UserDTO(Long id, String firstName, String lastName, String email, 
                   String phone, String city, int karmaPoints) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.city = city;
        this.karmaPoints = karmaPoints;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public int getKarmaPoints() { return karmaPoints; }
    public void setKarmaPoints(int karmaPoints) { this.karmaPoints = karmaPoints; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public boolean isEnabled() { return enabled; }
    public void setEnabled(boolean enabled) { this.enabled = enabled; }
    
    public int getTotalRequests() { return totalRequests; }
    public void setTotalRequests(int totalRequests) { this.totalRequests = totalRequests; }
    
    public int getTotalResponses() { return totalResponses; }
    public void setTotalResponses(int totalResponses) { this.totalResponses = totalResponses; }
    
    public int getHelpfulResponses() { return helpfulResponses; }
    public void setHelpfulResponses(int helpfulResponses) { this.helpfulResponses = helpfulResponses; }
    
    public String getFullName() {
        return firstName + " " + lastName;
    }
}
