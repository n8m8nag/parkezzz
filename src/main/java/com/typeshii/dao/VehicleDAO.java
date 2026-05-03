package com.typeshii.dao;

import com.typeshii.model.Vehicle;
import com.typeshii.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // get first vehicle_no per user - bulk fetch for admin users page
    public Map<Integer, String> getVehicleNoMapByUser() {
        Map<Integer, String> map = new HashMap<>();
        String sql = "SELECT user_id, vehicle_no FROM vehicle";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int uid = rs.getInt("user_id");
                if (!map.containsKey(uid)) {
                    map.put(uid, rs.getString("vehicle_no"));
                }
            }
        } catch (Exception e) {
            System.err.println("VehicleDAO.getVehicleNoMapByUser error: " + e.getMessage());
        }
        return map;
    }

    // insert new vehicle
    public int insertVehicle(Vehicle vehicle) {
        String sql = "INSERT INTO vehicle (vehicle_no, user_id, model, color, vehicle_type) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, vehicle.getVehicleNo());
            ps.setInt(2, vehicle.getUserId());
            ps.setString(3, vehicle.getModel());
            ps.setString(4, vehicle.getColor());
            ps.setString(5, vehicle.getVehicleType());
            int rows = ps.executeUpdate();
            if (rows > 0) return 1;
        } catch (Exception e) {
            System.err.println("VehicleDAO.insertVehicle error: " + e.getMessage());
        }
        return -1;
    }

    // maps resultset row to vehicle object
    private Vehicle mapVehicle(ResultSet rs) throws SQLException {
        Vehicle v = new Vehicle();
        v.setVehicleNo(rs.getString("vehicle_no"));
        v.setUserId(rs.getInt("user_id"));
        v.setModel(rs.getString("model"));
        v.setColor(rs.getString("color"));
        v.setVehicleType(rs.getString("vehicle_type"));
        return v;
    }
}