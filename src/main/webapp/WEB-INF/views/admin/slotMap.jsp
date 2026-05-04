<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.typeshii.model.Slot" %>
<%@ page import="com.typeshii.model.Lot" %>
<%@ page import="com.typeshii.model.Record" %>
<!DOCTYPE html>
<html>
<head>
    <title>Slot Map - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slotGrid.css">
</head>
<body>
<div class="dashboard-wrapper">

    <%-- sidebar --%>
    <div class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-title">ParkEZz</span>
            <span class="brand-sub">College Parking</span>
        </div>
        <p class="sidebar-section">Main</p>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/slotMap" class="sidebar-link active">Slot Map</a>
        <p class="sidebar-section">Manage</p>
        <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">Users</a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link">Generate Reports</a>
        <div class="sidebar-footer">
            <div class="avatar-circle">AD</div>
            <div>
                <p class="admin-name">Admin</p>
                <p class="admin-role">Administrator</p>
            </div>
        </div>
    </div>

    <%-- main content --%>
    <div class="main-content">
        <div class="page-header">
            <div>
                <h2>Slot Map</h2>
                <p class="sub">Visual Slot editor</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout">Logout</a>
        </div>

        <%-- lot + type filter --%>
        <form method="get" action="${pageContext.request.contextPath}/admin/slotMap" class="filter-bar">
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
                    <option value="<%= lot.getLotId() %>" <%= selected %>>
                        <%= lot.getLotName() %>
                    </option>
                <%
                        }
                    }
                %>
            </select>
        </form>

        <%-- slot grid --%>
        <%
            List<Slot> slots = (List<Slot>) request.getAttribute("slots");

            // resolve selected lot name for lane config
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

            // lane groups per lot: each int[] is one group; 1 element = single lane, 2 = back-to-back pair
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
                    <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
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
                <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
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

        <%-- popup for free slot --%>
        <%
            Slot selectedSlot = (Slot) request.getAttribute("selectedSlot");
            if (selectedSlot != null && "Available".equals(selectedSlot.getSlotLabel())) {
        %>
        <div class="popup-overlay">
            <div class="popup-box">
                <p class="popup-slot-label">Slot <%= selectedSlot.getSlotNo() %></p>
                <form method="post" action="${pageContext.request.contextPath}/slot/enter">
                    <input type="hidden" name="slotNo" value="<%= selectedSlot.getSlotNo() %>"/>
                    <label>Enter Vehicle Number</label>
                    <input type="text" name="vehicleNo" placeholder="Vehicle No" required/>
                    <input type="hidden" name="userId" value="1"/>
                    <div class="popup-actions">
                        <button type="submit" class="btn-occupy">Occupy</button>
                        <button type="submit" formaction="${pageContext.request.contextPath}/slot/reserve"
                                class="btn-reserve">Reserve</button>
                    </div>
                </form>
                <a href="${pageContext.request.contextPath}/admin/slotMap" class="btn-close">✕</a>
            </div>
        </div>
        <%  } %>

        <%-- popup for occupied/reserved slot --%>
        <%
            Record activeRecord = (Record) request.getAttribute("activeRecord");
            if (selectedSlot != null && !"Available".equals(selectedSlot.getSlotLabel())) {
                String dispVehicleNo = activeRecord != null ? activeRecord.getVehicleNo() : "—";
                String dispName      = activeRecord != null && activeRecord.getFullName() != null ? activeRecord.getFullName() : "Unregistered";
                String dispPhone     = activeRecord != null && activeRecord.getPhone() != null ? activeRecord.getPhone() : "—";
                String formVehicleNo = activeRecord != null ? activeRecord.getVehicleNo() : "";
                int    formUserId    = activeRecord != null ? activeRecord.getUserId() : 0;
        %>
        <div class="popup-overlay">
            <div class="popup-box">
                <p class="popup-slot-label">Slot <%= selectedSlot.getSlotNo() %></p>
                <p class="popup-label">Vehicle No</p>
                <p class="popup-value"><%= dispVehicleNo %></p>
                <p class="popup-label">Name</p>
                <p class="popup-value"><%= dispName %></p>
                <p class="popup-label">Phone</p>
                <p class="popup-value"><%= dispPhone %></p>
                <form method="post" action="${pageContext.request.contextPath}/slot/exit">
                    <input type="hidden" name="slotNo" value="<%= selectedSlot.getSlotNo() %>"/>
                    <input type="hidden" name="vehicleNo" value="<%= formVehicleNo %>"/>
                    <input type="hidden" name="userId" value="<%= formUserId %>"/>
                    <button type="submit" class="btn-clear">Clear</button>
                </form>
                <a href="${pageContext.request.contextPath}/admin/slotMap" class="btn-close">✕</a>
            </div>
        </div>
        <% } %>

    </div>
</div>
</body>
</html>