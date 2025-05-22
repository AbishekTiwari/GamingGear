package com.gaminggear.controller;

import com.gaminggear.model.Product;
import com.gaminggear.util.DbUtil;
import java.sql.*;
import java.math.BigDecimal;

public class ProductDAO {
    public static Product getProductById(int productId) throws SQLException {
        String sql = "SELECT * FROM product WHERE productid = ?";
        Product product = null;
        
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProductId(rs.getInt("productid"));
                    product.setProductName(rs.getString("productname"));
                    product.setBrandName(rs.getString("brandname"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setProductSpecification(rs.getString("productspecification"));
                    product.setReleaseDate(rs.getDate("releasedate"));
                    product.setImagePath(rs.getString("imagepath"));
                    product.setStock(rs.getInt("stock"));
                }
            }
        }
        return product;
    }

    public static void updateStock(int productId, int quantity) throws SQLException {
        String sql = "UPDATE product SET stock = stock - ? WHERE productid = ?";
        
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }
}