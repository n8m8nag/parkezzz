<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - ICK Smart Park</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
<div class="register-wrapper">
    <div class="register-box">
        <div class="register-header">
            <div>
                <h2>Register Your Vehicle</h2>
                <p class="register-sub">Personal and vehicle Information</p>
            </div>
            <span class="badge-student">Student</span>
        </div>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error-msg">${error}</p>
        <% } %>
        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div class="register-panels">
                <div class="panel">
                    <h3>Personal Info</h3>
                    <label>Full Name</label>
                    <input type="text" name="fullName" placeholder="Full Name" required/>
                    <label>Student ID</label>
                    <input type="text" name="id" placeholder="Student ID" required/>
                    <label>Phone</label>
                    <input type="text" name="phone" placeholder="Phone Number" required/>
                    <label>User Type</label>
                    <select name="userType">
                        <option value="Student">Student</option>
                        <option value="Staff">Staff</option>
                    </select>
                </div>
                <div class="panel">
                    <h3>Vehicle Info</h3>
                    <label>Vehicle Number</label>
                    <input type="text" name="vehicleNo" placeholder="e.g. BA1PA1234" required/>
                    <label>Model</label>
                    <input type="text" name="model" placeholder="e.g. Honda Dio" required/>
                    <label>Color</label>
                    <input type="text" name="color" placeholder="e.g. Red" required/>
                    <label>Vehicle Type</label>
                    <select name="vehicleType">
                        <option value="Motorcycle">Motorcycle</option>
                        <option value="Car">Car</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn-green">Proceed to find a slot</button>
        </form>
    </div>
</div>
</body>
</html>