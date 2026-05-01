package com.typeshii.model;

// vehicle model - maps to vehicle table
public class Vehicle {

    private int vehicleNo;
    private int userId;
    private String model;
    private String color;
    private String vehicleType;

    public Vehicle() {}

    public int getVehicleNo() { return vehicleNo; }
    public void setVehicleNo(int vehicleNo) { this.vehicleNo = vehicleNo; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
}