package com.typeshii.dao;

import com.typeshii.model.User;
import com.typeshii.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles all db stuff for user table
public class UserDAO {

    // find user by student id - used for login
    public User getUserById(String id) {
        User user = null;
        String sql = "SELECT * FROM user WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = mapUser(rs);
            }
        } catch (Exception e) {
            System.err.println("UserDAO.getUserById error: " + e.getMessage());
        }
        return user;
    }

    // find user by phone - for duplicate check
    public User getUserByPhone(String phone) {
        User user = null;
        String sql = "SELECT * FROM user WHERE phone = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = mapUser(rs);
            }
        } catch (Exception e) {
            System.err.println("UserDAO.getUserByPhone error: " + e.getMessage());
        }
        return user;
    }

    // insert new user
    public int insertUser(User user) {
        String sql = "INSERT INTO user (full_name, id, phone, user_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getId());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getUserType());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (Exception e) {
            System.err.println("UserDAO.insertUser error: " + e.getMessage());
        }
        return -1;
    }

    // get all users - for admin users page
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY user_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(mapUser(rs));
            }
        } catch (Exception e) {
            System.err.println("UserDAO.getAllUsers error: " + e.getMessage());
        }
        return users;
    }

    // maps resultset row to user object
    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFullName(rs.getString("full_name"));
        u.setId(rs.getString("id"));
        u.setPhone(rs.getString("phone"));
        u.setUserType(rs.getString("user_type"));
        return u;
    }
}