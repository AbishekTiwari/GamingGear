/**
 * Handles database connection setup and management
 * Manages MySQL driver loading and connection creation
 * @author Abishek Tiwari
 */

package com.gaminggear.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConfig {
	// Database connection details (development setup)
    private static final String URL = "jdbc:mysql://localhost:3306/gaming_gear"; // Local MySQL
    private static final String USER = "root";      //Default admin user
    private static final String PASSWORD = "";         //Empty password for development

    // One-time setup when class is first loaded
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
        	// Crash early if driver missing - prevents silent failures
            throw new ExceptionInInitializerError("MySQL JDBC Driver not found. Add it to your classpath!");
        }
    }
    
    /**
     * Provides fresh database connections for SQL operations
     * @return Active connection to gaming_gear database
     * @throws SQLException If connection fails (wrong credentials, DB offline)
     */

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}