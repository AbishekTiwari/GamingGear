/**
 * @author Abishek Tiwari
 */


package com.gaminggear.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
    
	/**
     * Creates a user session with all relevant attributes, including profile picture path
     */
	public static void createUserSession(HttpServletRequest request,
            String username, int userId, String email,
            String role, String firstName, String lastName,
            String profilePicture,
            String password, String salt) {
HttpSession session = request.getSession();
session.setAttribute("username", username);
session.setAttribute("userid", userId);
session.setAttribute("email", email);
session.setAttribute("role", role);
session.setAttribute("firstname", firstName);
session.setAttribute("lastname", lastName);
session.setAttribute("profilePicture", profilePicture);


session.setAttribute("password", password);
session.setAttribute("salt", salt);
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