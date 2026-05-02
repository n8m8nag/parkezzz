package com.typeshii.controller;

import com.typeshii.model.User;
import com.typeshii.model.Vehicle;
import com.typeshii.services.UserService;
import com.typeshii.services.ParkingService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

// handles all user side requests

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
                // load lots and slots for slot finder page
                req.setAttribute("lots", parkingService.getAllLots());
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

    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            req.setAttribute("error", "Please enter your student ID");
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }

        User user = userService.login(id.trim());

        if (user == null) {
            req.setAttribute("error", "Student ID not found. Please register first.");
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }

        // set session and redirect to slot finder
        req.getSession().setAttribute("loggedInUser", user);
        res.sendRedirect(req.getContextPath() + "/user/findSlot");
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName    = req.getParameter("fullName");
        String id          = req.getParameter("id");
        String phone       = req.getParameter("phone");
        String userType    = req.getParameter("userType");
        String model       = req.getParameter("model");
        String color       = req.getParameter("color");
        String vehicleType = req.getParameter("vehicleType");

        // basic validation
        if (fullName == null || id == null || phone == null ||
            model == null || color == null || vehicleType == null) {
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