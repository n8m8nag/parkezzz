package com.typeshii.services;

import com.typeshii.dao.UserDAO;
import com.typeshii.dao.VehicleDAO;
import com.typeshii.model.User;
import com.typeshii.model.Vehicle;
import java.util.List;

// business logic for user stuff
public class UserService {

    private UserDAO userDAO = new UserDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();

    // login - find user by student id
    public User login(String id) {
        return userDAO.getUserById(id);
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

    // get all users for admin page
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
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