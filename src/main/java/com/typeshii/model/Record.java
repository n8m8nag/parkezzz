package com.typeshii.model;

import java.sql.Timestamp;

// record model - maps to record table
public class Record {

    private int recordId;
    private int slotNo;
    private String vehicleNo;
    private int userId;
    private String actionType;
    private Timestamp actionTime;

    // not db columns, just for jsp display
    private String fullName;
    private String phone;
    private String vehicleModel;
    private String color;

    public Record() {}

    public int getRecordId() { return recordId; }
    public void setRecordId(int recordId) { this.recordId = recordId; }

    public int getSlotNo() { return slotNo; }
    public void setSlotNo(int slotNo) { this.slotNo = slotNo; }

    public String getVehicleNo() { return vehicleNo; }
    public void setVehicleNo(String vehicleNo) { this.vehicleNo = vehicleNo; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }

    public Timestamp getActionTime() { return actionTime; }
    public void setActionTime(Timestamp actionTime) { this.actionTime = actionTime; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    // maps action type to a CSS badge class for color-coded display in the reports table
    public String getBadgeClass() {
        if ("Enter".equals(actionType)) return "badge-enter";
        if ("Exit".equals(actionType)) return "badge-exit";
        return "badge-reserve";
    }

    // strips the nanoseconds off the timestamp so it reads cleanly in the UI
    public String getActionTimeStr() {
        return actionTime != null ? actionTime.toString().substring(0, 19) : "—";
    }
}