package com.typeshii.dao;

import com.typeshii.model.Record;
import com.typeshii.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles all db stuff for record table
public class RecordDAO {

    // insert enter or exit record
    public int insertRecord(Record record) {
        String sql = "INSERT INTO record (slot_no, vehicle_no, user_id, action_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, record.getSlotNo());
            ps.setString(2, record.getVehicleNo());
            ps.setInt(3, record.getUserId());
            ps.setString(4, record.getActionType());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (Exception e) {
            System.err.println("RecordDAO.insertRecord error: " + e.getMessage());
        }
        return -1;
    }

    // get active record for a slot - last enter with no exit yet
    public Record getActiveRecord(int slotNo) {
        String sql =
            "SELECT r.*, u.full_name, u.phone, v.model, v.color " +
            "FROM record r " +
            "JOIN users u ON r.user_id = u.user_id " +
            "JOIN vehicle v ON r.vehicle_no = v.vehicle_no " +
            "WHERE r.slot_no = ? AND r.action_type = 'Enter' " +
            "ORDER BY r.action_time DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, slotNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Record rec = mapRecord(rs);
                rec.setFullName(rs.getString("full_name"));
                rec.setPhone(rs.getString("phone"));
                rec.setVehicleModel(rs.getString("model"));
                rec.setColor(rs.getString("color"));
                return rec;
            }
        } catch (Exception e) {
            System.err.println("RecordDAO.getActiveRecord error: " + e.getMessage());
        }
        return null;
    }

    // get all records - for reports page
    public List<Record> getAllRecords() {
        List<Record> records = new ArrayList<>();
        String sql =
            "SELECT r.*, u.full_name, u.phone, v.model, v.color " +
            "FROM record r " +
            "JOIN users u ON r.user_id = u.user_id " +
            "JOIN vehicle v ON r.vehicle_no = v.vehicle_no " +
            "ORDER BY r.action_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Record rec = mapRecord(rs);
                rec.setFullName(rs.getString("full_name"));
                rec.setPhone(rs.getString("phone"));
                rec.setVehicleModel(rs.getString("model"));
                rec.setColor(rs.getString("color"));
                records.add(rec);
            }
        } catch (Exception e) {
            System.err.println("RecordDAO.getAllRecords error: " + e.getMessage());
        }
        return records;
    }

    // maps resultset row to record object
    private Record mapRecord(ResultSet rs) throws SQLException {
        Record r = new Record();
        r.setRecordId(rs.getInt("record_id"));
        r.setSlotNo(rs.getInt("slot_no"));
        r.setVehicleNo(rs.getString("vehicle_no"));
        r.setUserId(rs.getInt("user_id"));
        r.setActionType(rs.getString("action_type"));
        r.setActionTime(rs.getTimestamp("action_time"));
        return r;
    }
}