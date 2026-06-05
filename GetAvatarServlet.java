package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/getAvatar")
public class GetAvatarServlet extends HttpServlet {

    private String url;
    private String user;
    private String password;
    private String driver;

    @Override
    public void init() throws ServletException {
        Properties props = new Properties();
        try {
            props.load(getServletContext().getResourceAsStream("/WEB-INF/classes/db.properties"));
            url = props.getProperty("url");
            user = props.getProperty("user");
            password = props.getProperty("pwd");
            driver = props.getProperty("driver");
            Class.forName(driver);
        } catch (Exception e) {
            throw new ServletException("数据库配置加载失败", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        
        if (username == null || username.isEmpty()) {
            response.getWriter().write("{\"exists\": false}");
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "SELECT avatar FROM user1 WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String avatar = rs.getString("avatar");
                        if (avatar != null && !avatar.isEmpty()) {
                            String[] parts = avatar.split(",");
                            if (parts.length == 2) {
                                response.getWriter().write(String.format(
                                    "{\"exists\": true, \"gradient\": \"%s\", \"initial\": \"%s\"}",
                                    parts[0], parts[1]
                                ));
                            } else {
                                response.getWriter().write("{\"exists\": false}");
                            }
                        } else {
                            response.getWriter().write("{\"exists\": false}");
                        }
                    } else {
                        response.getWriter().write("{\"exists\": false}");
                    }
                }
            }
        } catch (SQLException e) {
            response.getWriter().write("{\"exists\": false}");
        }
    }
}