<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <div class="auth-left">
            <h2>Sign In</h2>
            <% if (request.getAttribute("error") != null) { %>
                <p class="error-msg">${error}</p>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <p class="success-msg">${success}</p>
            <% } %>
            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <label>Vehicle Number</label>
                <input type="text" name="vehicleNo" placeholder="e.g. BA1PA1234" required/>
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
    <a href="${pageContext.request.contextPath}/register.jsp" class="btn-register">
        Register Your Vehicle
    </a>
    <a href="${pageContext.request.contextPath}/adminLogin.jsp" class="btn-admin">
        Admin Login
    </a>
</div>
</body>
</html>