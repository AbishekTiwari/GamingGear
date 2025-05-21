package com.gaminggear.controller;

import com.gaminggear.service.UserService;
import com.gaminggear.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Ensure the session and user attributes exist
        if (session == null || session.getAttribute("userid") == null ||
            session.getAttribute("password") == null || session.getAttribute("salt") == null) {
        	response.sendRedirect("pages/login.jsp?error=sessionExpired");
            return;
        }

        // Get session attributes
        int userId = (int) session.getAttribute("userid");
        String storedHash = (String) session.getAttribute("password");
        String storedSalt = (String) session.getAttribute("salt");

        // Get form inputs
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check current password
        if (!PasswordUtil.verifyPassword(currentPassword, storedHash, storedSalt)) {
        	response.sendRedirect("pages/edit-profile.jsp?status=wrongCurrentPassword");
            return;
        }

        // Check new passwords match
        if (!newPassword.equals(confirmPassword)) {
        	response.sendRedirect("pages/edit-profile.jsp?status=passwordMismatch");
            return;
        }

        // Generate new salt and hash new password
        String newSalt = PasswordUtil.generateSalt();
        String newHashedPassword = PasswordUtil.hashPassword(newPassword, newSalt);

        // Update in database
        boolean updated = UserService.updatePasswordWithSalt(userId, newHashedPassword, newSalt);

        if (updated) {
            // Update session
            session.setAttribute("password", newHashedPassword);
            session.setAttribute("salt", newSalt);
            response.sendRedirect("pages/edit-profile.jsp?status=passwordSuccess");
        } else {
        	response.sendRedirect("pages/edit-profile.jsp?status=passwordFail");
        }
    }
}
