package com.typeshii.model;

// user model - maps to user table
public class User {

    private int userId;
    private String fullName;
    private String id;        // student id
    private String phone;
    private String userType;  // Student or Staff

    public User() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    // first 2 chars of the name in uppercase — used for the avatar circle in the UI
    public String getInitials() {
        return fullName != null && fullName.length() >= 2
            ? fullName.substring(0, 2).toUpperCase()
            : "??";
    }
}
