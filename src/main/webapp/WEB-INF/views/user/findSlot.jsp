<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.typeshii.model.Slot" %>
<%@ page import="com.typeshii.model.Lot" %>
<%@ page import="com.typeshii.model.Record" %>
<%@ page import="com.typeshii.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Find a Slot - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slotGrid.css">
</head>
<body>
<div class="slot-page-wrapper">

    <%-- header --%>
    <div class="slot-header">
        <div>
            <h2>Slot Map</h2>
            <p class="sub">Select a slot to reserve or occupy</p>
        </div>
        <div class="header-right">
            <a href="${pageContext.request.contextPath}/user/logout" class="btn-outline">Logout</a>
        </div>
    </div>

    <%-- lot filter --%>
    <form method="get" action="${pageContext.request.contextPath}/user/findSlot" class="filter-bar">
        <select name="lotId" onchange="this.form.submit()">
            <%
                List<Lot> lots = (List<Lot>) request.getAttribute("lots");
                String selectedLotId = request.getParameter("lotId");
                if (selectedLotId == null) selectedLotId = (String) request.getAttribute("selectedLotId");
                if (lots != null) {
                    for (Lot lot : lots) {
                        String selected = (selectedLotId != null &&
                            selectedLotId.equals(String.valueOf(lot.getLotId()))) ? "selected" : "";
            %>
                <option value="<%= lot.getLotId() %>" <%= selected %>><%= lot.getLotName() %></option>
            <%
                    }
                }
            %>
        </select>
    </form>

    <%-- slot grid --%>
    <%
        List<Slot> slots = (List<Slot>) request.getAttribute("slots");

        String selLotName = "";
        String selLotId = request.getParameter("lotId");
        if (selLotId == null) selLotId = (String) request.getAttribute("selectedLotId");
        if (lots != null && selLotId != null) {
            for (Lot l : lots) {
                if (selLotId.equals(String.valueOf(l.getLotId()))) {
                    selLotName = l.getLotName();
                    break;
                }
            }
        }

        int[][] laneGroups = null;
        if ("Skill - Motorcycle".equals(selLotName)) {
            laneGroups = new int[][]{
                {54},
                {54, 54},
                {54, 54},
                {65},
                {30}
            };
        } else if ("Himal - Motorcycle".equals(selLotName)) {
            laneGroups = new int[][]{
                {15},
                {18, 18},
                {18},
                {3}
            };
        } else if ("Kumari - Car".equals(selLotName)) {
            laneGroups = new int[][]{
                {6},
                {4},
                {1},
                {2},
                {4},
                {12},
                {12}
            };
        } else if ("Kumari - Motorcycle".equals(selLotName)) {
            laneGroups = new int[][]{
                {50, 50},
                {50, 50},
                {50, 50},
                {40},
                {15}
            };
        } else if ("Skill - Car".equals(selLotName)) {
            laneGroups = new int[][]{
                {15, 15},
                {15, 15},
                {8},
                {8},
                {6, 6},
                {8}
            };
        }

        if (slots != null && laneGroups != null) {
    %>
    <div class="slot-grid-lanes">
        <%
            int slotIdx = 0;
            for (int[] group : laneGroups) {
                boolean isPair = group.length == 2;
        %>
        <div class="slot-lane-group <%= isPair ? "slot-lane-pair" : "" %>">
            <%
                for (int laneSize : group) {
            %>
            <div class="slot-lane">
                <%
                    for (int i = 0; i < laneSize && slotIdx < slots.size(); i++, slotIdx++) {
                        Slot slot = slots.get(slotIdx);
                        String label = slot.getSlotLabel();
                        String cssClass = "slot-box ";
                        if ("Occupied".equals(label)) cssClass += "slot-occupied";
                        else if ("Reserved".equals(label)) cssClass += "slot-reserved";
                        else cssClass += "slot-available";
                %>
                <a href="${pageContext.request.contextPath}/user/slotDetail?slotNo=<%= slot.getSlotNo() %>"
                   class="<%= cssClass %>">
                    <%= slot.getSlotNo() %>
                </a>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
        <%
            }
        %>
    </div>
    <%
        } else if (slots != null) {
    %>
    <div class="slot-grid">
        <%
            for (Slot slot : slots) {
                String label = slot.getSlotLabel();
                String cssClass = "slot-box ";
                if ("Occupied".equals(label)) cssClass += "slot-occupied";
                else if ("Reserved".equals(label)) cssClass += "slot-reserved";
                else cssClass += "slot-available";
        %>
            <a href="${pageContext.request.contextPath}/user/slotDetail?slotNo=<%= slot.getSlotNo() %>"
               class="<%= cssClass %>">
                <%= slot.getSlotNo() %>
            </a>
        <%
            }
        %>
    </div>
    <%
        }
    %>

    <%-- legend --%>
    <div class="legend">
        <span class="legend-item"><span class="dot dot-green"></span> Free</span>
        <span class="legend-item"><span class="dot dot-red"></span> Occupied</span>
        <span class="legend-item"><span class="dot dot-yellow"></span> Reserved</span>
    </div>

    <%-- popup for available slot --%>
    <%
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String sessionVehicleNo = (String) session.getAttribute("vehicleNo");
        Slot selectedSlot = (Slot) request.getAttribute("selectedSlot");
        if (selectedSlot != null && "Available".equals(selectedSlot.getSlotLabel())) {
    %>
    <div class="popup-overlay">
        <div class="popup-box">
            <p class="popup-slot-label">Slot <%= selectedSlot.getSlotNo() %></p>
            <form method="post" action="${pageContext.request.contextPath}/slot/enter">
                <input type="hidden" name="slotNo" value="<%= selectedSlot.getSlotNo() %>"/>
                <input type="hidden" name="vehicleNo" value="<%= sessionVehicleNo != null ? sessionVehicleNo : "" %>"/>
                <input type="hidden" name="userId" value="<%= loggedInUser != null ? loggedInUser.getUserId() : 0 %>"/>
                <label>Vehicle No</label>
                <p class="popup-value"><%= sessionVehicleNo != null ? sessionVehicleNo : "" %></p>
                <div class="popup-actions">
                    <button type="submit" class="btn-occupy">Occupy</button>
                    <button type="submit" formaction="${pageContext.request.contextPath}/slot/reserve"
                            class="btn-reserve">Reserve</button>
                </div>
            </form>
            <a href="${pageContext.request.contextPath}/user/findSlot" class="btn-close">✕</a>
        </div>
    </div>
    <% } %>

    <%-- popup for occupied/reserved slot --%>
    <%
        Record activeRecord = (Record) request.getAttribute("activeRecord");
        if (selectedSlot != null && !"Available".equals(selectedSlot.getSlotLabel()) && activeRecord != null) {
    %>
    <div class="popup-overlay">
        <div class="popup-box">
            <p class="popup-slot-label">Slot <%= selectedSlot.getSlotNo() %></p>
            <p class="popup-label">Vehicle No</p>
            <p class="popup-value"><%= activeRecord.getVehicleNo() %></p>
            <p class="popup-label">Name</p>
            <p class="popup-value"><%= activeRecord.getFullName() %></p>
            <p class="popup-label">Phone</p>
            <p class="popup-value"><%= activeRecord.getPhone() %></p>
            <form method="post" action="${pageContext.request.contextPath}/slot/exit">
                <input type="hidden" name="slotNo" value="<%= selectedSlot.getSlotNo() %>"/>
                <input type="hidden" name="vehicleNo" value="<%= activeRecord.getVehicleNo() %>"/>
                <input type="hidden" name="userId" value="<%= activeRecord.getUserId() %>"/>
                <button type="submit" class="btn-clear">Clear</button>
            </form>
            <a href="${pageContext.request.contextPath}/user/findSlot" class="btn-close">✕</a>
        </div>
    </div>
    <% } %>

</div>
</body>
</html>
