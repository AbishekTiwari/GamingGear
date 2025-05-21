/**
 * Servlet to handle user profile edits including profile picture upload.
 * Saves uploaded profile pictures to an external folder to prevent loss on server restart.
 * Updates user info and profile picture path in the database and updates session attributes.
 * 
 * Author: Abishek Tiwari
 */

package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gaminggear.util.DbUtil;
import com.gaminggear.util.SessionUtil;

@WebServlet("/edit-profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // External directory where profile images are saved permanently
    private static final String UPLOAD_DIR = "C:/gaminggear/uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Check if user is logged in, else redirect to login
        if (!SessionUtil.isUserLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Load user session attributes to display current profile info
        HttpSession session = req.getSession(false);
        req.setAttribute("username", session.getAttribute("username"));
        req.setAttribute("email", session.getAttribute("email"));
        req.setAttribute("userid", session.getAttribute("userid"));
        req.setAttribute("firstname", session.getAttribute("firstname"));
        req.setAttribute("lastname", session.getAttribute("lastname"));
        req.setAttribute("role", session.getAttribute("role"));
        req.setAttribute("profilePicture", session.getAttribute("profilePicture"));

        // Forward to edit-profile JSP page
        req.getRequestDispatcher("/pages/edit-profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        String userId = session.getAttribute("userid").toString();

        // Read form parameters
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String email = req.getParameter("email");

        // Process uploaded profile picture part
        Part filePart = req.getPart("profilePicture");
        String fileName = null;
        String dbFilePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Extract filename safely
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Create upload directory if it doesn't exist
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save file to external folder
            String filePath = UPLOAD_DIR + File.separator + fileName;
            filePart.write(filePath);

            // Save relative path for DB and display (served by ImageServlet)
            dbFilePath = "uploads/" + fileName;
        }

        // Update user record in the database with new info and possibly profile picture path
        try (Connection conn = DbUtil.getConnection()) {
            String sql;
            if (dbFilePath != null) {
                // Update with new profile picture path
                sql = "UPDATE user SET firstname = ?, lastname = ?, email = ?, profile_picture = ? WHERE userid = ?";
            } else {
                // Update without changing profile picture
                sql = "UPDATE user SET firstname = ?, lastname = ?, email = ? WHERE userid = ?";
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, firstname);
                ps.setString(2, lastname);
                ps.setString(3, email);

                if (dbFilePath != null) {
                    ps.setString(4, dbFilePath);
                    ps.setInt(5, Integer.parseInt(userId));
                } else {
                    ps.setInt(4, Integer.parseInt(userId));
                }

                ps.executeUpdate();
            }

            // Update session attributes to reflect changes
            session.setAttribute("firstname", firstname);
            session.setAttribute("lastname", lastname);
            session.setAttribute("email", email);
            if (dbFilePath != null) {
                session.setAttribute("profilePicture", dbFilePath);
            }

            // Redirect back to profile page
            resp.sendRedirect(req.getContextPath() + "/pages/profile.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            // On error, redirect back with error message (optional enhancement)
            resp.sendRedirect(req.getContextPath() + "/pages/edit-profile.jsp?error=Database error.");
        }
    }
}
