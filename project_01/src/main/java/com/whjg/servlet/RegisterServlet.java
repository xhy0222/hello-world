package com.whjg.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

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
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String pwd = request.getParameter("password");
        String confirmPwd = request.getParameter("confirmPassword");

        if (username == null || username.isEmpty() || 
            email == null || email.isEmpty() || 
            pwd == null || pwd.isEmpty()) {
            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        if (!pwd.equals(confirmPwd)) {
            response.sendRedirect("register.jsp?error=mismatch");
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "INSERT INTO user1 (username, password, email) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, pwd);
                stmt.setString(3, email);
                stmt.executeUpdate();
            }
            response.sendRedirect("index.jsp?success=registered");
        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate entry")) {
                response.sendRedirect("register.jsp?error=exists");
            } else {
                throw new ServletException("数据库操作失败", e);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}