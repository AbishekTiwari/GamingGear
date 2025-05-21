/**
 * Service class for managing "Remember Me" functionality.
 * Handles creation, validation, and deletion of persistent login tokens
 * through secure cookies and database-backed storage.
 * 
 * Responsibilities:
 * - Generates and stores secure tokens for remembering users
 * - Creates and manages HttpOnly cookies for persistent login
 * - Validates tokens to auto-login users
 * - Deletes tokens on logout
 * 
 * Security Features:
 * - HttpOnly cookie to prevent XSS access
 * - Token expiration (default: 7 days)
 * 
 * Author: Abishek Tiwari
 */

package com.gaminggear.service;

import com.gaminggear.util.CookieUtil;
import com.gaminggear.util.DbUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;
import java.util.Date;
import java.util.UUID;

public class RememberMeService {

    /**
     * Handles "Remember Me" functionality by:
     * - Generating a secure token
     * - Storing it in the database
     * - Creating a persistent cookie in the browser
     * 
     * @param response HttpServletResponse to set cookie
     * @param username Username to associate with token
     */
    public static void handleRememberMe(HttpServletResponse response, String username) {
        String token = generateSecureToken();

        try (Connection conn = DbUtil.getConnection()) {
            storeToken(conn, username, token);
            CookieUtil.createRememberMeCookie(response, token);
        } catch (SQLException e) {
            e.printStackTrace(); // Handle appropriately (e.g., logging)
        }
    }

    /**
     * Validates remember-me token from cookie.
     * Checks if the token exists in the database and is not expired.
     * 
     * @param request HttpServletRequest to read cookie
     * @return Username if token is valid; otherwise null
     */
    public static String validateToken(HttpServletRequest request) {
        String token = CookieUtil.getCookieValue(request, "rememberMe");

        if (token == null) return null;

        String sql = "SELECT username FROM remember_me_tokens WHERE token = ? AND expiry_date > NOW()";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username"); // Valid token
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle appropriately
        }

        return null; // Token invalid or expired
    }

    /**
     * Clears remember-me token on logout by:
     * - Removing token from the database
     * - Deleting cookie from browser
     * 
     * @param request HttpServletRequest to read token
     * @param response HttpServletResponse to delete cookie
     */
    public static void clearRememberMe(HttpServletRequest request, HttpServletResponse response) {
        String token = CookieUtil.getCookieValue(request, "rememberMe");

        if (token != null) {
            try (Connection conn = DbUtil.getConnection()) {
                deleteToken(conn, token);
            } catch (SQLException e) {
                e.printStackTrace(); // Log or handle
            }
        }

        // Delete cookie regardless of DB operation
        CookieUtil.deleteCookie(response, "rememberMe");
    }

    /**
     * Generates a random UUID-based token for secure identification.
     * 
     * @return Unique secure token
     */
    private static String generateSecureToken() {
        return UUID.randomUUID().toString();
    }

    /**
     * Stores a new remember-me token in the database with a 7-day expiry.
     * 
     * @param conn Active database connection
     * @param username User to associate with token
     * @param token Generated token
     * @throws SQLException On DB error
     */
    private static void storeToken(Connection conn, String username, String token) throws SQLException {
        String sql = "INSERT INTO remember_me_tokens (username, token, expiry_date) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, token);

            long sevenDaysMillis = 7L * 24 * 60 * 60 * 1000;
            Date expiryDate = new Date(System.currentTimeMillis() + sevenDaysMillis);
            ps.setTimestamp(3, new Timestamp(expiryDate.getTime()));

            ps.executeUpdate();
        }
    }

    /**
     * Deletes a specific remember-me token from the database.
     * 
     * @param conn Active DB connection
     * @param token Token to delete
     * @throws SQLException On DB error
     */
    private static void deleteToken(Connection conn, String token) throws SQLException {
        String sql = "DELETE FROM remember_me_tokens WHERE token = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.executeUpdate();
        }
    }
}
