package com.typeshii.controller;

import com.typeshii.model.Record;
import com.typeshii.model.User;
import com.typeshii.model.Vehicle;
import com.typeshii.services.UserService;
import com.typeshii.services.ParkingService;
import com.typeshii.util.SlotCoordinates;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;



// handles all /user/* routes — login, register, slot browsing, logout
public class UserController extends HttpServlet {

    private UserService userService = new UserService();
    private ParkingService parkingService = new ParkingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null) path = "/";

        switch (path) {
            case "/findSlot":
                // load slots for the selected lot and pre-compute the schematic overlay positions
                java.util.List<com.typeshii.model.Lot> allLots = parkingService.getAllLots();
                req.setAttribute("lots", allLots);
                String lotIdParam = req.getParameter("lotId");
                if (lotIdParam != null) {
                    Cookie userLotCookie = new Cookie("userLastLotId", lotIdParam);
                    userLotCookie.setMaxAge(30 * 24 * 60 * 60);
                    userLotCookie.setPath("/");
                    res.addCookie(userLotCookie);
                } else {
                    lotIdParam = getCookieValue(req, "userLastLotId");
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
                req.getRequestDispatcher("/WEB-INF/views/user/findSlot.jsp").forward(req, res);
                break;
            case "/slotDetail":
                // same as findSlot but also loads the selected slot — shows popup on the same page
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
                            Record activeRecord = parkingService.getActiveRecord(slotNo);
                            req.setAttribute("activeRecord", activeRecord);
                            User loggedInUser = (User) req.getSession().getAttribute("loggedInUser");
                            boolean isOwner = loggedInUser != null && activeRecord != null
                                && loggedInUser.getUserId() == activeRecord.getUserId();
                            req.setAttribute("isOwner", isOwner);
                        }
                    }
                }
                req.getRequestDispatcher("/WEB-INF/views/user/findSlot.jsp").forward(req, res);
                break;
            case "/logout":
                req.getSession().invalidate();
                res.sendRedirect(req.getContextPath() + "/index.jsp");
                break;
            default:
                res.sendRedirect(req.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null) path = "/";

        switch (path) {
            case "/login":
                handleLogin(req, res);
                break;
            case "/register":
                handleRegister(req, res);
                break;
            default:
                res.sendRedirect(req.getContextPath() + "/index.jsp");
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

    // look up user by vehicle number and create a session on success
    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String vehicleNo = req.getParameter("vehicleNo");

        if (vehicleNo == null || vehicleNo.trim().isEmpty()) {
            req.setAttribute("error", "Please enter your vehicle number");
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }

        User user = userService.login(vehicleNo.trim());

        if (user == null) {
            req.setAttribute("error", "Vehicle number not found. Please register first.");
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }

        // set session and redirect to slot finder
        req.getSession().setAttribute("loggedInUser", user);
        req.getSession().setAttribute("vehicleNo", vehicleNo.trim().toUpperCase());
        res.sendRedirect(req.getContextPath() + "/user/findSlot");
    }

    // validate fields, run duplicate checks, then insert user + vehicle
    private void handleRegister(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName    = req.getParameter("fullName");
        String id          = req.getParameter("id");
        String phone       = req.getParameter("phone");
        String userType    = req.getParameter("userType");
        String vehicleNo   = req.getParameter("vehicleNo");
        String model       = req.getParameter("model");
        String color       = req.getParameter("color");
        String vehicleType = req.getParameter("vehicleType");

        // basic validation
        if (fullName == null || id == null || phone == null ||
            vehicleNo == null || model == null || color == null || vehicleType == null) {
            req.setAttribute("error", "All fields are required");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // duplicate checks
        if (userService.isIdTaken(id.trim())) {
            req.setAttribute("error", "Student ID already registered");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (userService.isPhoneTaken(phone.trim())) {
            req.setAttribute("error", "Phone number already registered");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (userService.isVehicleNoTaken(vehicleNo.trim())) {
            req.setAttribute("error", "Vehicle number already registered");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // insert user
        User user = new User();
        user.setFullName(fullName.trim());
        user.setId(id.trim());
        user.setPhone(phone.trim());
        user.setUserType(userType != null ? userType : "Student");

        int userId = userService.registerUser(user);

        if (userId == -1) {
            req.setAttribute("error", "Registration failed. Try again.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // insert vehicle
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicleNo(vehicleNo.trim().toUpperCase());
        vehicle.setUserId(userId);
        vehicle.setModel(model.trim());
        vehicle.setColor(color.trim());
        vehicle.setVehicleType(vehicleType);

        userService.registerVehicle(vehicle);

        // redirect to login with success
        req.setAttribute("success", "Registered successfully. Please login.");
        req.getRequestDispatcher("/index.jsp").forward(req, res);
    }
}