package com.gaminggear.controller;

import com.gaminggear.model.Product;
import com.gaminggear.util.DbUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/list-products")
public class ListProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get search query parameter from request
        String searchQuery = request.getParameter("query");
        
        // Initialize empty product list
        List<Product> products = new ArrayList<>();

        try (Connection conn = DbUtil.getConnection()) {
            // Base SQL query
            String sql = "SELECT * FROM product";
            
            // Add search condition if query exists
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql += " WHERE LOWER(productname) LIKE ? OR LOWER(brandname) LIKE ?";
            }

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Set parameters if search query exists
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    // Format search term for partial matching
                    String likeTerm = "%" + searchQuery.toLowerCase() + "%";
                    stmt.setString(1, likeTerm);
                    stmt.setString(2, likeTerm);
                }

                // Execute query and process results
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Product product = new Product();
                        
                        // Set core product properties
                        product.setProductId(rs.getInt("productid"));
                        product.setProductName(rs.getString("productname"));
                        product.setBrandName(rs.getString("brandname"));
                        product.setPrice(rs.getBigDecimal("Price"));
                        product.setProductSpecification(rs.getString("productspecification"));
                        product.setReleaseDate(rs.getDate("releasedate"));

                        // Handle optional fields with error catching
                        try {
                            product.setImagePath(rs.getString("imagepath"));
                        } catch (SQLException e) {
                            // Log missing column error if needed
                        }
                        
                        try {
                            product.setStock(rs.getInt("stock"));
                        } catch (SQLException e) {
                            // Log missing column error if needed
                        }

                        products.add(product);
                    }
                }
            }
        } catch (SQLException e) {
            // Log database errors properly in production
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
        }

        // Set attributes for JSP
        request.setAttribute("products", products); // Correct attribute name for JSP
        request.setAttribute("searchQuery", searchQuery); // Preserve search term
        
        // Forward to appropriate view
        String action = request.getParameter("action");
        String targetPage = "admin".equals(action) 
                ? "/admin/admin_dashboard.jsp" 
                : "/pages/product.jsp";
        request.getRequestDispatcher(targetPage).forward(request, response);
    }
}