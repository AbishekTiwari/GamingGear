package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.gaminggear.model.CartItem;
import com.gaminggear.model.Product;
import com.gaminggear.util.DbUtil;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = getOrCreateCart(session);
        
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        if ("add".equals(action)) {
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            addToCart(cart, productId, quantity);
        } else if ("remove".equals(action)) {
            cart.remove(productId);
        }
        
        response.sendRedirect(request.getContextPath() + "/pages/cart.jsp");
    }
	

    private Map<Integer, CartItem> getOrCreateCart(HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void addToCart(Map<Integer, CartItem> cart, int productId, int quantity) throws IOException {
        try (Connection conn = DbUtil.getConnection()) {
            Product product = getProductById(conn, productId);
            if (product != null) {
                CartItem item = cart.get(productId);
                if (item != null) {
                    item.setQuantity(item.getQuantity() + quantity);
                } else {
                    cart.put(productId, new CartItem(product, quantity));
                }
            }
        } catch (SQLException e) {
            throw new IOException("Database error", e);
        }
    }

    private Product getProductById(Connection conn, int productId) throws SQLException {
        String sql = "SELECT * FROM product WHERE productid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    // Match EXACT column names from your DB
                    product.setProductId(rs.getInt("productid"));
                    product.setProductName(rs.getString("productname"));
                    product.setBrandName(rs.getString("brandname"));
                    product.setPrice(rs.getBigDecimal("Price")); // Uppercase 'P' matches DB
                    product.setProductSpecification(rs.getString("productspecification"));
                    product.setReleaseDate(rs.getDate("releasedate"));
                    product.setImagePath(rs.getString("imagepath"));
                    product.setStock(rs.getInt("stock"));
                    return product;
                }
            }
        }
        return null;
    }
}