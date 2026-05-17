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

    // avoids division by zero on empty lots
    public int getOccupiedPercent() {
        return totalSlots > 0 ? (occupiedSlots * 100 / totalSlots) : 0;
    }

    public int getReservedPercent() {
        return totalSlots > 0 ? (reservedSlots * 100 / totalSlots) : 0;
    }

    // combined occupied + reserved — used as the total fill width of the progress bar
    public int getTotalPercent() {
        return getOccupiedPercent() + getReservedPercent();
    }

    // red if nearly full, yellow if half full, green otherwise
    public String getBarColor() {
        int total = getTotalPercent();
        if (total >= 75) return "bar-red";
        if (total >= 50) return "bar-yellow";
        return "bar-green";
    }
}