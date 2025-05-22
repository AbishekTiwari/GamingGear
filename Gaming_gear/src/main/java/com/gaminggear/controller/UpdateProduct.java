package com.gaminggear.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gaminggear.util.DbUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateProduct")
public class UpdateProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productid"));
            String productName = request.getParameter("productname");
            String brandName = request.getParameter("brandname");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String specification = request.getParameter("productspecification");
            java.sql.Date releaseDate = java.sql.Date.valueOf(request.getParameter("releasedate"));

            try (Connection conn = DbUtil.getConnection()) {
                String sql = "UPDATE product SET productname=?, brandname=?, price=?, "
                           + "productspecification=?, releasedate=? WHERE productid=?";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, brandName);
                    stmt.setBigDecimal(3, price);
                    stmt.setString(4, specification);
                    stmt.setDate(5, releaseDate);
                    stmt.setInt(6, productId);
                    
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        request.getSession().setAttribute("message", "Product updated successfully");
                    } else {
                        request.getSession().setAttribute("error", "Product not found");
                    }
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error updating product: " + e.getMessage());
        }
        
        response.sendRedirect("list-products?action=admin");
    }
}