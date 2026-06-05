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

        String avatar = generateDefaultAvatar(username);

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "INSERT INTO user1 (username, password, email, avatar) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, pwd);
                stmt.setString(3, email);
                stmt.setString(4, avatar);
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

    private String generateDefaultAvatar(String username) {
        String[] colors = {
            "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
            "linear-gradient(135deg, #f093fb 0%, #f5576c 100%)",
            "linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)",
            "linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)",
            "linear-gradient(135deg, #fa709a 0%, #fee140 100%)",
            "linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)",
            "linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)",
            "linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)"
        };
        
        int hash = username.hashCode();
        int colorIndex = Math.abs(hash) % colors.length;
        String initial = username.length() > 0 ? username.substring(0, 1).toUpperCase() : "U";
        
        return colors[colorIndex] + "," + initial;
    }
}