<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宿舍/校园报修系统</title>
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
            display: flex;
            flex-direction: column;
        }

        .header {
            background: var(--card-bg);
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
        }

        .header .title {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary-dark);
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            padding: 10px 20px;
            border-radius: 12px;
        }

        .header .user-area {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header .user-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 16px;
            box-shadow: var(--shadow);
        }

        .header .user-info {
            text-align: right;
        }

        .header .user-info .id-label {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .header .user-info .home-btn {
            display: block;
            background: var(--bg-gray);
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 4px;
            font-size: 14px;
            color: var(--primary-dark);
            transition: all 0.2s ease;
        }

        .header .user-info .home-btn:hover {
            background: var(--primary-color);
            color: white;
        }

        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            padding: 24px 32px;
            color: white;
        }

        .welcome-banner h2 {
            font-size: 20px;
            font-weight: 600;
            opacity: 0.95;
        }

        .welcome-banner p {
            font-size: 14px;
            opacity: 0.85;
            margin-top: 4px;
        }

        .main-container {
            flex: 1;
            display: flex;
            padding: 24px;
            gap: 24px;
        }

        .sidebar {
            width: 220px;
            flex-shrink: 0;
        }

        .sidebar .menu-card {
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
        }

        .sidebar .menu-title {
            color: white;
            padding: 16px;
            font-weight: 600;
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
        }

        .sidebar .menu-item {
            color: rgba(255, 255, 255, 0.9);
            padding: 14px 16px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s ease;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar .menu-item:last-child {
            border-bottom: none;
        }

        .sidebar .menu-item:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .sidebar .menu-item.active {
            background: rgba(255, 255, 255, 0.2);
        }

        .sidebar .footer-note {
            margin-top: 16px;
            background: var(--card-bg);
            border-radius: 12px;
            padding: 16px;
            text-align: center;
            font-size: 13px;
            color: var(--text-secondary);
            box-shadow: var(--shadow);
        }

        .content-area {
            flex: 1;
            background: var(--card-bg);
            border-radius: 16px;
            padding: 32px;
            box-shadow: var(--shadow-lg);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: inline-block;
            width: 120px;
            font-weight: 600;
            color: var(--text-primary);
            vertical-align: top;
            font-size: 14px;
        }

        .form-group .form-control {
            display: inline-block;
            width: calc(100% - 130px);
            min-width: 300px;
        }

        .form-group textarea {
            width: 100%;
            height: 120px;
            padding: 14px;
            border: 2px solid var(--border-gray);
            border-radius: 12px;
            font-size: 14px;
            resize: vertical;
            transition: all 0.2s ease;
            background: var(--bg-gray);
        }

        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            background: white;
            box-shadow: 0 0 0 3px rgba(71, 85, 105, 0.1);
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid var(--border-gray);
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.2s ease;
            background: var(--bg-gray);
        }

        .form-group input[type="text"]:focus {
            outline: none;
            border-color: var(--primary-color);
            background: white;
            box-shadow: 0 0 0 3px rgba(71, 85, 105, 0.1);
        }

        .level-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .level-options button {
            padding: 12px 20px;
            border: 2px solid var(--border-gray);
            background: var(--card-bg);
            cursor: pointer;
            font-size: 14px;
            border-radius: 10px;
            transition: all 0.2s ease;
            text-align: center;
            color: var(--text-primary);
        }

        .level-options button:hover {
            border-color: var(--primary-color);
            background: rgba(71, 85, 105, 0.05);
        }

        .level-options button.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        .selected-type {
            display: inline-block;
            padding: 12px 14px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border-radius: 12px;
            font-weight: 600;
            min-width: 100px;
            text-align: center;
            box-shadow: var(--shadow);
        }

        .submit-btn {
            float: right;
            padding: 14px 36px;
            border: none;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            border-radius: 12px;
            transition: all 0.2s ease;
            box-shadow: var(--shadow);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .report-list {
            margin-top: 48px;
            padding-top: 24px;
            border-top: 1px solid var(--border-gray);
        }

        .report-list h3 {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 16px;
        }

        .report-item {
            background: var(--bg-gray);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.2s ease;
        }

        .report-item:hover {
            background: rgba(71, 85, 105, 0.08);
            transform: translateX(4px);
        }

        .report-item .report-content {
            flex: 1;
        }

        .report-item .report-content .title {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 6px;
            font-size: 15px;
        }

        .report-item .report-content .meta {
            font-size: 13px;
            color: var(--text-secondary);
        }

        .report-item .status {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .report-item .status.pending {
            background: rgba(251, 146, 60, 0.1);
            color: #f97316;
        }

        .report-item .status.processing {
            background: rgba(71, 85, 105, 0.15);
            color: var(--primary-dark);
        }

        .report-item .status.completed {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
            }

            .form-group label {
                display: block;
                width: 100%;
                margin-bottom: 8px;
            }

            .form-group .form-control {
                width: 100%;
                min-width: auto;
            }

            .level-options {
                flex-direction: row;
                flex-wrap: wrap;
            }

            .level-options button {
                flex: 1;
                min-width: 120px;
            }

            .content-area {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="title">宿舍/校园报修系统</div>
        <div class="user-area">
            <% 
                String avatar = (String) session.getAttribute("avatar");
                String username = (String) session.getAttribute("username");
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
            <div class="user-avatar" style="background: <%= gradient %>"><%= initial %></div>
            <div class="user-info">
                <div class="id-label">id: <%= username != null ? username : "用户" %></div>
                <button class="home-btn" onclick="location.href='profile.jsp'">个人主页</button>
            </div>
        </div>
    </div>

    <div class="welcome-banner">
        <h2>欢迎来到宿舍/校园报修系统</h2>
        <p>请选择报修类型并填写报修信息</p>
    </div>

    <div class="main-container">
        <div class="sidebar">
            <div class="menu-card">
                <div class="menu-title">报修类型</div>
                <div class="menu-item active" data-type="电器类">电器类</div>
                <div class="menu-item" data-type="家具类">家具类</div>
                <div class="menu-item" data-type="生活类">生活类</div>
            </div>
            <div class="footer-note">报修类型持续更新<br/>敬请期待!</div>
        </div>

        <div class="content-area">
            <div class="form-group">
                <label for="reportType">报修类型:</label>
                <div class="form-control">
                    <div id="reportType" class="selected-type">电器类</div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="problem">我的问题:</label>
                <div class="form-control">
                    <textarea id="problem" name="problem" placeholder="请详细描述您遇到的问题..."></textarea>
                </div>
            </div>

            <div class="form-group">
                <label for="reporter">报修地址:</label>
                <div class="form-control">
                    <input type="text" id="address" name="reporter" placeholder="请输入保修地址">
                </div>
            </div>

            <div class="form-group">
                <label for="reporter">提交人人:</label>
                <div class="form-control">
                    <input type="text" id="reporter" name="reporter" placeholder="请输入提交人姓名">
                </div>
            </div>

            <div class="form-group">
                <label for="email">接收邮箱:</label>
                <div class="form-control">
                    <input type="text" id="email" name="email" placeholder="请输入接收报修结果的邮箱">
                </div>
            </div>

            <button class="submit-btn">提交</button>

            <div class="report-list">
                <h3>我的报修单</h3>
                <div class="report-item">
                    <div class="report-content">
                        <div class="title">宿舍电灯不亮</div>
                        <div class="meta">汇报人: 张三 | 层级: 层级2 | 时间: 2024-01-15</div>
                    </div>
                    <span class="status pending">待处理</span>
                </div>
                <div class="report-item">
                    <div class="report-content">
                        <div class="title">水管漏水</div>
                        <div class="meta">汇报人: 张三 | 层级: 层级1 | 时间: 2024-01-14</div>
                    </div>
                    <span class="status processing">处理中</span>
                </div>
                <div class="report-item">
                    <div class="report-content">
                        <div class="title">空调故障</div>
                        <div class="meta">汇报人: 张三 | 层级: 层级3 | 时间: 2024-01-10</div>
                    </div>
                    <span class="status completed">已完成</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
                
                const reportType = this.getAttribute('data-type');
                document.getElementById('reportType').textContent = reportType;
            });
        });

        document.querySelectorAll('.level-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.level-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        document.querySelector('.submit-btn').addEventListener('click', function() {
            const reportType = document.querySelector('.menu-item.active').getAttribute('data-type');
            const problem = document.getElementById('problem').value;
            const address = document.getElementById('address').value;
            const reporter = document.getElementById('reporter').value;
            const email = document.getElementById('email').value;
            
            if (!problem.trim()) {
                alert('请填写问题描述');
                return;
            }
            
            if (!email.trim()) {
                alert('请输入接收邮箱');
                return;
            }
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('请输入有效的邮箱地址');
                return;
            }
            
            const btn = this;
            const originalText = btn.textContent;
            btn.textContent = '提交中...';
            btn.disabled = true;
            
            fetch('sendReport', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'reportType=' + encodeURIComponent(reportType) +
                       '&problem=' + encodeURIComponent(problem) +
                       '&address=' + encodeURIComponent(address) +
                       '&reporter=' + encodeURIComponent(reporter) +
                       '&email=' + encodeURIComponent(email)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络请求失败');
                }
                return response.json();
            })
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    document.getElementById('problem').value = '';
                    document.getElementById('address').value = '';
                    document.getElementById('reporter').value = '';
                    document.getElementById('email').value = '';
                } else {
                    alert('提交失败: ' + result.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('提交失败，请检查网络连接或联系管理员');
            })
            .finally(() => {
                btn.textContent = originalText;
                btn.disabled = false;
            });
        });
    </script>
</body>
</html>