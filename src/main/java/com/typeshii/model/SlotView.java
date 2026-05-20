package com.typeshii.model;
//maps slot data to SlotView Object
public class SlotView {

    private int slotNo;
    private int lotId;
    private String label;
    private String style;
    private String cssClass;

    public SlotView() {}

    public int getSlotNo() { return slotNo; }
    public void setSlotNo(int slotNo) { this.slotNo = slotNo; }

    public int getLotId() { return lotId; }
    public void setLotId(int lotId) { this.lotId = lotId; }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }

    public String getStyle() { return style; }
    public void setStyle(String style) { this.style = style; }

    public String getCssClass() { return cssClass; }
    public void setCssClass(String cssClass) { this.cssClass = cssClass; }
}
