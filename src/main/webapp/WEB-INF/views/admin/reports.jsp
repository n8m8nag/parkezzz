<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .report-wrap { background:#0f172a; border:1px solid #1e293b; border-radius:10px; overflow:hidden; margin-top:8px; }
        .report-table { width:100%; border-collapse:collapse; }
        .report-table th { background:#1e293b; color:#94a3b8; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:.05em; padding:10px 14px; text-align:left; }
        .report-table td { padding:10px 14px; font-size:13px; border-bottom:1px solid #1e293b; color:#e2e8f0; }
        .report-table tr:hover td { background:#1e293b55; }
        .badge { display:inline-block; padding:2px 10px; border-radius:20px; font-size:11px; font-weight:600; }
        .badge-enter   { background:#14532d33; color:#4ade80; border:1px solid #16a34a55; }
        .badge-exit    { background:#7f1d1d33; color:#f87171; border:1px solid #dc262655; }
        .badge-reserve { background:#78350f33; color:#fbbf24; border:1px solid #ca8a0455; }
        .no-records { color:#64748b; text-align:center; padding:40px 0; font-size:14px; }
    </style>
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
        <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">Users</a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link active">Generate Reports</a>
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
                <h2>Reports</h2>
                <p class="sub">Full parking activity log</p>
            </div>
            <div style="display:flex;gap:10px;align-items:center;">
                <button onclick="printTable()" class="btn-blue">Print / Export</button>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout">Logout</a>
            </div>
        </div>

        <div class="report-wrap">
        <c:choose>
            <c:when test="${empty records}">
                <p class="no-records">No records found.</p>
            </c:when>
            <c:otherwise>
                <table class="report-table" id="reportTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Slot</th>
                            <th>Vehicle No</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Model</th>
                            <th>Color</th>
                            <th>Action</th>
                            <th>Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="rec" items="${records}">
                            <tr>
                                <td>${rec.recordId}</td>
                                <td>${rec.slotNo}</td>
                                <td>${rec.vehicleNo}</td>
                                <td>${empty rec.fullName ? '—' : rec.fullName}</td>
                                <td>${empty rec.phone ? '—' : rec.phone}</td>
                                <td>${empty rec.vehicleModel ? '—' : rec.vehicleModel}</td>
                                <td>${empty rec.color ? '—' : rec.color}</td>
                                <td><span class="badge ${rec.badgeClass}">${rec.actionType}</span></td>
                                <td>${rec.actionTimeStr}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
        </div>
    </div>
</div>
<script>
function printTable() {
    var tbl = document.getElementById('reportTable');
    if (!tbl) return;
    var win = window.open('', '_blank');
    win.document.write('<html><head><title>ParkEZz Report</title>');
    win.document.write('<style>body{font-family:sans-serif;font-size:12px;}table{border-collapse:collapse;width:100%;}th,td{border:1px solid #ccc;padding:6px 10px;text-align:left;}th{background:#f1f5f9;}tr:nth-child(even){background:#f8fafc;}</style>');
    win.document.write('</head><body>');
    win.document.write('<h2>ParkEZz - Parking Activity Report</h2>');
    win.document.write(tbl.outerHTML);
    win.document.write('</body></html>');
    win.document.close();
    win.print();
}
</script>
</body>
</html>
