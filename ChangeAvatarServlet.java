package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/changeAvatar")
public class ChangeAvatarServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        String avatar = request.getParameter("avatar");
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if (username == null || username.isEmpty()) {
            response.getWriter().write("error");
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String updateSql = "UPDATE user1 SET avatar = ? WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                stmt.setString(1, avatar);
                stmt.setString(2, username);
                stmt.executeUpdate();
            }
            
            session.setAttribute("avatar", avatar);
            
            response.getWriter().write("success");
        } catch (SQLException e) {
            response.getWriter().write("error");
        }
    }
}