package com.gaminggear.controller;

import com.gaminggear.model.User;
import java.sql.*;
import com.gaminggear.config.DbConfig;
public class UserDAO {
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT userid, username, email, firstname, lastname FROM users WHERE userid = ?";
        try (Connection conn = DbConfig.getConnection();
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
                    null,  // password not retrieved
                    null   // role not retrieved
                );
            }
        }
        return null;
    }

    public boolean updateEmail(int userId, String newEmail) throws SQLException {
        String sql = "UPDATE users SET email = ? WHERE userid = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newEmail);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }
        public boolean updateUser(User user) throws Exception {
            String sql = "UPDATE users SET email = ? WHERE user_id = ?";
            
            try (Connection conn = DbConfig.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, user.getEmail());
                stmt.setInt(2, user.getUserId());

                int rowsUpdated = stmt.executeUpdate();
                return rowsUpdated > 0;
            }
        

    }
}