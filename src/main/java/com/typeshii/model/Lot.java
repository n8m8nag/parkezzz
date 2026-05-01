package com.typeshii.model;

// lot model - maps to lot table
public class Lot {

    private int lotId;
    private String lotName;
    private int totalSlots;
    private String vehicleType;

    public Lot() {}

    public int getLotId() { return lotId; }
    public void setLotId(int lotId) { this.lotId = lotId; }

    public String getLotName() { return lotName; }
    public void setLotName(String lotName) { this.lotName = lotName; }

    public int getTotalSlots() { return totalSlots; }
    public void setTotalSlots(int totalSlots) { this.totalSlots = totalSlots; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
}