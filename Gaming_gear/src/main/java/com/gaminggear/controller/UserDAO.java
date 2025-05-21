package com.gaminggear.controller;

import com.gaminggear.model.User;
import com.gaminggear.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Get user info by ID (including password and role)
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT userid, username, email, firstname, lastname, password, salt, role FROM users WHERE userid = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("userid"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("firstname"),
                    rs.getString("lastname"),
                    rs.getString("password"),  // hashed password
                    rs.getString("role")
                );
            }
        }
        return null;
    }

    // Get salt by user ID
    public String getSaltByUserId(int userId) throws SQLException {
        String sql = "SELECT salt FROM users WHERE userid = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("salt");
            }
        }
        return null;
    }

    // Update password and salt for user
    public boolean updatePasswordAndSalt(int userId, String hashedPassword, String salt) throws SQLException {
        String sql = "UPDATE users SET password = ?, salt = ? WHERE userid = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setString(2, salt);
            stmt.setInt(3, userId);
            return stmt.executeUpdate() > 0;
        }
    }
}
