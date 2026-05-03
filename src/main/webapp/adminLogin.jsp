<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <div class="auth-left">
            <h2>Admin Login</h2>
            <% if (request.getAttribute("error") != null) { %>
                <p class="error-msg">${error}</p>
            <% } %>
            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <label>Admin Key</label>
                <input type="password" name="adminKey" placeholder="Enter Admin Key" required/>
                <button type="submit" class="btn-blue">Sign In</button>
            </form>
        </div>
        <div class="auth-right">
            <div class="logo-box">
                <div class="logo-icon">P</div>
                <div class="logo-text">
                    <span class="logo-ick">Park</span>
                    <span class="logo-sub">EZz</span>
                </div>
            </div>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn-admin">
        Back to User Login
    </a>
</div>
</body>
</html>
<%
    String error = (String) session.getAttribute("error");
    if (error != null) {
        session.removeAttribute("error");
%>
    <p class="error-msg"><%= error %></p>
<% } %>