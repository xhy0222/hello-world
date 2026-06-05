package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/sendReport")
public class SendReportServlet extends HttpServlet {

    private String smtpHost;
    private String smtpPort;
    private String smtpUser;
    private String smtpPassword;

    @Override
    public void init() throws ServletException {
        Properties props = new Properties();
        try {
            java.io.InputStream is = getClass().getClassLoader().getResourceAsStream("email.properties");
            if (is != null) {
                props.load(is);
                is.close();
                smtpHost = props.getProperty("smtp.host", "smtp.qq.com");
                smtpPort = props.getProperty("smtp.port", "587");
                smtpUser = props.getProperty("smtp.user");
                smtpPassword = props.getProperty("smtp.password");
                System.out.println("Email config loaded from file: " + smtpUser);
            } else {
                System.out.println("Email config file not found in classpath");
                setDefaultConfig();
            }
        } catch (Exception e) {
            System.out.println("Error loading email config: " + e.getMessage());
            setDefaultConfig();
        }
    }
    
    private void setDefaultConfig() {
        smtpHost = "smtp.qq.com";
        smtpPort = "587";
        smtpUser = "2862924572@qq.com";
        smtpPassword = "dipgiswhqjrddcfb";
        System.out.println("Using default email config: " + smtpUser);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String reportType = request.getParameter("reportType");
        String problem = request.getParameter("problem");
        String address = request.getParameter("address");
        String reporter = request.getParameter("reporter");
        String email = request.getParameter("email");
        
        if (problem == null || problem.isEmpty() || email == null || email.isEmpty()) {
            response.getWriter().write("{\"success\": false, \"message\": \"参数不全\"}");
            return;
        }
        
        if (reportType == null || reportType.isEmpty()) {
            reportType = "其他";
        }
        
        String subject = "报修申请确认 - 宿舍/校园报修系统";
        String content = "<!DOCTYPE html>" +
                         "<html><head><meta charset='UTF-8'></head><body>" +
                         "<h2>报修申请已提交</h2>" +
                         "<p>尊敬的用户，您的报修申请已成功提交，以下是报修详情：</p>" +
                         "<table border='1' cellpadding='10' style='border-collapse: collapse;'>" +
                         "<tr><td style='font-weight: bold;'>报修类型</td><td>" + escapeHtml(reportType) + "</td></tr>" +
                         "<tr><td style='font-weight: bold;'>报修地址</td><td>" + escapeHtml(address) + "</td></tr>" +
                         "<tr><td style='font-weight: bold;'>提交人</td><td>" + escapeHtml(reporter) + "</td></tr>" +
                         "<tr><td style='font-weight: bold;'>问题描述</td><td>" + escapeHtml(problem) + "</td></tr>" +
                         "<tr><td style='font-weight: bold;'>提交时间</td><td>" + new java.util.Date().toString() + "</td></tr>" +
                         "</table>" +
                         "<p style='margin-top: 20px;'>我们会尽快处理您的报修申请，请保持手机畅通。</p>" +
                         "<p>宿舍/校园报修系统</p>" +
                         "</body></html>";
        boolean emailSent = sendEmail(email, subject, content);
        
        if (emailSent) {
            response.getWriter().write("{\"success\": true, \"message\": \"报修提交成功，邮件已发送\"}");
        } else {
            response.getWriter().write("{\"success\": true, \"message\": \"报修提交成功，邮件功能未配置\"}");
        }
    }

    private boolean sendEmail(String to, String subject, String content) {
        System.out.println("Attempting to send email to: " + to);
        System.out.println("SMTP Host: " + smtpHost + ", Port: " + smtpPort);
        System.out.println("SMTP User: " + smtpUser);
        
        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.debug", "true");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPassword);
            }
        });
        session.setDebug(true);
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpUser));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=UTF-8");
            
            Transport.send(message);
            System.out.println("Email sent successfully to: " + to);
            return true;
        } catch (Exception e) {
            System.out.println("Email sending failed: " + e.getMessage());
            e.printStackTrace();
            
            System.out.println("Trying fallback to STARTTLS port 587...");
            return sendEmailWithStarttls(to, subject, content);
        }
    }
    
    private boolean sendEmailWithStarttls(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPassword);
            }
        });
        session.setDebug(true);
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpUser));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=UTF-8");
            
            Transport.send(message);
            System.out.println("Email sent successfully with STARTTLS to: " + to);
            return true;
        } catch (Exception e) {
            System.out.println("Email sending with STARTTLS failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
}