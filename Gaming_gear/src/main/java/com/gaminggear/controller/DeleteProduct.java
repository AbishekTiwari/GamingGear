package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gaminggear.util.DbUtil;

@WebServlet("/deleteProduct")
public class DeleteProduct extends HttpServlet {
	 private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productid"));
            
            try (Connection conn = DbUtil.getConnection()) {
                String sql = "DELETE FROM product WHERE productid=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, productId);
                    int rowsAffected = stmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        request.getSession().setAttribute("message", "Product deleted successfully");
                    } else {
                        request.getSession().setAttribute("error", "Product not found");
                    }
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error deleting product: " + e.getMessage());
        }
        
        response.sendRedirect("list-products");
    }
}