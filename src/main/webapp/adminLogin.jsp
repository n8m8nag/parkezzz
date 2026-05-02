<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - ICK Smart Park</title>
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
                    <span class="logo-ick">ICK</span>
                    <span class="logo-sub">Smart park</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html></html>