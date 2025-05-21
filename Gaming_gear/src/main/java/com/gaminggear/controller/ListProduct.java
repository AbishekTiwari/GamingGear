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

        List<Product> products = new ArrayList<>();

        try (Connection conn = DbUtil.getConnection()) {
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

                    // Optional: these must exist in DB schema to avoid errors
                    try { p.setImagePath(rs.getString("imagepath")); } catch (SQLException ignore) {}
                    try { p.setStock(rs.getInt("stock")); } catch (SQLException ignore) {}

                    products.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("productList", products);
        request.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(request, response);
    }
}
