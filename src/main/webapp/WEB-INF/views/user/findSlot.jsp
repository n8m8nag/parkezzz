<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Find a Slot - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slotGrid.css">
    <style>
        .slot-box { width: 36px !important; height: 36px !important; font-size: 10px !important; border-width: 1.5px !important; border-radius: 4px !important; }
        .slot-grid { gap: 5px !important; }
        .slot-lane { gap: 4px !important; }
        .slot-grid-lanes { gap: 12px !important; }
        .slot-page-wrapper { padding: 16px 20px !important; }
    </style>
</head>
<body>
<div class="slot-page-wrapper">

    <%-- header --%>
    <div class="slot-header">
        <div>
            <h2>Slot Map</h2>
            <p class="sub">Select a slot to reserve or occupy</p>
        </div>
        <div class="header-right">
            <a href="${pageContext.request.contextPath}/user/logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <%-- lot filter --%>
    <form method="get" action="${pageContext.request.contextPath}/user/findSlot" class="filter-bar">
        <select name="lotId" onchange="this.form.submit()">
            <c:forEach var="lot" items="${lots}">
                <option value="${lot.lotId}"
                    <c:if test="${lot.lotId == selectedLotId}">selected</c:if>>
                    ${lot.lotName}
                </option>
            </c:forEach>
        </select>
    </form>

    <%-- slot schematic --%>
    <c:if test="${not empty schematicImage}">
        <div class="schematic-wrap" style="position:relative;display:inline-block;max-width:100%;margin:16px 0;">
            <img src="${pageContext.request.contextPath}/logo/${schematicImage}"
                 style="display:block;width:100%;max-width:${schematicMaxWidth};height:auto;border-radius:8px;"
                 alt="${selectedLotName}"/>
            <c:forEach var="sv" items="${slotViews}">
                <a href="${pageContext.request.contextPath}/user/slotDetail?slotNo=${sv.slotNo}"
                   style="${sv.style}">${sv.slotNo}</a>
            </c:forEach>
        </div>
    </c:if>

    <%-- grid fallback --%>
    <c:if test="${empty schematicImage && not empty slotViews}">
        <div class="slot-grid">
            <c:forEach var="sv" items="${slotViews}">
                <a href="${pageContext.request.contextPath}/user/slotDetail?slotNo=${sv.slotNo}"
                   class="${sv.cssClass}">${sv.slotNo}</a>
            </c:forEach>
        </div>
    </c:if>

    <%-- legend --%>
    <div class="legend">
        <span class="legend-item"><span class="dot dot-green"></span> Free</span>
        <span class="legend-item"><span class="dot dot-red"></span> Occupied</span>
        <span class="legend-item"><span class="dot dot-yellow"></span> Reserved</span>
    </div>

    <%-- popup for available slot --%>
    <c:if test="${not empty selectedSlot && selectedSlot.slotLabel == 'Available'}">
        <div class="popup-overlay">
            <div class="popup-box">
                <p class="popup-slot-label">Slot ${selectedSlot.slotNo}</p>
                <form method="post" action="${pageContext.request.contextPath}/slot/enter">
                    <input type="hidden" name="slotNo"    value="${selectedSlot.slotNo}"/>
                    <input type="hidden" name="lotId"     value="${selectedSlot.lotId}"/>
                    <input type="hidden" name="vehicleNo" value="${sessionScope.vehicleNo}"/>
                    <input type="hidden" name="userId"    value="${sessionScope.loggedInUser.userId}"/>
                    <label>Vehicle No</label>
                    <p class="popup-value">${sessionScope.vehicleNo}</p>
                    <div class="popup-actions">
                        <button type="submit" class="btn-occupy">Occupy</button>
                        <button type="submit" formaction="${pageContext.request.contextPath}/slot/reserve"
                                class="btn-reserve">Reserve</button>
                    </div>
                </form>
                <a href="${pageContext.request.contextPath}/user/findSlot" class="btn-close">&#x2715;</a>
            </div>
        </div>
    </c:if>

    <%-- popup for occupied/reserved slot --%>
    <c:if test="${not empty selectedSlot && selectedSlot.slotLabel != 'Available' && not empty activeRecord}">
        <div class="popup-overlay">
            <div class="popup-box">
                <p class="popup-slot-label">Slot ${selectedSlot.slotNo}</p>
                <p class="popup-label">Vehicle No</p>
                <p class="popup-value">${activeRecord.vehicleNo}</p>
                <p class="popup-label">Name</p>
                <p class="popup-value">${activeRecord.fullName}</p>
                <p class="popup-label">Phone</p>
                <p class="popup-value">${activeRecord.phone}</p>
                <c:if test="${isOwner}">
                    <form method="post" action="${pageContext.request.contextPath}/slot/exit">
                        <input type="hidden" name="slotNo"    value="${selectedSlot.slotNo}"/>
                        <input type="hidden" name="lotId"     value="${selectedSlot.lotId}"/>
                        <input type="hidden" name="vehicleNo" value="${activeRecord.vehicleNo}"/>
                        <input type="hidden" name="userId"    value="${activeRecord.userId}"/>
                        <button type="submit" class="btn-clear">Clear</button>
                    </form>
                </c:if>
                <a href="${pageContext.request.contextPath}/user/findSlot" class="btn-close">&#x2715;</a>
            </div>
        </div>
    </c:if>

</div>
</body>
</html>
