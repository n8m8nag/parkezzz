<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.typeshii.model.Lot" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - ICK Smart Park</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="dashboard-wrapper">

    <%-- sidebar --%>
    <div class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-title">ICK</span>
            <span class="brand-sub">College Parking</span>
        </div>
        <p class="sidebar-section">Main</p>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/slotMap" class="sidebar-link">Slot Map</a>
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
                <h2>Dashboard</h2>
                <p class="sub">Overview</p>
            </div>
            <span class="admin-badge">Admin</span>
        </div>

        <%-- stat cards --%>
        <%
            int totalSlots = request.getAttribute("totalSlots") != null ?
                (int) request.getAttribute("totalSlots") : 0;
            int occupied = request.getAttribute("occupied") != null ?
                (int) request.getAttribute("occupied") : 0;
            int available = request.getAttribute("available") != null ?
                (int) request.getAttribute("available") : 0;
            int occupiedPercent = totalSlots > 0 ? (occupied * 100 / totalSlots) : 0;
            int availablePercent = totalSlots > 0 ? (available * 100 / totalSlots) : 0;
        %>
        <div class="stat-cards">
            <div class="stat-card">
                <p class="stat-label">Total Slots</p>
                <p class="stat-value white"><%= totalSlots %></p>
                <p class="stat-sub">5 Lots</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">Occupied</p>
                <p class="stat-value red"><%= occupied %></p>
                <p class="stat-sub"><%= occupiedPercent %>% full</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">Available</p>
                <p class="stat-value green"><%= available %></p>
                <p class="stat-sub"><%= availablePercent %>% Free</p>
            </div>
        </div>

        <%-- lot occupancy bars --%>
        <div class="occupancy-section">
            <h3 class="section-title">Lot Occupancy</h3>
            <%
                List<Lot> lots = (List<Lot>) request.getAttribute("lots");
                if (lots != null) {
                    for (Lot lot : lots) {
                        // we dont have per-lot stats yet so just show 0
                        int pct = 0;
                        String barColor = "bar-green";
                        if (pct >= 75) barColor = "bar-red";
                        else if (pct >= 50) barColor = "bar-yellow";
            %>
            <div class="occupancy-row">
                <span class="lot-name"><%= lot.getLotName() %></span>
                <div class="bar-track">
                    <div class="bar-fill <%= barColor %>" style="width: <%= pct %>%"></div>
                </div>
                <span class="lot-pct <%= barColor %>"><%= pct %>%</span>
            </div>
            <%
                    }
                }
            %>
        </div>

        <%-- admin key section --%>
        <div class="key-section">
            <h3 class="section-title">Admin Key</h3>
            <p class="key-display">Current Key: <strong>${adminKey}</strong></p>
            <form method="post" action="${pageContext.request.contextPath}/admin/changeKey" class="key-form">
                <input type="text" name="newKey" placeholder="Enter new admin key" required/>
                <button type="submit" class="btn-blue">Update Key</button>
            </form>
        </div>

    </div>
</div>
</body>
</html>