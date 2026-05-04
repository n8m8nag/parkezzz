package com.typeshii.controller;

import com.typeshii.model.User;
import com.typeshii.services.ParkingService;
import com.typeshii.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

// handles all admin side requests

public class AdminController extends HttpServlet {

    private ParkingService parkingService = new ParkingService();
    private UserService userService = new UserService();

    // change this to whatever key you want
    private static String ADMIN_KEY = "admin123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/dashboard":
                int[] stats = parkingService.getDashboardStats();
                req.setAttribute("totalSlots", stats[0]);
                req.setAttribute("occupied",   stats[1]);
                req.setAttribute("available",  stats[2]);
                req.setAttribute("lots", parkingService.getAllLots());
                req.setAttribute("adminKey", ADMIN_KEY);
                req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
                break;
            case "/slotMap":
                java.util.List<com.typeshii.model.Lot> allLots = parkingService.getAllLots();
                req.setAttribute("lots", allLots);
                String lotIdParam = req.getParameter("lotId");
                if (lotIdParam == null && !allLots.isEmpty()) {
                    lotIdParam = String.valueOf(allLots.get(0).getLotId());
                }
                if (lotIdParam != null) {
                    req.setAttribute("slots", parkingService.getSlotsByLot(Integer.parseInt(lotIdParam)));
                    req.setAttribute("selectedLotId", lotIdParam);
                }
                req.getRequestDispatcher("/WEB-INF/views/admin/slotMap.jsp").forward(req, res);
                break;
            case "/slotDetail":
                String slotNoParam = req.getParameter("slotNo");
                if (slotNoParam != null) {
                    int slotNo = Integer.parseInt(slotNoParam);
                    com.typeshii.model.Slot selectedSlot = parkingService.getSlotById(slotNo);
                    req.setAttribute("selectedSlot", selectedSlot);
                    if (selectedSlot != null) {
                        req.setAttribute("lots", parkingService.getAllLots());
                        req.setAttribute("slots", parkingService.getSlotsByLot(selectedSlot.getLotId()));
                        req.setAttribute("selectedLotId", String.valueOf(selectedSlot.getLotId()));
                        if (!"Available".equals(selectedSlot.getSlotLabel())) {
                            req.setAttribute("activeRecord", parkingService.getActiveRecord(slotNo));
                        }
                    }
                }
                req.getRequestDispatcher("/WEB-INF/views/admin/slotMap.jsp").forward(req, res);
                break;
            case "/users":
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
            case "/logout":
                req.getSession().invalidate();
                res.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
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
                res.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
        }
    }

    private void handleAdminLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String adminKey = req.getParameter("adminKey");
        
        // debug - print what we're receiving
        System.out.println("Received key: [" + adminKey + "]");
        System.out.println("Stored key: [" + ADMIN_KEY + "]");
        System.out.println("Match: " + ADMIN_KEY.equals(adminKey != null ? adminKey.trim() : ""));

        if (adminKey == null || adminKey.trim().isEmpty()) {
            req.getSession().setAttribute("error", "Please enter admin key");
            res.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
            return;
        }

        if (ADMIN_KEY.equals(adminKey.trim())) {
            req.getSession().setAttribute("loggedInAdmin", "admin");
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            req.getSession().setAttribute("error", "Invalid admin key");
            res.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
        }
    }

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