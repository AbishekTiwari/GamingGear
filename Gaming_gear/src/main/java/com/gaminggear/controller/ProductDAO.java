package com.gaminggear.controller;

import com.gaminggear.config.DbConfig;
import com.gaminggear.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductDAO extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = new ArrayList<>();

        try (Connection conn = DbConfig.getConnection()) {
            String sql = "SELECT * FROM product";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("productid"));
                    p.setProductName(rs.getString("productname"));
                    p.setBrandName(rs.getString("brandname"));
                    p.setPrice(rs.getBigDecimal("Price"));
                    p.setProductSpecification(rs.getString("productspecification"));
                    p.setReleaseDate(rs.getDate("releasedate"));
                    p.setImagePath(rs.getString("imagepath"));
                    p.setStock(rs.getInt("stock"));

                    products.add(p);
                }

                // Check if data was fetched
                if (products.isEmpty()) {
                    System.out.println("No products found in the database.");
                } else {
                    System.out.println("Retrieved " + products.size() + " products from the database.");
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Log to verify request attribute setting
        if (products.isEmpty()) {
            System.out.println("Setting empty product list in request attribute.");
        } else {
            System.out.println("Setting product list in request attribute.");
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/pages/product.jsp").forward(request, response);
    }
}
