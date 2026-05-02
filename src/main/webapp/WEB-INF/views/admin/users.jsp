<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.typeshii.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Users - ICK Smart Park</title>
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
            <span class="admin-badge">Admin</span>
        </div>

        <%-- search bar --%>
        <form method="get" action="${pageContext.request.contextPath}/admin/users" class="search-bar">
            <input type="text" name="search" placeholder="Search by Student ID..."
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"/>
        </form>

        <%-- user list --%>
        <div class="user-list">
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null) {
                    for (User user : users) {
                        String initials = user.getFullName().length() >= 2 ?
                            user.getFullName().substring(0, 2).toUpperCase() : "??";
                        String statusClass = "badge-active";
            %>
            <div class="user-card">
                <div class="user-avatar"><%= initials %></div>
                <div class="user-info">
                    <p class="user-name"><%= user.getFullName() %></p>
                    <p class="user-meta">ID: <%= user.getId() %> &nbsp;|&nbsp; Ph: <%= user.getPhone() %></p>
                </div>
                <span class="status-badge <%= statusClass %>">Active</span>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</div>
</body>
</html>