<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心</title>
    <style>
        :root {
            --primary-color: #475569;
            --primary-dark: #334155;
            --primary-light: #64748b;
            --bg-gray: #f1f5f9;
            --card-bg: #ffffff;
            --border-gray: #e2e8f0;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --success-color: #10b981;
            --error-color: #ef4444;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--bg-gray);
            min-height: 100vh;
        }

        .header {
            background: var(--card-bg);
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            margin-bottom: 24px;
        }

        .header .title {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary-dark);
        }

        .header .nav-links {
            display: flex;
            gap: 24px;
        }

        .header .nav-links a {
            text-decoration: none;
            color: var(--text-secondary);
            font-size: 14px;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .header .nav-links a:hover {
            background: var(--bg-gray);
            color: var(--primary-dark);
        }

        .header .nav-links a.active {
            background: var(--primary-color);
            color: white;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 24px;
        }

        .profile-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 32px;
            box-shadow: var(--shadow-lg);
            margin-bottom: 24px;
        }

        .avatar-section {
            text-align: center;
            margin-bottom: 32px;
            padding-bottom: 32px;
            border-bottom: 1px solid var(--border-gray);
        }

        .avatar-container {
            position: relative;
            display: inline-block;
            margin-bottom: 16px;
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            font-weight: 600;
            box-shadow: var(--shadow-lg);
            transition: transform 0.2s ease;
        }

        .avatar:hover {
            transform: scale(1.05);
        }

        .avatar-upload-btn {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            border: 3px solid white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            transition: all 0.2s ease;
            box-shadow: var(--shadow);
        }

        .avatar-upload-btn:hover {
            background: var(--primary-dark);
            transform: scale(1.1);
        }

        #avatar-file {
            display: none;
        }

        .avatar-options {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .avatar-option {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            border: 3px solid transparent;
            transition: all 0.2s ease;
        }

        .avatar-option:hover {
            border-color: var(--primary-color);
            transform: scale(1.1);
        }

        .avatar-option.selected {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(71, 85, 105, 0.2);
        }

        .username {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .email {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .form-section {
            margin-bottom: 32px;
        }

        .form-section h3 {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--border-gray);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group input[type="password"],
        .form-group input[type="text"],
        .form-group input[type="email"] {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid var(--border-gray);
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.2s ease;
            background: var(--bg-gray);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            background: white;
            box-shadow: 0 0 0 3px rgba(71, 85, 105, 0.1);
        }

        .btn {
            padding: 12px 32px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            box-shadow: var(--shadow);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: var(--bg-gray);
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: var(--border-gray);
        }

        .btn-group {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }

        .message {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .message.success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .message.error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .user-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .info-item {
            background: var(--bg-gray);
            padding: 16px;
            border-radius: 12px;
        }

        .info-item label {
            display: block;
            font-size: 12px;
            color: var(--text-secondary);
            margin-bottom: 4px;
        }

        .info-item value {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
        }

        @media (max-width: 600px) {
            .user-info-grid {
                grid-template-columns: 1fr;
            }

            .btn-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="title">个人中心</div>
        <div class="nav-links">
            <a href="welcome.jsp">首页</a>
            <a href="profile.jsp" class="active">个人中心</a>
            <a href="index.jsp">退出登录</a>
        </div>
    </div>

    <div class="container">
        <% 
            String avatar = (String) session.getAttribute("avatar");
            String username = (String) session.getAttribute("username");
            String email = (String) session.getAttribute("email");
            String gradient = "linear-gradient(135deg, #667eea 0%, #764ba2 100%)";
            String initial = "U";
            
            if (avatar != null && !avatar.isEmpty()) {
                String[] parts = avatar.split(",");
                if (parts.length == 2) {
                    gradient = parts[0];
                    initial = parts[1];
                }
            } else if (username != null && !username.isEmpty()) {
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
                gradient = colors[colorIndex];
                initial = username.substring(0, 1).toUpperCase();
            }
        %>

        <% 
            String message = request.getParameter("message");
            String messageType = request.getParameter("messageType");
            if (message != null && !message.isEmpty()) {
        %>
        <div class="message <%= messageType %>">
            <%= message %>
        </div>
        <% } %>

        <div class="profile-card">
            <div class="avatar-section">
                <div class="avatar-container">
                    <div class="avatar" style="background: <%= gradient %>"><%= initial %></div>
                    <label class="avatar-upload-btn" for="avatar-file">+</label>
                    <input type="file" id="avatar-file" accept="image/*">
                </div>
                
                <div class="username"><%= username != null ? username : "用户" %></div>
                <div class="email"><%= email != null ? email : "" %></div>

                <div class="avatar-options">
                    <div class="avatar-option" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)" data-gradient="linear-gradient(135deg, #667eea 0%, #764ba2 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%)" data-gradient="linear-gradient(135deg, #f093fb 0%, #f5576c 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)" data-gradient="linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)" data-gradient="linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%)" data-gradient="linear-gradient(135deg, #fa709a 0%, #fee140 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)" data-gradient="linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)" data-gradient="linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)"></div>
                    <div class="avatar-option" style="background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)" data-gradient="linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)"></div>
                </div>
                <button class="btn btn-primary" id="save-avatar-btn" style="margin-top: 16px;">保存头像</button>
            </div>

            <div class="user-info-grid">
                <div class="info-item">
                    <label>用户名</label>
                    <value><%= username != null ? username : "-" %></value>
                </div>
                <div class="info-item">
                    <label>邮箱</label>
                    <value><%= email != null ? email : "-" %></value>
                </div>
            </div>

            <div class="form-section">
                <h3>修改密码</h3>
                <form id="change-password-form">
                    <div class="form-group">
                        <label for="old-password">原密码</label>
                        <input type="password" id="old-password" name="oldPassword" placeholder="请输入原密码" required>
                    </div>
                    <div class="form-group">
                        <label for="new-password">新密码</label>
                        <input type="password" id="new-password" name="newPassword" placeholder="请输入新密码" required>
                    </div>
                    <div class="form-group">
                        <label for="confirm-password">确认新密码</label>
                        <input type="password" id="confirm-password" name="confirmPassword" placeholder="请再次输入新密码" required>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary" onclick="resetPasswordForm()">重置</button>
                        <button type="submit" class="btn btn-primary">修改密码</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        const currentGradient = '<%= gradient %>';
        
        document.querySelectorAll('.avatar-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.avatar-option').forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');
                
                const gradient = this.getAttribute('data-gradient');
                document.querySelector('.avatar').style.background = gradient;
            });
            
            if (option.getAttribute('data-gradient') === currentGradient) {
                option.classList.add('selected');
            }
        });

        document.getElementById('save-avatar-btn').addEventListener('click', function() {
            const selectedOption = document.querySelector('.avatar-option.selected');
            if (selectedOption) {
                const gradient = selectedOption.getAttribute('data-gradient');
                const initial = '<%= initial %>';
                
                fetch('changeAvatar', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'avatar=' + encodeURIComponent(gradient + ',' + initial)
                })
                .then(response => response.text())
                .then(result => {
                    if (result === 'success') {
                        document.querySelector('.avatar').style.background = gradient;
                        showMessage('头像修改成功', 'success');
                    } else {
                        showMessage('头像修改失败', 'error');
                    }
                })
                .catch(error => {
                    showMessage('头像修改失败', 'error');
                });
            } else {
                showMessage('请先选择一个头像样式', 'error');
            }
        });

        function resetPasswordForm() {
            document.getElementById('change-password-form').reset();
        }

        document.getElementById('change-password-form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const oldPassword = document.getElementById('old-password').value;
            const newPassword = document.getElementById('new-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            
            if (newPassword !== confirmPassword) {
                showMessage('两次输入的新密码不一致', 'error');
                return;
            }
            
            fetch('changePassword', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'oldPassword=' + encodeURIComponent(oldPassword) + 
                       '&newPassword=' + encodeURIComponent(newPassword) + 
                       '&confirmPassword=' + encodeURIComponent(confirmPassword)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    showMessage(result.message, 'success');
                    document.getElementById('change-password-form').reset();
                } else {
                    showMessage(result.message, 'error');
                }
            })
            .catch(error => {
                showMessage('网络请求失败', 'error');
            });
        });

        function showMessage(message, type) {
            let messageDiv = document.querySelector('.message');
            if (messageDiv) {
                messageDiv.remove();
            }
            
            messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + type;
            messageDiv.textContent = message;
            
            const container = document.querySelector('.container');
            container.insertBefore(messageDiv, container.firstChild);
            
            setTimeout(() => {
                messageDiv.remove();
            }, 3000);
        }
    </script>
</body>
</html>