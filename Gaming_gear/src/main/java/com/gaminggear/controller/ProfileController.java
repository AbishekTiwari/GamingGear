package com.gaminggear.controller;

import com.gaminggear.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            User currentUser = userDao.getUserById(user.getUserId());
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/pages/profile.jsp?error=Error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        try {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            User currentUser = userDao.getUserById(user.getUserId());
            
            switch (action) {
                case "edit":
                    request.setAttribute("editMode", true);
                    break;
                    
                case "save":
                    currentUser.setEmail(request.getParameter("email"));
                    if (userDao.updateUser(currentUser)) {
                        session.setAttribute("user", currentUser);
                        request.setAttribute("message", "Profile updated successfully");
                    }
                    break;
                    
                case "cancel":
                    request.removeAttribute("editMode");
                    break;
                    
                case "changePassword":
                    request.setAttribute("showPasswordFields", true);
                    request.setAttribute("editMode", true);
                    break;
            }

            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Operation failed: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/pages/profile.jsp?error=Error!");
        }
    }
}