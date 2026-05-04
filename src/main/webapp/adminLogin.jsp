<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String error = (String) session.getAttribute("error");
    if (error != null) session.removeAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=1.1">
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-box">
        <div class="auth-left">
            <h2>Admin Login</h2>

            <% if (error != null) { %>
                <p class="error-msg"><%= error %></p>
            <% } %>

            <form id="adminForm" action="${pageContext.request.contextPath}/admin/login" method="post">
                <label>Admin Key</label>
                <input type="password" name="adminKey" placeholder="Enter Admin Key" required/>

                <div class="button-container">
                    <button type="submit" class="btn-blue full-width">Sign In</button>

                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn-admin full-width">
                        Back to User Login
                    </a>
                </div>
            </form>
        </div>

        <div class="auth-right">
            <div class="logo-container">
                <img src="${pageContext.request.contextPath}/logo/logo.png" alt="ParkEZz Logo" class="main-logo">
            </div>
        </div>
    </div>
</div>

</body>
</html>
