package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gaminggear.util.DbUtil;

import java.sql.Date;

@WebServlet("/addProduct")
@MultipartConfig
public class AddProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve product details
        String productName = request.getParameter("productname");
        String brandName = request.getParameter("brandname");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String specification = request.getParameter("productspecification");
        Date releaseDate = Date.valueOf(request.getParameter("releasedate"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        // Handle image upload
        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName();

        String uploadDirPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        imagePart.write(uploadDirPath + File.separator + imageFileName);
        String imagePath = imageFileName;  // Save just the filename

        // Store in DB
        try (Connection conn = DbUtil.getConnection()) {
            String sql = "INSERT INTO product (productname, brandname, Price, productspecification, releasedate, imagepath, stock) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, productName);
                stmt.setString(2, brandName);
                stmt.setBigDecimal(3, price);
                stmt.setString(4, specification);
                stmt.setDate(5, releaseDate);
                stmt.setString(6, imagePath);
                stmt.setInt(7, stock);

                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("products");
    }
}
