/**
 * Servlet to handle user logout
 * - Invalidates the current session
 * - Redirects to the login page
 * 
 * Author: Abishek Tiwari
 */

package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests for logout
     * Invalidates session and redirects to login page
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // get current session if exists
        if (session != null) {
            session.invalidate();  // invalidate session to logout
        }
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    }
}
