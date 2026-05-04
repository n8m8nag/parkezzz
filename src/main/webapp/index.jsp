<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=1.1">
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

            <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="post">
                <label>Vehicle Number</label>
                <input type="text" name="vehicleNo" placeholder="e.g. BA1PA1234" required/>

                <div class="button-container">
                    <div class="button-row">
                        <button type="submit" class="btn-blue">Sign In</button>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn-register">
                            Register Your Vehicle
                        </a>
                    </div>

                    <a href="${pageContext.request.contextPath}/adminLogin.jsp" class="btn-admin">
                        Admin Login
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
