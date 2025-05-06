/**
 * Servlet handling user registration process
 * @author Abishek Tiwari
 */


package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import com.gaminggear.config.DbConfig;

@WebServlet("/register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    
    /**
     * Handles POST requests for user registration
     * - Validates registration parameters
     * - Checks for existing users
     * - Creates new user accounts
     * - Handles error cases and redirects
     */

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String role = request.getParameter("role");

        // Block admin registration
        if ("admin".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/pages/register.jsp?error=Register as admin not allowed");
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/pages/register.jsp?error=password mismatch");
            return;
        }

        try (Connection conn = DbConfig.getConnection()) {
            if (userExists(conn, email, username)) {
                response.sendRedirect(request.getContextPath() + "/pages/register.jsp?error=Email already exists");
                return;
            }

            String sql = "INSERT INTO user (firstname, lastname, username, email, password, role) VALUES (?, ?, ?, ?, ?, 'user')";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, username);
                ps.setString(4, email);
                ps.setString(5, password);

                if (ps.executeUpdate() > 0) {
                    response.sendRedirect(request.getContextPath() + "/pages/register.jsp?success=1");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/register.jsp?error=database");
        }
    }
    /**
     * Checks if a user already exists with the provided email or username
     * @param conn Active database connection
     * @param email User's email to check
     * @param username Username to check
     * @return true if user exists otherwise false
     * @throws SQLException when database operation failure
     */

    private boolean userExists(Connection conn, String email, String username) throws SQLException {
        String checkSql = "SELECT userid FROM user WHERE email = ? OR username = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ps.setString(1, email);
            ps.setString(2, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}