package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/qqLogin")
public class QQLoginServlet extends HttpServlet {

    private String url;
    private String user;
    private String password;
    private String driver;
    
    private static final String QQ_APP_ID = "101892830";
    private static final String QQ_APP_KEY = "e62858c2b7415d953375626c7d1c07d0";
    private static final String QQ_REDIRECT_URI = "http://localhost:8080/project_01/qqCallback";

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
        String code = request.getParameter("code");
        
        if (code == null || code.isEmpty()) {
            response.sendRedirect("index.jsp?error=qq_login_failed");
            return;
        }

        try {
            String accessToken = getAccessToken(code);
            if (accessToken == null) {
                response.sendRedirect("index.jsp?error=qq_login_failed");
                return;
            }

            String openId = getOpenId(accessToken);
            if (openId == null) {
                response.sendRedirect("index.jsp?error=qq_login_failed");
                return;
            }

            String userInfo = getUserInfo(accessToken, openId);
            String nickname = parseNickname(userInfo);
            String avatarUrl = parseAvatarUrl(userInfo);

            if (nickname == null) {
                nickname = "QQ_" + openId.substring(0, 8);
            }

            try (Connection conn = DriverManager.getConnection(url, user, password)) {
                String checkSql = "SELECT * FROM user1 WHERE username = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setString(1, nickname);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        String avatar = generateAvatar(nickname, avatarUrl);
                        
                        if (rs.next()) {
                            String updateSql = "UPDATE user1 SET avatar = ? WHERE username = ?";
                            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                                updateStmt.setString(1, avatar);
                                updateStmt.setString(2, nickname);
                                updateStmt.executeUpdate();
                            }
                            
                            HttpSession session = request.getSession();
                            session.setAttribute("username", nickname);
                            session.setAttribute("email", rs.getString("email"));
                            session.setAttribute("avatar", avatar);
                        } else {
                            String insertSql = "INSERT INTO user1 (username, password, email, avatar) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                                insertStmt.setString(1, nickname);
                                insertStmt.setString(2, "");
                                insertStmt.setString(3, nickname + "@qq.com");
                                insertStmt.setString(4, avatar);
                                insertStmt.executeUpdate();
                                
                                HttpSession session = request.getSession();
                                session.setAttribute("username", nickname);
                                session.setAttribute("email", nickname + "@qq.com");
                                session.setAttribute("avatar", avatar);
                            }
                        }
                        
                        response.sendRedirect("welcome.jsp");
                    }
                }
            } catch (SQLException e) {
                throw new ServletException("数据库操作失败", e);
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp?error=qq_login_failed");
        }
    }

    private String getAccessToken(String code) throws Exception {
        String urlStr = "https://graph.qq.com/oauth2.0/token?" +
                "grant_type=authorization_code" +
                "&client_id=" + QQ_APP_ID +
                "&client_secret=" + QQ_APP_KEY +
                "&code=" + code +
                "&redirect_uri=" + URLEncoder.encode(QQ_REDIRECT_URI, "UTF-8");
        
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();
        
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        
        String result = response.toString();
        if (result.contains("access_token=")) {
            String[] parts = result.split("&");
            for (String part : parts) {
                if (part.startsWith("access_token=")) {
                    return part.substring("access_token=".length());
                }
            }
        }
        return null;
    }

    private String getOpenId(String accessToken) throws Exception {
        String urlStr = "https://graph.qq.com/oauth2.0/me?access_token=" + accessToken;
        
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();
        
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        
        String result = response.toString();
        int start = result.indexOf("openid\":\"");
        if (start != -1) {
            int end = result.indexOf("\"", start + 9);
            if (end != -1) {
                return result.substring(start + 9, end);
            }
        }
        return null;
    }

    private String getUserInfo(String accessToken, String openId) throws Exception {
        String urlStr = "https://graph.qq.com/user/get_user_info?" +
                "access_token=" + accessToken +
                "&oauth_consumer_key=" + QQ_APP_ID +
                "&openid=" + openId;
        
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        String inputLine;
        StringBuilder response = new StringBuilder();
        
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        
        return response.toString();
    }

    private String parseNickname(String userInfo) {
        int start = userInfo.indexOf("nickname\":\"");
        if (start != -1) {
            int end = userInfo.indexOf("\"", start + 11);
            if (end != -1) {
                return userInfo.substring(start + 11, end);
            }
        }
        return null;
    }

    private String parseAvatarUrl(String userInfo) {
        int start = userInfo.indexOf("figureurl_qq_1\":\"");
        if (start != -1) {
            int end = userInfo.indexOf("\"", start + 18);
            if (end != -1) {
                return userInfo.substring(start + 18, end);
            }
        }
        return null;
    }

    private String generateAvatar(String nickname, String avatarUrl) {
        String[] qqColors = {
            "linear-gradient(135deg, #12B7F5 0%, #0E8CE4 100%)",
            "linear-gradient(135deg, #00D4FF 0%, #0099CC 100%)",
            "linear-gradient(135deg, #67C23A 0%, #5EB838 100%)"
        };
        
        int hash = nickname.hashCode();
        int colorIndex = Math.abs(hash) % qqColors.length;
        String initial = "Q";
        
        if (avatarUrl != null && !avatarUrl.isEmpty()) {
            return "url(" + avatarUrl + ")";
        }
        
        return qqColors[colorIndex] + "," + initial;
    }
}