package com.TransitProject.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

    public ApplicationDB() {
        // Default constructor
    }

    public Connection getConnection() {
        // Create a connection string
        String connectionUrl = "jdbc:mysql://localhost:3306/TrainDatabase";
        Connection connection = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return null; // Return null or handle appropriately
        }

        try {
            // Create a connection to your DB
            connection = DriverManager.getConnection(connectionUrl, "root", "Andy84134");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return connection;
    }

    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        ApplicationDB dao = new ApplicationDB();
        Connection connection = dao.getConnection();

        if (connection != null) {
            System.out.println("Connection established successfully!");
            dao.closeConnection(connection);
        } else {
            System.out.println("Failed to establish connection.");
        }
    }
}
