package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/whjg?useSSL=false&serverTimezone=UTC&characterEncoding=utf8";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("getUsers".equals(action)) {
            getUsers(request, response);
        } else if ("getReports".equals(action)) {
            getReports(request, response);
        } else if ("getStats".equals(action)) {
            getStats(request, response);
        } else if ("logout".equals(action)) {
            logout(request, response);
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"无效的操作\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            updateReportStatus(request, response);
        } else if ("toggleUser".equals(action)) {
            toggleUserStatus(request, response);
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"无效的操作\"}");
        }
    }

    private void getUsers(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> users = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT username, email, status, created_at FROM user1")) {
            
            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("username", rs.getString("username"));
                user.put("email", rs.getString("email"));
                user.put("status", rs.getString("status"));
                user.put("createdAt", rs.getString("created_at"));
                users.add(user);
            }
            
            response.getWriter().write("{\"success\": true, \"users\": " + toJson(users) + "}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"数据库查询失败\"}");
        }
    }

    private void getReports(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> reports = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, type, problem, address, reporter, status, created_at FROM reports ORDER BY created_at DESC")) {
            
            while (rs.next()) {
                Map<String, Object> report = new HashMap<>();
                report.put("id", rs.getInt("id"));
                report.put("type", rs.getString("type"));
                report.put("problem", rs.getString("problem"));
                report.put("address", rs.getString("address"));
                report.put("reporter", rs.getString("reporter"));
                report.put("status", rs.getString("status"));
                report.put("createdAt", rs.getString("created_at"));
                reports.add(report);
            }
            
            response.getWriter().write("{\"success\": true, \"reports\": " + toJson(reports) + "}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"数据库查询失败\"}");
        }
    }

    private void getStats(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> stats = new HashMap<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement()) {
            
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM user1");
            if (rs.next()) {
                stats.put("userCount", rs.getInt("count"));
            }
            
            rs = stmt.executeQuery("SELECT COUNT(*) as count FROM reports");
            if (rs.next()) {
                stats.put("reportCount", rs.getInt("count"));
            }
            
            rs = stmt.executeQuery("SELECT COUNT(*) as count FROM reports WHERE status = 'pending'");
            if (rs.next()) {
                stats.put("pendingCount", rs.getInt("count"));
            }
            
            rs = stmt.executeQuery("SELECT COUNT(*) as count FROM reports WHERE status = 'completed'");
            if (rs.next()) {
                stats.put("completedCount", rs.getInt("count"));
            }
            
            response.getWriter().write("{\"success\": true, " + toJsonFields(stats) + "}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"数据库查询失败\"}");
        }
    }

    private void updateReportStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String remark = request.getParameter("remark");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE reports SET status = ?, remark = ?, updated_at = NOW() WHERE id = ?")) {
            
            pstmt.setString(1, status);
            pstmt.setString(2, remark);
            pstmt.setInt(3, id);
            
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"状态更新成功\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"报修单不存在\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"数据库更新失败\"}");
        }
    }

    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String status = request.getParameter("status");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE user1 SET status = ? WHERE username = ?")) {
            
            pstmt.setString(1, status);
            pstmt.setString(2, username);
            
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"操作成功\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"用户不存在\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"数据库更新失败\"}");
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.getWriter().write("{\"success\": true}");
    }

    private String toJson(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append("{");
            Map<String, Object> map = list.get(i);
            int j = 0;
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if (j > 0) sb.append(",");
                sb.append("\"").append(entry.getKey()).append("\":");
                Object value = entry.getValue();
                if (value == null) {
                    sb.append("null");
                } else if (value instanceof String) {
                    sb.append("\"").append(escapeJson((String) value)).append("\"");
                } else {
                    sb.append(value);
                }
                j++;
            }
            sb.append("}");
        }
        sb.append("]");
        return sb.toString();
    }

    private String toJsonFields(Map<String, Object> map) {
        StringBuilder sb = new StringBuilder();
        int i = 0;
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            if (i > 0) sb.append(",");
            sb.append("\"").append(entry.getKey()).append("\":");
            Object value = entry.getValue();
            if (value == null) {
                sb.append("null");
            } else if (value instanceof String) {
                sb.append("\"").append(escapeJson((String) value)).append("\"");
            } else {
                sb.append(value);
            }
            i++;
        }
        return sb.toString();
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r");
    }
}