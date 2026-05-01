package com.typeshii.model;

// slot model - maps to slot table
public class Slot {

    private int slotNo;
    private int lotId;
    private String slotLabel;

    public Slot() {}

    public int getSlotNo() { return slotNo; }
    public void setSlotNo(int slotNo) { this.slotNo = slotNo; }

    public int getLotId() { return lotId; }
    public void setLotId(int lotId) { this.lotId = lotId; }

    public String getSlotLabel() { return slotLabel; }
    public void setSlotLabel(String slotLabel) { this.slotLabel = slotLabel; }
}