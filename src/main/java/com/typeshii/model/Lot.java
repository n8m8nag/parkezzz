package com.typeshii.model;

// lot model - maps to lot table
public class Lot {

    private int lotId;
    private String lotName;
    private int totalSlots;
    private String vehicleType;
    private int occupiedSlots;
    private int reservedSlots;

    public Lot() {}

    public int getLotId() { return lotId; }
    public void setLotId(int lotId) { this.lotId = lotId; }

    public String getLotName() { return lotName; }
    public void setLotName(String lotName) { this.lotName = lotName; }

    public int getTotalSlots() { return totalSlots; }
    public void setTotalSlots(int totalSlots) { this.totalSlots = totalSlots; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public int getOccupiedSlots() { return occupiedSlots; }
    public void setOccupiedSlots(int occupiedSlots) { this.occupiedSlots = occupiedSlots; }

    public int getReservedSlots() { return reservedSlots; }
    public void setReservedSlots(int reservedSlots) { this.reservedSlots = reservedSlots; }
}