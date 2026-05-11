package com.typeshii.util;

import java.sql.Connection;
import java.sql.DriverManager;

//used to connect database to webapp
public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/ParkEZz?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // xampp default is empty

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}