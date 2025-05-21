/**
 * Servlet to serve user profile images stored outside the deployment folder.
 * Maps to /uploads/* and streams image bytes from external folder.
 * 
 * Author: Abishek Tiwari
 */

package com.gaminggear.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Same folder where images are stored by EditProfileController
    private static final String IMAGE_DIR = "C:/gaminggear/uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Extract requested image filename from URL, e.g. /uploads/filename.png
        String requestedImage = req.getPathInfo();  // "/filename.png"

        if (requestedImage == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);  // 404
            return;
        }

        File imageFile = new File(IMAGE_DIR, requestedImage);

        if (!imageFile.exists() || imageFile.isDirectory()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);  // 404
            return;
        }

        // Get MIME type based on filename extension
        String mime = getServletContext().getMimeType(imageFile.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }
        resp.setContentType(mime);

        // Stream image file bytes to response
        try (FileInputStream in = new FileInputStream(imageFile);
             var out = resp.getOutputStream()) {

            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }
}

