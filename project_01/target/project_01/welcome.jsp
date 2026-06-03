<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>欢迎回来</title>
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
            --green-500: #10b981;
            --purple-500: #8b5cf6;
            --orange-500: #f97316;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--gray-50);
            min-height: 100vh;
        }

        .header {
            background: white;
            border-bottom: 1px solid var(--gray-200);
            padding: 16px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .logo {
            font-size: 20px;
            font-weight: 700;
            color: var(--blue-600);
        }

        .header .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--blue-500), var(--purple-500));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        .header .user-name {
            font-weight: 600;
            color: var(--gray-800);
        }

        .header .logout-btn {
            padding: 8px 16px;
            background: var(--gray-100);
            border: none;
            border-radius: 6px;
            color: var(--gray-600);
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .header .logout-btn:hover {
            background: var(--gray-200);
            color: var(--gray-800);
        }

        .main-content {
            padding: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .welcome-section {
            background: linear-gradient(135deg, var(--blue-600) 0%, var(--purple-500) 100%);
            border-radius: 16px;
            padding: 40px;
            color: white;
            margin-bottom: 32px;
        }

        .welcome-section h1 {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .welcome-section p {
            font-size: 16px;
            opacity: 0.9;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            border: 1px solid var(--gray-100);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .stat-card .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }

        .stat-card .stat-icon svg {
            width: 24px;
            height: 24px;
            fill: white;
        }

        .stat-card.blue .stat-icon {
            background: linear-gradient(135deg, var(--blue-500), var(--blue-600));
        }

        .stat-card.green .stat-icon {
            background: linear-gradient(135deg, var(--green-500), #059669);
        }

        .stat-card.purple .stat-icon {
            background: linear-gradient(135deg, var(--purple-500), #7c3aed);
        }

        .stat-card.orange .stat-icon {
            background: linear-gradient(135deg, var(--orange-500), #ea580c);
        }

        .stat-card .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 4px;
        }

        .stat-card .stat-label {
            font-size: 14px;
            color: var(--gray-500);
        }

        .quick-actions {
            background: white;
            border-radius: 12px;
            padding: 24px;
            border: 1px solid var(--gray-100);
        }

        .quick-actions h2 {
            font-size: 18px;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 20px;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .action-btn {
            padding: 20px;
            border: 1px solid var(--gray-200);
            border-radius: 12px;
            background: white;
            cursor: pointer;
            text-align: left;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            border-color: var(--blue-500);
            background: rgba(59, 130, 246, 0.05);
            transform: translateY(-2px);
        }

        .action-btn .action-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--gray-100);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            transition: all 0.3s ease;
        }

        .action-btn:hover .action-icon {
            background: var(--blue-500);
        }

        .action-btn .action-icon svg {
            width: 20px;
            height: 20px;
            fill: var(--gray-600);
            transition: all 0.3s ease;
        }

        .action-btn:hover .action-icon svg {
            fill: white;
        }

        .action-btn .action-title {
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 4px;
        }

        .action-btn .action-desc {
            font-size: 13px;
            color: var(--gray-500);
        }

        @media (max-width: 900px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .actions-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .header {
                padding: 12px 16px;
            }

            .main-content {
                padding: 20px;
            }

            .welcome-section h1 {
                font-size: 28px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">管理系统</div>
        <div class="user-info">
            <div class="user-avatar">U</div>
            <span class="user-name">欢迎回来，用户</span>
            <button class="logout-btn" onclick="location.href='index.jsp'">退出登录</button>
        </div>
    </div>

    <div class="main-content">
        <div class="welcome-section">
            <h1>欢迎回来！</h1>
            <p>今天是个美好的日子，祝您工作愉快</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card blue">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                    </svg>
                </div>
                <div class="stat-value">1,234</div>
                <div class="stat-label">总用户数</div>
            </div>

            <div class="stat-card green">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                        <polyline points="22 4 12 14.01 9 11.01"/>
                    </svg>
                </div>
                <div class="stat-value">567</div>
                <div class="stat-label">今日访问</div>
            </div>

            <div class="stat-card purple">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 11V7a4 4 0 0 0-8 0v4M5 9h14l1 12H4L5 9"/>
                    </svg>
                </div>
                <div class="stat-value">89</div>
                <div class="stat-label">待处理任务</div>
            </div>

            <div class="stat-card orange">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"/>
                        <polyline points="12 6 12 12 16 14"/>
                    </svg>
                </div>
                <div class="stat-value">98%</div>
                <div class="stat-label">系统运行</div>
            </div>
        </div>

        <div class="quick-actions">
            <h2>快捷操作</h2>
            <div class="actions-grid">
                <button class="action-btn">
                    <div class="action-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 4v16m8-8H4"/>
                        </svg>
                    </div>
                    <div class="action-title">新建任务</div>
                    <div class="action-desc">创建新的工作任务</div>
                </button>

                <button class="action-btn">
                    <div class="action-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                    </div>
                    <div class="action-title">添加用户</div>
                    <div class="action-desc">添加新的系统用户</div>
                </button>

                <button class="action-btn">
                    <div class="action-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                            <path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                        </svg>
                    </div>
                    <div class="action-title">查看报告</div>
                    <div class="action-desc">生成数据分析报告</div>
                </button>

                <button class="action-btn">
                    <div class="action-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                            <line x1="9" y1="9" x2="15" y2="9"/>
                            <line x1="9" y1="15" x2="15" y2="15"/>
                        </svg>
                    </div>
                    <div class="action-title">系统设置</div>
                    <div class="action-desc">配置系统参数</div>
                </button>

                <button class="action-btn">
                    <div class="action-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/>
                        </svg>
                    </div>
                    <div class="action-title">快速审批</div>
                    <div class="action-desc">审批待处理事项</div>
                </button>

                <button class="action-btn">
                    <div class="action-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 8v4l3 3"/>
                            <circle cx="12" cy="12" r="10"/>
                        </svg>
                    </div>
                    <div class="action-title">日程安排</div>
                    <div class="action-desc">查看今日日程</div>
                </button>
            </div>
        </div>
    </div>
</body>
</html>