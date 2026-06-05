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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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
        String pwd = request.getParameter("password");

        if (username == null || username.isEmpty() || pwd == null || pwd.isEmpty()) {
            response.sendRedirect("index.jsp?error=empty");
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "SELECT * FROM user1 WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, pwd);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("email", rs.getString("email"));
                        session.setAttribute("avatar", rs.getString("avatar"));
                        response.sendRedirect("welcome.jsp");
                    } else {
                        response.sendRedirect("index.jsp?error=invalid");
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}