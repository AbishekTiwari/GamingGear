
/**
 * Utility class for handling cookie operations
 * Provides methods for cookie creation, retrieval, and deletion
 * @author Abishek Tiwari
 */



package com.gaminggear.config;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieConfig {
	
	/**
     * Creates and adds a cookie to the response
     * @param response HttpServletResponse object
     * @param name Cookie name
     * @param value Cookie value
     * @param maxAge Cookie lifetime in seconds
     * 
     * Security Features:
     * - Sets HttpOnly flag to prevent XSS access
     * - Sets path to "/" for whole domain access
     * - Secure flag commented out (enable for HTTPS)
     */
    
    // Add a new cookie
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(maxAge); // in seconds
        // cookie.setSecure(true); // Enable for HTTPS
        response.addCookie(cookie);
    }
    
    /**
     * Retrieves cookie value by name
     * @param request HttpServletRequest object
     * @param name Cookie name to search for
     * @return Cookie value or null if not found
     */

    // Get cookie value by name
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    
    /**
     * Deletes a cookie by setting maxAge to 0
     * @param response HttpServletResponse object
     * @param name Cookie name to delete
     */

    // Delete a cookie
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(0); // Immediately expire
        response.addCookie(cookie);
    }
    
    /**
     * Creates a persistent remember-me cookie
     * @param response HttpServletResponse object
     * @param token Authentication token to store
     * 
     * Cookie Settings:
     * - 1 week duration (7 days)
     * - HttpOnly flag enabled
     * - Applies to entire domain
     */

    // Create remember-me cookie
    public static void createRememberMeCookie(HttpServletResponse response, String token) {
        addCookie(response, "rememberMe", token, 7 * 24 * 60 * 60); // 1 week
    }
}