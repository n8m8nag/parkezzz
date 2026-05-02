package com.typeshii.controller;

import com.typeshii.model.Slot;
import com.typeshii.services.ParkingService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

// handles slot operations - occupy reserve exit
@WebServlet("/slot/*")
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

        int slotNo    = Integer.parseInt(req.getParameter("slotNo"));
        int vehicleNo = Integer.parseInt(req.getParameter("vehicleNo"));
        int userId    = Integer.parseInt(req.getParameter("userId"));

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

        res.sendRedirect(req.getContextPath() + "/user/findSlot");
    }
}