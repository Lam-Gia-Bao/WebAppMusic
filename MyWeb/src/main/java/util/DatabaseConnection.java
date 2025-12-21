package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility Class
 * Manages MySQL database connections for the WebAppMusic application
 */
public class DatabaseConnection {
    
    // Database credentials - CHANGE THESE TO MATCH YOUR MySQL SETUP
    private static final String DB_URL = "jdbc:mysql://localhost:3306/webappmusic?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";  // Change to your MySQL username
    private static final String DB_PASSWORD = "";  // Change to your MySQL password
    
    // JDBC Driver name
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName(JDBC_DRIVER);
            System.out.println("MySQL JDBC Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load MySQL JDBC Driver!");
            e.printStackTrace();
        }
    }
    
    /**
     * Get a connection to the database
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection established successfully!");
            return conn;
        } catch (SQLException e) {
            System.err.println("Failed to connect to database!");
            System.err.println("URL: " + DB_URL);
            System.err.println("User: " + DB_USER);
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Close database connection
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Database connection closed successfully!");
            } catch (SQLException e) {
                System.err.println("Failed to close database connection!");
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test database connection
     * @return true if connection successful, false otherwise
     */
    public static boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Database connection test failed!");
            e.printStackTrace();
            return false;
        } finally {
            closeConnection(conn);
        }
    }
    
    /**
     * Main method for testing database connection
     */
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        if (testConnection()) {
            System.out.println("✓ Database connection test SUCCESSFUL!");
        } else {
            System.out.println("✗ Database connection test FAILED!");
        }
    }
}
