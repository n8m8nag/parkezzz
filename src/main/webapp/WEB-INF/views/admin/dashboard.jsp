<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout">Logout</a>
        </div>

        <%-- stat cards --%>
        <div class="stat-cards">
            <div class="stat-card">
                <p class="stat-label">Total Slots</p>
                <p class="stat-value white">${totalSlots}</p>
                <p class="stat-sub">5 Lots</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">Occupied</p>
                <p class="stat-value red">${occupied}</p>
                <p class="stat-sub">${occupiedPercent}% full</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">Available</p>
                <p class="stat-value green">${available}</p>
                <p class="stat-sub">${availablePercent}% Free</p>
            </div>
        </div>

        <%-- lot occupancy bars --%>
        <div class="occupancy-section">
            <h3 class="section-title">Lot Occupancy</h3>
            <c:forEach var="lot" items="${lots}">
                <div class="occupancy-row">
                    <span class="lot-name">${lot.lotName}</span>
                    <div class="bar-track">
                        <div class="bar-fill ${lot.barColor}" style="width: ${lot.occupiedPercent}%"></div>
                        <div class="bar-fill" style="width: ${lot.reservedPercent}%; background:#ca8a04;"></div>
                    </div>
                    <span>${lot.totalPercent}%</span>
                </div>
            </c:forEach>
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