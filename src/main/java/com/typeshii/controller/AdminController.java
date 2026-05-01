package com.typeshii.controller;

import com.typeshii.services.ParkingService;
import com.typeshii.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

// handles all admin side requests
@WebServlet("/admin/*")
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
                req.setAttribute("lots", parkingService.getAllLots());
                req.getRequestDispatcher("/WEB-INF/views/admin/slotMap.jsp").forward(req, res);
                break;
            case "/users":
                req.setAttribute("users", userService.getAllUsers());
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

        if (adminKey == null || adminKey.trim().isEmpty()) {
            req.setAttribute("error", "Please enter admin key");
            req.getRequestDispatcher("/adminLogin.jsp").forward(req, res);
            return;
        }

        if (ADMIN_KEY.equals(adminKey.trim())) {
            req.getSession().setAttribute("loggedInAdmin", "admin");
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            req.setAttribute("error", "Invalid admin key");
            req.getRequestDispatcher("/adminLogin.jsp").forward(req, res);
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