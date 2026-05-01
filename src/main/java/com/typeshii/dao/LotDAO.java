package com.typeshii.dao;

import com.typeshii.model.Lot;
import com.typeshii.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles all db stuff for lot table
public class LotDAO {

    // get all lots - for dropdown in findSlot page
    public List<Lot> getAllLots() {
        List<Lot> lots = new ArrayList<>();
        String sql = "SELECT * FROM lot ORDER BY lot_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lots.add(mapLot(rs));
            }
        } catch (Exception e) {
            System.err.println("LotDAO.getAllLots error: " + e.getMessage());
        }
        return lots;
    }

    // get lot by id
    public Lot getLotById(int lotId) {
        Lot lot = null;
        String sql = "SELECT * FROM lot WHERE lot_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lotId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lot = mapLot(rs);
            }
        } catch (Exception e) {
            System.err.println("LotDAO.getLotById error: " + e.getMessage());
        }
        return lot;
    }

    // dashboard stats - total, occupied, available per lot
    public int[] getDashboardStats() {
        String sql =
            "SELECT " +
            "(SELECT COUNT(*) FROM slot) AS total, " +
            "(SELECT COUNT(*) FROM slot WHERE slot_label = 'Occupied') AS occupied, " +
            "(SELECT COUNT(*) FROM slot WHERE slot_label = 'Available') AS available";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new int[]{
                    rs.getInt("total"),
                    rs.getInt("occupied"),
                    rs.getInt("available")
                };
            }
        } catch (Exception e) {
            System.err.println("LotDAO.getDashboardStats error: " + e.getMessage());
        }
        return new int[]{0, 0, 0};
    }

    // maps resultset row to lot object
    private Lot mapLot(ResultSet rs) throws SQLException {
        Lot l = new Lot();
        l.setLotId(rs.getInt("lot_id"));
        l.setLotName(rs.getString("lot_name"));
        l.setTotalSlots(rs.getInt("total_slots"));
        l.setVehicleType(rs.getString("vehicle_type"));
        return l;
    }
}