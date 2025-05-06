package com.gaminggear.controller;

import com.gaminggear.config.DbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updateStock")
public class UpdateStock extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productid"));
            int newStock = Integer.parseInt(request.getParameter("newstock"));
            
            try (Connection conn = DbConfig.getConnection()) {
                String sql = "UPDATE product SET stock=? WHERE productid=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, newStock);
                    stmt.setInt(2, productId);
                    
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        request.getSession().setAttribute("message", "Stock updated successfully");
                    } else {
                        request.getSession().setAttribute("error", "Product not found");
                    }
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error updating stock: " + e.getMessage());
        }
        
        response.sendRedirect("list-products");
    }
}