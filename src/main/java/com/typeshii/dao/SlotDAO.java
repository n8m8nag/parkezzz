package com.typeshii.dao;

import com.typeshii.model.Slot;
import com.typeshii.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles all db stuff for slot table
public class SlotDAO {

    // get all slots for a lot
    public List<Slot> getSlotsByLot(int lotId) {
        List<Slot> slots = new ArrayList<>();
        String sql = "SELECT * FROM slot WHERE lot_id = ? ORDER BY slot_no";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lotId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                slots.add(mapSlot(rs));
            }
        } catch (Exception e) {
            System.err.println("SlotDAO.getSlotsByLot error: " + e.getMessage());
        }
        return slots;
    }

    // get single slot by id
    public Slot getSlotById(int slotNo) {
        Slot slot = null;
        String sql = "SELECT * FROM slot WHERE slot_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, slotNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                slot = mapSlot(rs);
            }
        } catch (Exception e) {
            System.err.println("SlotDAO.getSlotById error: " + e.getMessage());
        }
        return slot;
    }

    // update slot status - Available, Occupied, Reserved
    public boolean updateSlotLabel(int slotNo, String label) {
        String sql = "UPDATE slot SET slot_label = ? WHERE slot_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, label);
            ps.setInt(2, slotNo);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("SlotDAO.updateSlotLabel error: " + e.getMessage());
        }
        return false;
    }

    // maps resultset row to slot object
    private Slot mapSlot(ResultSet rs) throws SQLException {
        Slot s = new Slot();
        s.setSlotNo(rs.getInt("slot_no"));
        s.setLotId(rs.getInt("lot_id"));
        s.setSlotLabel(rs.getString("slot_label"));
        return s;
    }
}