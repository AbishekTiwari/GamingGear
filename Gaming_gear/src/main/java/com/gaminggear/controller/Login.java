/**
 * Servlet handling user authentication and session management
 * Validates credentials, creates user session, supports "Remember Me" feature,
 * loads profile picture path from database,
 * and redirects users based on their roles.
 * 
 * Author: Abishek Tiwari
 */

package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

import com.gaminggear.service.RememberMeService;
import com.gaminggear.util.CookieUtil;
import com.gaminggear.util.DbUtil;
import com.gaminggear.util.PasswordUtil;
import com.gaminggear.util.SessionUtil;

@WebServlet(urlPatterns = { "/login" })
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles POST requests for user authentication
     * - Validates credentials against database
     * - Creates user session on successful login
     * - Implements "Remember Me" using service class
     * - Redirects based on user role (admin/user)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember-me");

        try (Connection conn = DbUtil.getConnection()) {
            String sql = "SELECT userid, username, email, firstname, lastname, password, salt, role, profile_picture "
                       + "FROM `user` WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String storedHash = rs.getString("password");
                        String storedSalt = rs.getString("salt");

                        // Verify password
                        boolean passwordMatch = PasswordUtil.verifyPassword(password, storedHash, storedSalt);

                        if (passwordMatch) {
                            int userId = rs.getInt("userid");
                            String username = rs.getString("username");
                            String userEmail = rs.getString("email");
                            String firstName = rs.getString("firstname");
                            String lastName = rs.getString("lastname");
                            
                            String userRole = rs.getString("role");
                            String profilePicture = rs.getString("profile_picture");

                            // Create session
                            SessionUtil.createUserSession(
                            	    request, username, userId, userEmail,
                            	    userRole, firstName, lastName, profilePicture,
                            	    storedHash, storedSalt
                            	);


                            // Handle Remember Me
                            if (rememberMe != null) {
                                RememberMeService.handleRememberMe(response, username);
                            }

                            // Redirect
                            if ("admin".equalsIgnoreCase(userRole)) {
                            	response.sendRedirect(request.getContextPath() + "/list-products?action=admin");
                            } else {
                                response.sendRedirect("index.jsp");
                            }
                            return;
                        }
                    }

                    // Login failed
                    response.sendRedirect(request.getContextPath() + "/pages/login.jsp?error=Invalid Email or Password!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp?error=Database Error!");
        }
    }

    /**
     * Redirects GET requests to login page
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    }
}
