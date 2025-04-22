/**
 * Servlet handling user authentication and session management
 * @author Abishek Tiwari
 */


package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import com.gaminggear.config.DbConfig;
import com.gaminggear.config.SessionConfig;
import com.gaminggear.config.CookieConfig;

@WebServlet(urlPatterns = { "/login" })
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Handles POST requests for user authentication
     * - Validates credentials against database
     * - Creates user session on successful login
     * - Implements "Remember Me" functionality
     * - Redirects based on user role (admin/user)
     */

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String rememberMe = request.getParameter("remember-me");

        try (Connection conn = DbConfig.getConnection()) {
            String sql = "SELECT username, role FROM user WHERE email=? AND password=? AND role=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                ps.setString(3, role);
                
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String username = rs.getString("username");
                        String userRole = rs.getString("role");

                        // Create session using utility
                        SessionConfig.createUserSession(request, username, userRole);
                        
                     // Handle Remember Me functionality
                        if (rememberMe != null) {
                            String token = generateSecureToken();
                            storeRememberMeToken(conn, username, token);
                            CookieConfig.createRememberMeCookie(response, token);
                        }

                        // Redirect based on role
                        if ("admin".equalsIgnoreCase(userRole)) {
                            response.sendRedirect("admin-dashboard.html");
                        } else {
                            response.sendRedirect("index.html");
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/pages/login.html?error=invalid");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/login.html?error=database");
        }
    } 
    
    /**
     * Handles GET requests by redirecting to login page
     */
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("login.html"); 
    }
    
    /**
     * Generates UUID-based secure token for Remember Me functionality
     * Note: Temporary implementation - should be hashed in production
     * @return Random UUID string as token
     */
    
    private String generateSecureToken() {
        return java.util.UUID.randomUUID().toString();
    }
    
    /**
     * Stores Remember Me token in database with expiration date
     * @param conn Active database connection
     * @param username User to associate with token
     * @param token Generated security token
     * @throws SQLException On database operation failure
     * Note: Currently stores plain text token - should hash in production
     */
    
    private void storeRememberMeToken(Connection conn, String username, String token) throws SQLException {
        String sql = "INSERT INTO remember_me_tokens (username, token, expiry_date) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, token);
            
            // Set expiry to 7 days from now
            java.util.Date expiry = new java.util.Date(
                System.currentTimeMillis() + (7 * 24 * 60 * 60 * 1000)
            );
            ps.setTimestamp(3, new java.sql.Timestamp(expiry.getTime()));
            ps.executeUpdate();
        }
    }
}