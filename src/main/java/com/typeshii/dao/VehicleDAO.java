package com.typeshii.dao;

import com.typeshii.model.Vehicle;
import com.typeshii.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles all db stuff for vehicle table
public class VehicleDAO {

    // find vehicle by plate number - used for login
    public Vehicle getVehicleByPlate(String plateNumber) {
        Vehicle vehicle = null;
        String sql = "SELECT * FROM vehicle WHERE vehicle_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, plateNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                vehicle = mapVehicle(rs);
            }
        } catch (Exception e) {
            System.err.println("VehicleDAO.getVehicleByPlate error: " + e.getMessage());
        }
        return vehicle;
    }

    // get vehicles by user id
    public List<Vehicle> getVehiclesByUser(int userId) {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                vehicles.add(mapVehicle(rs));
            }
        } catch (Exception e) {
            System.err.println("VehicleDAO.getVehiclesByUser error: " + e.getMessage());
        }
        return vehicles;
    }

    // insert new vehicle
    public int insertVehicle(Vehicle vehicle) {
        String sql = "INSERT INTO vehicle (user_id, model, color, vehicle_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, vehicle.getUserId());
            ps.setString(2, vehicle.getModel());
            ps.setString(3, vehicle.getColor());
            ps.setString(4, vehicle.getVehicleType());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (Exception e) {
            System.err.println("VehicleDAO.insertVehicle error: " + e.getMessage());
        }
        return -1;
    }

    // maps resultset row to vehicle object
    private Vehicle mapVehicle(ResultSet rs) throws SQLException {
        Vehicle v = new Vehicle();
        v.setVehicleNo(rs.getInt("vehicle_no"));
        v.setUserId(rs.getInt("user_id"));
        v.setModel(rs.getString("model"));
        v.setColor(rs.getString("color"));
        v.setVehicleType(rs.getString("vehicle_type"));
        return v;
    }
}