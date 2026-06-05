package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if (username == null || username.isEmpty()) {
            response.getWriter().write("{\"success\": false, \"message\": \"请先登录\"}");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().write("{\"success\": false, \"message\": \"两次输入的新密码不一致\"}");
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String checkSql = "SELECT password FROM user1 WHERE username = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, username);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        String currentPassword = rs.getString("password");
                        
                        if (!currentPassword.equals(oldPassword)) {
                            response.getWriter().write("{\"success\": false, \"message\": \"原密码不正确\"}");
                            return;
                        }
                        
                        String updateSql = "UPDATE user1 SET password = ? WHERE username = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                            updateStmt.setString(1, newPassword);
                            updateStmt.setString(2, username);
                            updateStmt.executeUpdate();
                        }
                        
                        response.getWriter().write("{\"success\": true, \"message\": \"密码修改成功\"}");
                    } else {
                        response.getWriter().write("{\"success\": false, \"message\": \"用户不存在\"}");
                    }
                }
            }
        } catch (SQLException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"数据库操作失败\"}");
        }
    }
}