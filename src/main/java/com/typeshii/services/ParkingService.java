package com.typeshii.services;

import com.typeshii.dao.SlotDAO;
import com.typeshii.dao.LotDAO;
import com.typeshii.dao.RecordDAO;
import com.typeshii.model.Slot;
import com.typeshii.model.Lot;
import com.typeshii.model.Record;
import java.util.List;

// business logic for parking stuff
public class ParkingService {

    private SlotDAO slotDAO = new SlotDAO();
    private LotDAO lotDAO = new LotDAO();
    private RecordDAO recordDAO = new RecordDAO();

    // get all lots for dropdown
    public List<Lot> getAllLots() {
        return lotDAO.getAllLots();
    }

    // get slots for a lot - for slot grid
    public List<Slot> getSlotsByLot(int lotId) {
        return slotDAO.getSlotsByLot(lotId);
    }

    // enter - mark slot occupied and insert record
    public boolean enterSlot(int slotNo, int vehicleNo, int userId) {
        boolean updated = slotDAO.updateSlotLabel(slotNo, "Occupied");
        if (updated) {
            Record record = new Record();
            record.setSlotNo(slotNo);
            record.setVehicleNo(vehicleNo);
            record.setUserId(userId);
            record.setActionType("Enter");
            recordDAO.insertRecord(record);
        }
        return updated;
    }

    // exit - mark slot available and insert exit record
    public boolean exitSlot(int slotNo, int vehicleNo, int userId) {
        boolean updated = slotDAO.updateSlotLabel(slotNo, "Available");
        if (updated) {
            Record record = new Record();
            record.setSlotNo(slotNo);
            record.setVehicleNo(vehicleNo);
            record.setUserId(userId);
            record.setActionType("Exit");
            recordDAO.insertRecord(record);
        }
        return updated;
    }

    // reserve a slot
    public boolean reserveSlot(int slotNo, int vehicleNo, int userId) {
        boolean updated = slotDAO.updateSlotLabel(slotNo, "Reserved");
        if (updated) {
            Record record = new Record();
            record.setSlotNo(slotNo);
            record.setVehicleNo(vehicleNo);
            record.setUserId(userId);
            record.setActionType("Enter");
            recordDAO.insertRecord(record);
        }
        return updated;
    }

    // get who is currently in a slot - for admin popup
    public Record getActiveRecord(int slotNo) {
        return recordDAO.getActiveRecord(slotNo);
    }

    // dashboard stats
    public int[] getDashboardStats() {
        return lotDAO.getDashboardStats();
    }

    // get all records for reports
    public List<Record> getAllRecords() {
        return recordDAO.getAllRecords();
    }
}