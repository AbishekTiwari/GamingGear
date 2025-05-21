package com.gaminggear.service;

import com.gaminggear.controller.UserDAO;
import com.gaminggear.model.User;
import com.gaminggear.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserService {

    private static UserDAO userDAO = new UserDAO();

    // Get user by id (including password and role)
    public static User getUserById(int userId) {
        try {
            return userDAO.getUserById(userId);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Get salt by user id
    public static String getSaltByUserId(int userId) {
        try {
            return userDAO.getSaltByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static boolean updatePasswordWithSalt(int userId, String hashedPassword, String salt) {
        String sql = "UPDATE user SET password = ?, salt = ? WHERE userid = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, hashedPassword);
            ps.setString(2, salt);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Update password and salt
    public static boolean updatePasswordAndSalt(int userId, String hashedPassword, String salt) {
        try {
            return userDAO.updatePasswordAndSalt(userId, hashedPassword, salt);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
