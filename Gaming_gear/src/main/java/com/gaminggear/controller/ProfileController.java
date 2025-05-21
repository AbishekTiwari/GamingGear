package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.gaminggear.util.SessionUtil;

@WebServlet("/profile")

public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // if not logged in, bounce back to login
        if (!SessionUtil.isUserLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        // session already contains username, email, userId
        HttpSession session = req.getSession(false);
        req.setAttribute("username", session.getAttribute("username"));
        req.setAttribute("email",    session.getAttribute("email"));
        req.setAttribute("userId",   session.getAttribute("userid"));
        

        // forward into your JSP
        req.getRequestDispatcher("/profile.jsp")
           .forward(req, resp);
    }
}
