<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Users - ParkEZz</title>
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/slotMap" class="sidebar-link">Slot Map</a>
        <p class="sidebar-section">Manage</p>
        <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link active">Users</a>
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
                <h2>Users</h2>
                <p class="sub">Manage Students Accounts</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout">Logout</a>
        </div>

        <%-- search bar --%>
        <form method="get" action="${pageContext.request.contextPath}/admin/users" class="search-bar">
            <input type="text" name="search" placeholder="Search by Vehicle Number..."
                   value="${param.search}"/>
        </form>

        <%-- user list --%>
        <div class="user-list">
            <c:choose>
                <c:when test="${not empty users}">
                    <c:forEach var="user" items="${users}">
                        <div class="user-card">
                            <div class="avatar-circle user-avatar-lg">${user.initials}</div>
                            <div class="user-info">
                                <p class="user-name">${user.fullName}</p>
                                <p class="user-meta">ID: ${user.id} &nbsp;|&nbsp; Ph: ${user.phone}</p>
                            </div>
                            <span class="vehicle-tag">${not empty vehicleMap[user.userId] ? vehicleMap[user.userId] : 'N/A'}</span>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="no-results">No users found.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
