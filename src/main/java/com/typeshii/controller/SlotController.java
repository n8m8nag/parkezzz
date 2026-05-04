package com.typeshii.controller;

import com.typeshii.model.Slot;
import com.typeshii.services.ParkingService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

// handles slot operations - occupy reserve exit

public class SlotController extends HttpServlet {

    private ParkingService parkingService = new ParkingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String lotIdParam = req.getParameter("lotId");

        if (lotIdParam == null) {
            res.sendError(400, "lotId required");
            return;
        }

        int lotId = Integer.parseInt(lotIdParam);
        List<Slot> slots = parkingService.getSlotsByLot(lotId);
        req.setAttribute("slots", slots);
        req.getRequestDispatcher("/WEB-INF/views/user/findSlot.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        int slotNo       = Integer.parseInt(req.getParameter("slotNo"));
        String vehicleNo = req.getParameter("vehicleNo");
        if (vehicleNo == null) vehicleNo = "";
        String userIdStr = req.getParameter("userId");
        int userId = (userIdStr != null && !userIdStr.isEmpty()) ? Integer.parseInt(userIdStr) : 0;

        switch (path) {
            case "/enter":
                parkingService.enterSlot(slotNo, vehicleNo, userId);
                break;
            case "/exit":
                parkingService.exitSlot(slotNo, vehicleNo, userId);
                break;
            case "/reserve":
                parkingService.reserveSlot(slotNo, vehicleNo, userId);
                break;
        }

        HttpSession session = req.getSession(false);
        boolean isAdmin = session != null && session.getAttribute("loggedInAdmin") != null;
        if (isAdmin) {
            res.sendRedirect(req.getContextPath() + "/admin/slotMap");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/findSlot");
        }
    }
}