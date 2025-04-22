/**
 * @author Abishek Tiwari
 */


package com.gaminggear.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionConfig {
    
    // Create a new session with user details
    public static void createUserSession(HttpServletRequest request, String username, String role) {
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        session.setAttribute("role", role);
        session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout
    }

    // Check if user is logged in
    public static boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("username") != null;
    }

    // Get current user's username
    public static String getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (String) session.getAttribute("username") : null;
    }

    // Invalidate session (logout)
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    // Check if user has admin role
    public static boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "admin".equals(session.getAttribute("role"));
    }
}