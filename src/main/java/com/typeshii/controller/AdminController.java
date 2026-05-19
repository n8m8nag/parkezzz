package com.typeshii.controller;

import com.typeshii.model.Record;
import com.typeshii.model.User;
import com.typeshii.services.ParkingService;
import com.typeshii.services.UserService;
import com.typeshii.util.SlotCoordinates;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;



// handles all /admin/* routes — login, dashboard, slot map, users, reports
public class AdminController extends HttpServlet {

    private ParkingService parkingService = new ParkingService();
    private UserService userService = new UserService();

    // stored in memory — can be changed at runtime via /admin/changeKey
    private static String ADMIN_KEY = "admin123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/login":
                // pull error from session (set after a failed POST) and expose it to the JSP
                String err = (String) req.getSession().getAttribute("error");
                if (err != null) {
                    req.getSession().removeAttribute("error");
                    req.setAttribute("error", err);
                }
                req.getRequestDispatcher("/adminLogin.jsp").forward(req, res);
                break;
            case "/dashboard":
                // load overall stats and per-lot data for the dashboard cards and bars
                int[] stats = parkingService.getDashboardStats();
                int totalSlots = stats[0];
                int occupied   = stats[1];
                int available  = stats[2];
                req.setAttribute("totalSlots",       totalSlots);
                req.setAttribute("occupied",         occupied);
                req.setAttribute("available",        available);
                req.setAttribute("occupiedPercent",  totalSlots > 0 ? (occupied  * 100 / totalSlots) : 0);
                req.setAttribute("availablePercent", totalSlots > 0 ? (available * 100 / totalSlots) : 0);
                req.setAttribute("lots", parkingService.getAllLots());
                req.setAttribute("adminKey", ADMIN_KEY);
                req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
                break;
            case "/slotMap":
                // load slots for the selected lot and pre-compute schematic overlays
                java.util.List<com.typeshii.model.Lot> allLots = parkingService.getAllLots();
                req.setAttribute("lots", allLots);
                String lotIdParam = req.getParameter("lotId");
                if (lotIdParam != null) {
                    Cookie adminLotCookie = new Cookie("adminLastLotId", lotIdParam);
                    adminLotCookie.setMaxAge(30 * 24 * 60 * 60);
                    adminLotCookie.setPath("/");
                    res.addCookie(adminLotCookie);
                } else {
                    lotIdParam = getCookieValue(req, "adminLastLotId");
                    if (lotIdParam == null && !allLots.isEmpty())
                        lotIdParam = String.valueOf(allLots.get(0).getLotId());
                }
                if (lotIdParam != null) {
                    List<com.typeshii.model.Slot> slots = parkingService.getSlotsByLot(Integer.parseInt(lotIdParam));
                    req.setAttribute("slots", slots);
                    req.setAttribute("selectedLotId", lotIdParam);
                    String lotName = resolveLotName(allLots, lotIdParam);
                    req.setAttribute("selectedLotName", lotName);
                    req.setAttribute("slotViews", SlotCoordinates.buildSlotViews(slots, lotName));
                    setSchematicAttrs(req, lotName);
                }
                req.getRequestDispatcher("/WEB-INF/views/admin/slotMap.jsp").forward(req, res);
                break;
            case "/slotDetail":
                // same as slotMap but also loads the selected slot and its active record for the popup
                String slotNoParam = req.getParameter("slotNo");
                if (slotNoParam != null) {
                    int slotNo = Integer.parseInt(slotNoParam);
                    com.typeshii.model.Slot selectedSlot = parkingService.getSlotById(slotNo);
                    req.setAttribute("selectedSlot", selectedSlot);
                    if (selectedSlot != null) {
                        java.util.List<com.typeshii.model.Lot> lotsForDetail = parkingService.getAllLots();
                        req.setAttribute("lots", lotsForDetail);
                        String detailLotId = String.valueOf(selectedSlot.getLotId());
                        List<com.typeshii.model.Slot> detailSlots = parkingService.getSlotsByLot(selectedSlot.getLotId());
                        req.setAttribute("slots", detailSlots);
                        req.setAttribute("selectedLotId", detailLotId);
                        String detailLotName = resolveLotName(lotsForDetail, detailLotId);
                        req.setAttribute("selectedLotName", detailLotName);
                        req.setAttribute("slotViews", SlotCoordinates.buildSlotViews(detailSlots, detailLotName));
                        setSchematicAttrs(req, detailLotName);
                        if (!"Available".equals(selectedSlot.getSlotLabel())) {
                            req.setAttribute("activeRecord", parkingService.getActiveRecord(slotNo));
                        }
                    }
                }
                req.getRequestDispatcher("/WEB-INF/views/admin/slotMap.jsp").forward(req, res);
                break;
            case "/users":
                // if a search term is given, filter by vehicle number; otherwise return all
                String search = req.getParameter("search");
                List<User> users;
                if (search != null && !search.trim().isEmpty()) {
                    users = userService.getUsersByVehicleNo(search.trim());
                } else {
                    users = userService.getAllUsers();
                }
                req.setAttribute("users", users);
                req.setAttribute("vehicleMap", userService.getVehicleNoMap());
                req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, res);
                break;
            case "/reports":
                req.setAttribute("records", parkingService.getAllRecords());
                req.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(req, res);
                break;
            case "/logout":
                req.getSession().invalidate();
                res.sendRedirect(req.getContextPath() + "/admin/login");
                break;
            default:
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/login":
                handleAdminLogin(req, res);
                break;
            case "/changeKey":
                handleChangeKey(req, res);
                break;
            default:
                res.sendRedirect(req.getContextPath() + "/admin/login");
        }
    }

    private String getCookieValue(HttpServletRequest req, String name) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null)
            for (Cookie c : cookies)
                if (name.equals(c.getName())) return c.getValue();
        return null;
    }

    // map a lotId string back to its display name — needed to pick the right coordinate array
    private String resolveLotName(java.util.List<com.typeshii.model.Lot> lots, String lotId) {
        for (com.typeshii.model.Lot l : lots) {
            if (lotId.equals(String.valueOf(l.getLotId()))) return l.getLotName();
        }
        return "";
    }

    // set schematicImage and schematicMaxWidth based on lot name — JSP uses these to render the overlay
    private void setSchematicAttrs(HttpServletRequest req, String lotName) {
        String image = "", maxWidth = "980px";
        if      ("Skill - Motorcycle".equals(lotName))  { image = "schematic_skill_moto.svg";  maxWidth = "980px"; }
        else if ("Skill - Car".equals(lotName))         { image = "schematic_skill_car.svg";   maxWidth = "838px"; }
        else if ("Himal - Motorcycle".equals(lotName))  { image = "schematic_himal_moto.svg";  maxWidth = "1200px"; }
        else if ("Kumari - Motorcycle".equals(lotName)) { image = "schematic_kumari_moto.svg"; maxWidth = "980px"; }
        else if ("Kumari - Car".equals(lotName))        { image = "schematic_kumari_car.svg";  maxWidth = "980px"; }
        req.setAttribute("schematicImage", image);
        req.setAttribute("schematicMaxWidth", maxWidth);
    }

    // validate the admin key and start a session, or bounce back with an error
    private void handleAdminLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String adminKey = req.getParameter("adminKey");
        

        if (adminKey == null || adminKey.trim().isEmpty()) {
            req.getSession().setAttribute("error", "Please enter admin key");
            res.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        if (ADMIN_KEY.equals(adminKey.trim())) {
            req.getSession().setAttribute("loggedInAdmin", "admin");
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            req.getSession().setAttribute("error", "Invalid admin key");
            res.sendRedirect(req.getContextPath() + "/admin/login");
        }
    }

    // update the admin key in memory — no persistence, resets on server restart
    private void handleChangeKey(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String newKey = req.getParameter("newKey");

        if (newKey == null || newKey.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        // update the key in memory
        ADMIN_KEY = newKey.trim();
        res.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}