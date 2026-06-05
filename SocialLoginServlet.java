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

@WebServlet("/socialLogin")
public class SocialLoginServlet extends HttpServlet {

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
        
        String platform = request.getParameter("platform");
        
        if (platform == null || (!platform.equals("qq") && !platform.equals("wechat"))) {
            response.sendRedirect("index.jsp?error=invalid");
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String nickname = generateNickname(platform);
            String avatar = generateAvatar(platform, nickname);
            
            String checkSql = "SELECT * FROM user1 WHERE username = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, nickname);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("username", rs.getString("username"));
                        session.setAttribute("email", rs.getString("email"));
                        session.setAttribute("avatar", rs.getString("avatar"));
                        response.sendRedirect("welcome.jsp");
                    } else {
                        String insertSql = "INSERT INTO user1 (username, password, email, avatar) VALUES (?, ?, ?, ?)";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setString(1, nickname);
                            insertStmt.setString(2, "");
                            insertStmt.setString(3, nickname + "@social.com");
                            insertStmt.setString(4, avatar);
                            insertStmt.executeUpdate();
                            
                            HttpSession session = request.getSession();
                            session.setAttribute("username", nickname);
                            session.setAttribute("email", nickname + "@social.com");
                            session.setAttribute("avatar", avatar);
                            response.sendRedirect("welcome.jsp");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
        }
    }

    private String generateNickname(String platform) {
        String prefix = platform.equals("qq") ? "QQ_" : "WX_";
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            sb.append(chars.charAt((int) (Math.random() * chars.length())));
        }
        return prefix + sb.toString();
    }

    private String generateAvatar(String platform, String nickname) {
        String[] qqColors = {
            "linear-gradient(135deg, #12B7F5 0%, #0E8CE4 100%)",
            "linear-gradient(135deg, #00D4FF 0%, #0099CC 100%)",
            "linear-gradient(135deg, #67C23A 0%, #5EB838 100%)"
        };
        
        String[] wechatColors = {
            "linear-gradient(135deg, #07C160 0%, #06AD56 100%)",
            "linear-gradient(135deg, #10B981 0%, #059669 100%)",
            "linear-gradient(135deg, #34D399 0%, #10B981 100%)"
        };
        
        String[] colors = platform.equals("qq") ? qqColors : wechatColors;
        int hash = nickname.hashCode();
        int colorIndex = Math.abs(hash) % colors.length;
        String initial = platform.equals("qq") ? "Q" : "W";
        
        return colors[colorIndex] + "," + initial;
    }
}