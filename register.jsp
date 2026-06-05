<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册</title>
    <style>
        :root {
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            --blue-400: #60a5fa;
            --blue-500: #3b82f6;
            --blue-600: #2563eb;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            min-height: 100vh;
            display: flex;
        }

        .hero-section {
            flex: 1;
            background: linear-gradient(135deg, var(--gray-800) 0%, var(--gray-700) 50%, var(--gray-600) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px;
            color: white;
        }

        .hero-content {
            max-width: 450px;
            text-align: center;
        }

        .hero-content h1 {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: -1px;
        }

        .hero-content p {
            font-size: 16px;
            line-height: 1.8;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 40px;
        }

        .hero-features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .feature-item {
            padding: 20px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
        }

        .feature-item:hover {
            transform: translateY(-8px);
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
        }

        .feature-item svg {
            width: 32px;
            height: 32px;
            margin-bottom: 12px;
            fill: rgba(255, 255, 255, 0.9);
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .feature-item:hover svg {
            transform: scale(1.2);
        }

        .feature-item h3 {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .feature-item p {
            font-size: 12px;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 0;
        }

        .login-section {
            width: 500px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }

        .login-container {
            width: 100%;
            max-width: 380px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 8px;
        }

        .login-header p {
            font-size: 14px;
            color: var(--gray-500);
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-600);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid var(--gray-200);
            border-radius: 8px;
            font-size: 15px;
            color: var(--gray-800);
            background: var(--gray-50);
            transition: all 0.2s ease;
            outline: none;
        }

        .form-group input:focus {
            border-color: var(--blue-500);
            background: white;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-group input::placeholder {
            color: var(--gray-400);
        }

        .form-options {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 24px;
            font-size: 14px;
        }

        .form-options label {
            display: flex;
            align-items: center;
            cursor: pointer;
            color: var(--gray-600);
            text-transform: none;
            letter-spacing: normal;
            font-weight: 400;
        }

        .form-options input[type="checkbox"] {
            margin-right: 8px;
            accent-color: var(--blue-500);
        }

        .form-options a {
            color: var(--blue-600);
            text-decoration: none;
            font-weight: 500;
        }

        .form-options a:hover {
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--blue-600) 0%, var(--blue-500) 100%);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-bottom: 24px;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 14px rgba(59, 130, 246, 0.3);
            position: relative;
            overflow: hidden;
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.3s, height 0.3s;
        }

        .login-btn:hover {
            background: linear-gradient(135deg, var(--blue-700) 0%, var(--blue-600) 100%);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
            transform: translateY(-2px);
        }

        .login-btn:active {
            background: linear-gradient(135deg, var(--blue-800) 0%, var(--blue-700) 100%);
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
            transform: translateY(0);
        }

        .login-btn:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3), 0 4px 14px rgba(59, 130, 246, 0.3);
        }

        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            transform: scale(0);
            animation: ripple-animation 0.6s ease-out;
            pointer-events: none;
        }

        @keyframes ripple-animation {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        .divider {
            text-align: center;
            margin-bottom: 24px;
            position: relative;
        }

        .divider::before,
        .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 40%;
            height: 1px;
            background: var(--gray-200);
        }

        .divider::before {
            left: 0;
        }

        .divider::after {
            right: 0;
        }

        .divider span {
            padding: 0 16px;
            color: var(--gray-400);
            font-size: 13px;
        }

        .social-login {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }

        .social-btn {
            flex: 1;
            padding: 12px;
            border: 1px solid var(--gray-200);
            border-radius: 8px;
            background: white;
            cursor: pointer;
            font-size: 14px;
            color: var(--gray-600);
            transition: all 0.2s ease;
        }

        .social-btn:hover {
            border-color: var(--blue-500);
            background: rgba(59, 130, 246, 0.05);
        }

        .signup-link {
            text-align: center;
            font-size: 14px;
            color: var(--gray-500);
        }

        .signup-link a {
            color: var(--blue-600);
            font-weight: 600;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 20px;
            color: var(--error-color);
            font-size: 14px;
            text-align: center;
        }

        .success-message {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.2);
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 20px;
            color: var(--success-color);
            font-size: 14px;
            text-align: center;
        }

        @media (max-width: 900px) {
            body {
                flex-direction: column;
            }

            .hero-section {
                width: 100%;
                padding: 40px 20px;
                min-height: 350px;
            }

            .hero-content h1 {
                font-size: 28px;
            }

            .hero-features {
                grid-template-columns: repeat(3, 1fr);
                gap: 12px;
            }

            .feature-item {
                padding: 16px;
            }

            .login-section {
                width: 100%;
                padding: 30px 20px;
            }
        }

        @media (max-width: 480px) {
            .hero-features {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="hero-section">
        <div class="hero-content">
            <h1>欢迎加入我们</h1>
            <p>创建账户，开启您的智能管理之旅</p>
            <div class="hero-features">
                <div class="feature-item">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                    </svg>
                    <h3>安全可靠</h3>
                    <p>企业级数据加密</p>
                </div>
                <div class="feature-item">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/>
                    </svg>
                    <h3>高效便捷</h3>
                    <p>简化流程提升效率</p>
                </div>
                <div class="feature-item">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"/>
                        <polyline points="12 6 12 12 16 14"/>
                    </svg>
                    <h3>智能分析</h3>
                    <p>数据驱动决策支持</p>
                </div>
            </div>
        </div>
    </div>

    <div class="login-section">
        <div class="login-container">
            <div class="login-header">
                <h1>创建账户</h1>
                <p>填写以下信息开始您的旅程</p>
            </div>

            <% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
            %>

            <% if (error != null && !error.isEmpty()) { %>
                <div class="error-message">
                    <%= error.equals("exists") ? "该用户名或邮箱已被注册" : error.equals("mismatch") ? "两次输入的密码不一致" : "请填写完整信息" %>
                </div>
            <% } %>

            <% if (success != null && success.equals("true")) { %>
                <div class="success-message">
                    注册成功！请登录您的账户
                </div>
            <% } %>

            <form action="register" method="post">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" placeholder="请输入用户名" required>
                </div>

                <div class="form-group">
                    <label for="email">邮箱</label>
                    <input type="email" id="email" name="email" placeholder="请输入邮箱地址" required>
                </div>

                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" id="password" name="password" placeholder="请输入密码" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">确认密码</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="请再次输入密码" required>
                </div>

                <div class="form-options">
                    <label>
                        <input type="checkbox" name="agree" required>
                        我已阅读并同意<a href="#">服务条款</a>和<a href="#">隐私政策</a>
                    </label>
                </div>

                <button type="submit" class="login-btn">注册</button>

                <div class="divider">
                    <span>或</span>
                </div>

                <div class="social-login">
                    <button type="button" class="social-btn">微信</button>
                    <button type="button" class="social-btn">QQ</button>
                </div>
            </form>

            <div class="signup-link">
                已有账户? <a href="index.jsp">立即登录</a>
            </div>
        </div>
        <script>
            document.querySelectorAll('.login-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.classList.add('ripple');
                    
                    this.appendChild(ripple);
                    
                    setTimeout(() => ripple.remove(), 600);
                });
            });
        </script>
    </div>
</body>
</html>