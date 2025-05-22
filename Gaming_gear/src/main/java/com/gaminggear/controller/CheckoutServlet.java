package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.Map;

import com.gaminggear.model.CartItem;
import com.gaminggear.util.DbUtil;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // Helper method to calculate subtotal
    private BigDecimal calculateSubtotal(Map<Integer, CartItem> cart) {
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            subtotal = subtotal.add(item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        return subtotal;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages/cart.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userid");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Calculate totals
        BigDecimal subtotal = calculateSubtotal(cart);
        BigDecimal tax = subtotal.multiply(new BigDecimal("0.10")); // 10% tax
        BigDecimal total = subtotal.add(tax);

        request.setAttribute("subtotal", subtotal);
        request.setAttribute("tax", tax);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        try {
            if (cart == null || cart.isEmpty()) {
                throw new Exception("Cart is empty");
            }

            Integer userId = (Integer) session.getAttribute("userid");
            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                return;
            }

            BigDecimal subtotal = calculateSubtotal(cart);
            BigDecimal tax = subtotal.multiply(new BigDecimal("0.10"));
            BigDecimal totalAmount = subtotal.add(tax);

            boolean paymentSuccess = processPayment(request);

            if (paymentSuccess) {
                int orderId = createOrder(cart, userId, totalAmount);
                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/pages/order-confirmation.jsp?id=" + orderId);
            } else {
                throw new Exception("Payment processing failed");
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
        }
    }

    private boolean processPayment(HttpServletRequest request) {
        // Dummy payment processor: always returns true for now.
        // You can integrate a real payment gateway here.
        return true;
    }

    private int createOrder(Map<Integer, CartItem> cart, int userId, BigDecimal totalAmount) throws SQLException {
        try (Connection conn = DbUtil.getConnection()) {
            conn.setAutoCommit(false);

            String orderSql = "INSERT INTO `order` (userid, order_date, status, total_amount) VALUES (?, ?, ?, ?)";
            int orderId;

            try (PreparedStatement stmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.setDate(2, new Date(System.currentTimeMillis()));
                stmt.setInt(3, 1); // Status: Pending
                stmt.setBigDecimal(4, totalAmount);
                stmt.executeUpdate();

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    rs.next();
                    orderId = rs.getInt(1);
                }
            }

            String detailSql = "INSERT INTO order_detail (orderid, productid, quantity, price_each) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(detailSql)) {
                for (CartItem item : cart.values()) {
                    stmt.setInt(1, orderId);
                    stmt.setInt(2, item.getProduct().getProductId());
                    stmt.setInt(3, item.getQuantity());
                    stmt.setBigDecimal(4, item.getProduct().getPrice());
                    stmt.addBatch();

                    updateInventory(conn, item.getProduct().getProductId(), item.getQuantity());
                }
                stmt.executeBatch();
            }

            conn.commit();
            return orderId;
        }
    }

    private void updateInventory(Connection conn, int productId, int quantity) throws SQLException {
        String sql = "UPDATE product SET stock = stock - ? WHERE productid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }
}
