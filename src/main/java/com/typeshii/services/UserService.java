package com.typeshii.services;

import com.typeshii.dao.UserDAO;
import com.typeshii.dao.VehicleDAO;
import com.typeshii.model.User;
import com.typeshii.model.Vehicle;
import java.util.List;
import java.util.Map;

// business logic for user stuff
public class UserService {

    private UserDAO userDAO = new UserDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();

    // login - find user by vehicle number
    public User login(String vehicleNo) {
        Vehicle vehicle = vehicleDAO.getVehicleByPlate(vehicleNo);
        if (vehicle == null) return null;
        return userDAO.getUserByUserId(vehicle.getUserId());
    }

    // register new user
    public int registerUser(User user) {
        return userDAO.insertUser(user);
    }

    // check if phone already exists - duplicate check
    public boolean isPhoneTaken(String phone) {
        return userDAO.getUserByPhone(phone) != null;
    }

    // check if student id already exists
    public boolean isIdTaken(String id) {
        return userDAO.getUserById(id) != null;
    }

    // check if vehicle number already registered
    public boolean isVehicleNoTaken(String vehicleNo) {
        return vehicleDAO.getVehicleByPlate(vehicleNo) != null;
    }

    // get all users for admin page
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    // search users by vehicle number
    public List<User> getUsersByVehicleNo(String vehicleNo) {
        return userDAO.getUsersByVehicleNo(vehicleNo);
    }

    // get userId -> vehicleNo map for bulk display
    public Map<Integer, String> getVehicleNoMap() {
        return vehicleDAO.getVehicleNoMapByUser();
    }

    // get vehicles belonging to a user
    public List<Vehicle> getVehiclesByUser(int userId) {
        return vehicleDAO.getVehiclesByUser(userId);
    }

    // register vehicle for a user
    public int registerVehicle(Vehicle vehicle) {
        return vehicleDAO.insertVehicle(vehicle);
    }
}