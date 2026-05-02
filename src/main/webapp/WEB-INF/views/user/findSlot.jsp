<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.typeshii.model.Slot" %>
<%@ page import="com.typeshii.model.Lot" %>
<!DOCTYPE html>
<html>
<head>
    <title>Find a Slot - ICK Smart Park</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slotGrid.css">
</head>
<body>
<div class="dashboard-wrapper">

    <%-- header --%>
    <div class="slot-header">
        <div>
            <h2>Find a Slot</h2>
            <p class="sub">View Available Parking</p>
        </div>
        <div class="header-right">
            <a href="${pageContext.request.contextPath}/user/logout" class="btn-outline">Logout</a>
        </div>
    </div>

    <%-- filters --%>
    <form method="get" action="${pageContext.request.contextPath}/slot" class="filter-bar">
        <select name="lotId" onchange="this.form.submit()">
            <%
                List<Lot> lots = (List<Lot>) request.getAttribute("lots");
                String selectedLotId = request.getParameter("lotId");
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

        <div class="type-toggle">
            <button type="submit" name="vehicleType" value="Motorcycle"
                class="toggle-btn <%= "Motorcycle".equals(request.getParameter("vehicleType")) ? "active" : "" %>">
                Motorcycle
            </button>
            <button type="submit" name="vehicleType" value="Car"
                class="toggle-btn <%= "Car".equals(request.getParameter("vehicleType")) ? "active" : "" %>">
                Car
            </button>
        </div>
    </form>

    <%-- slot grid --%>
    <div class="slot-grid">
        <%
            List<Slot> slots = (List<Slot>) request.getAttribute("slots");
            if (slots != null) {
                for (Slot slot : slots) {
                    String label = slot.getSlotLabel();
                    String cssClass = "slot-box ";
                    if ("Occupied".equals(label)) cssClass += "slot-occupied";
                    else if ("Reserved".equals(label)) cssClass += "slot-reserved";
                    else cssClass += "slot-available";
        %>
            <div class="<%= cssClass %>">
                <%= slot.getSlotNo() %>
            </div>
        <%
                }
            }
        %>
    </div>

    <%-- legend --%>
    <div class="legend">
        <span class="legend-item"><span class="dot dot-green"></span> Free</span>
        <span class="legend-item"><span class="dot dot-red"></span> Occupied</span>
        <span class="legend-item"><span class="dot dot-yellow"></span> Reserved</span>
    </div>

</div>
</body>
</html>