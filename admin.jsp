<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员后台 - 宿舍/校园报修系统</title>
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
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
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
        }

        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            padding: 24px 0;
            flex-shrink: 0;
            box-shadow: var(--shadow-lg);
        }

        .sidebar .logo {
            color: white;
            font-size: 18px;
            font-weight: 700;
            padding: 0 24px;
            margin-bottom: 32px;
            text-align: center;
        }

        .sidebar .nav-item {
            display: flex;
            align-items: center;
            padding: 14px 24px;
            color: rgba(255, 255, 255, 0.9);
            cursor: pointer;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
        }

        .sidebar .nav-item:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .sidebar .nav-item.active {
            background: rgba(255, 255, 255, 0.15);
            border-left-color: white;
        }

        .sidebar .nav-item .icon {
            margin-right: 12px;
            font-size: 18px;
        }

        .sidebar .logout {
            position: absolute;
            bottom: 24px;
            width: 250px;
            padding: 14px 24px;
            color: rgba(255, 255, 255, 0.7);
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .sidebar .logout:hover {
            color: white;
            background: rgba(255, 255, 255, 0.1);
        }

        .main-content {
            flex: 1;
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
            font-size: 20px;
            font-weight: 700;
            color: var(--primary-dark);
        }

        .header .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        .content-area {
            flex: 1;
            padding: 24px;
            overflow-y: auto;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 24px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .stat-card .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-card .stat-icon.users {
            background: rgba(71, 85, 105, 0.1);
            color: var(--primary-color);
        }

        .stat-card .stat-icon.reports {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stat-card .stat-icon.pending {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .stat-card .stat-icon.completed {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stat-card .stat-info .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
        }

        .stat-card .stat-info .stat-label {
            font-size: 14px;
            color: var(--text-secondary);
            margin-top: 4px;
        }

        .data-table {
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .table-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-gray);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h3 {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .search-box {
            padding: 10px 14px;
            border: 2px solid var(--border-gray);
            border-radius: 10px;
            font-size: 14px;
            width: 200px;
            transition: all 0.2s ease;
        }

        .search-box:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 16px 24px;
            text-align: left;
            border-bottom: 1px solid var(--border-gray);
        }

        th {
            background: var(--bg-gray);
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 14px;
        }

        tr:hover {
            background: rgba(71, 85, 105, 0.03);
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-badge.pending {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .status-badge.processing {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .status-badge.completed {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .action-btn {
            padding: 6px 14px;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-right: 8px;
        }

        .action-btn.edit {
            background: var(--primary-color);
            color: white;
        }

        .action-btn.edit:hover {
            background: var(--primary-dark);
        }

        .action-btn.delete {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .action-btn.delete:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 24px;
            width: 90%;
            max-width: 500px;
            box-shadow: var(--shadow-lg);
        }

        .modal h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text-primary);
        }

        .modal .form-group {
            margin-bottom: 16px;
        }

        .modal .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-primary);
        }

        .modal .form-group select {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid var(--border-gray);
            border-radius: 10px;
            font-size: 14px;
            background: white;
        }

        .modal .form-group textarea {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid var(--border-gray);
            border-radius: 10px;
            font-size: 14px;
            min-height: 100px;
            resize: vertical;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
        }

        .modal-actions button {
            padding: 10px 24px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .modal-actions .cancel-btn {
            background: var(--bg-gray);
            color: var(--text-secondary);
        }

        .modal-actions .cancel-btn:hover {
            background: var(--border-gray);
        }

        .modal-actions .confirm-btn {
            background: var(--primary-color);
            color: white;
        }

        .modal-actions .confirm-btn:hover {
            background: var(--primary-dark);
        }

        .empty-state {
            text-align: center;
            padding: 60px 24px;
            color: var(--text-secondary);
        }

        .empty-state .icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: fixed;
                left: -100%;
                z-index: 999;
                height: 100vh;
            }

            .sidebar.show {
                left: 0;
            }

            .main-content {
                width: 100%;
            }

            th, td {
                padding: 12px 8px;
                font-size: 12px;
            }

            .action-btn {
                padding: 4px 8px;
                font-size: 11px;
                margin-right: 4px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <div class="sidebar" id="sidebar">
        <div class="logo">管理员后台</div>
        <div class="nav-item active" id="nav-users" onclick="showTab('users')">
            <span class="icon">👥</span>
            <span>用户管理</span>
        </div>
        <div class="nav-item" id="nav-reports" onclick="showTab('reports')">
            <span class="icon">📋</span>
            <span>报修管理</span>
        </div>
        <div class="logout" onclick="logout()">
            <span>🔓 退出登录</span>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <h1 class="title" id="page-title">用户管理</h1>
            <div class="user-info">
                <div class="user-avatar">A</div>
                <span>管理员</span>
            </div>
        </div>

        <div class="content-area">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon users">👥</div>
                    <div class="stat-info">
                        <div class="stat-value" id="stat-users">0</div>
                        <div class="stat-label">总用户数</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon reports">📋</div>
                    <div class="stat-info">
                        <div class="stat-value" id="stat-reports">0</div>
                        <div class="stat-label">总报修单</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon pending">⏳</div>
                    <div class="stat-info">
                        <div class="stat-value" id="stat-pending">0</div>
                        <div class="stat-label">待处理</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon completed">✅</div>
                    <div class="stat-info">
                        <div class="stat-value" id="stat-completed">0</div>
                        <div class="stat-label">已完成</div>
                    </div>
                </div>
            </div>

            <div class="tab-content" id="tab-users">
                <div class="data-table">
                    <div class="table-header">
                        <h3>用户列表</h3>
                        <input type="text" class="search-box" placeholder="搜索用户名..." id="user-search">
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>用户名</th>
                                <th>邮箱</th>
                                <th>注册时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="user-table-body">
                            <tr>
                                <td colspan="5" class="empty-state">
                                    <div class="icon">🔍</div>
                                    加载中...
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="tab-content" id="tab-reports" style="display: none;">
                <div class="data-table">
                    <div class="table-header">
                        <h3>报修单列表</h3>
                        <input type="text" class="search-box" placeholder="搜索报修内容..." id="report-search">
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>报修类型</th>
                                <th>问题描述</th>
                                <th>报修地址</th>
                                <th>提交人</th>
                                <th>状态</th>
                                <th>提交时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="report-table-body">
                            <tr>
                                <td colspan="7" class="empty-state">
                                    <div class="icon">🔍</div>
                                    加载中...
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="status-modal">
        <div class="modal">
            <h3>修改报修状态</h3>
            <input type="hidden" id="report-id">
            <div class="form-group">
                <label for="status-select">选择状态</label>
                <select id="status-select">
                    <option value="pending">待处理</option>
                    <option value="processing">处理中</option>
                    <option value="completed">已完成</option>
                </select>
            </div>
            <div class="form-group">
                <label for="remark">处理备注</label>
                <textarea id="remark" placeholder="请输入处理备注（可选）"></textarea>
            </div>
            <div class="modal-actions">
                <button class="cancel-btn" onclick="closeModal()">取消</button>
                <button class="confirm-btn" onclick="updateReportStatus()">确认修改</button>
            </div>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(tab => tab.style.display = 'none');
            
            document.getElementById('nav-' + tabName).classList.add('active');
            document.getElementById('tab-' + tabName).style.display = 'block';
            
            if (tabName === 'users') {
                document.getElementById('page-title').textContent = '用户管理';
                loadUsers();
            } else {
                document.getElementById('page-title').textContent = '报修管理';
                loadReports();
            }
        }

        function loadUsers() {
            fetch('admin?action=getUsers')
                .then(response => response.json())
                .then(data => {
                    const tbody = document.getElementById('user-table-body');
                    if (data.success && data.users.length > 0) {
                        tbody.innerHTML = data.users.map(user => `
                            <tr>
                                <td>${escapeHtml(user.username)}</td>
                                <td>${escapeHtml(user.email)}</td>
                                <td>${user.createdAt || '-'}</td>
                                <td><span class="status-badge ${user.status === 'active' ? 'completed' : 'pending'}">${user.status === 'active' ? '正常' : '禁用'}</span></td>
                                <td>
                                    <button class="action-btn ${user.status === 'active' ? 'delete' : 'edit'}" onclick="toggleUserStatus('${user.username}', '${user.status}')">
                                        ${user.status === 'active' ? '禁用' : '启用'}
                                    </button>
                                </td>
                            </tr>
                        `).join('');
                    } else {
                        tbody.innerHTML = '<tr><td colspan="5" class="empty-state"><div class="icon">👥</div>暂无用户数据</td></tr>';
                    }
                })
                .catch(() => {
                    document.getElementById('user-table-body').innerHTML = '<tr><td colspan="5" class="empty-state"><div class="icon">❌</div>加载失败</td></tr>';
                });
        }

        function loadReports() {
            fetch('admin?action=getReports')
                .then(response => response.json())
                .then(data => {
                    const tbody = document.getElementById('report-table-body');
                    if (data.success && data.reports.length > 0) {
                        tbody.innerHTML = data.reports.map(report => `
                            <tr>
                                <td>${escapeHtml(report.type || '其他')}</td>
                                <td>${escapeHtml(report.problem).substring(0, 30)}${report.problem.length > 30 ? '...' : ''}</td>
                                <td>${escapeHtml(report.address || '-')}</td>
                                <td>${escapeHtml(report.reporter || '-')}</td>
                                <td><span class="status-badge ${report.status}">${getStatusText(report.status)}</span></td>
                                <td>${report.createdAt || '-'}</td>
                                <td>
                                    <button class="action-btn edit" onclick="openStatusModal('${report.id}', '${report.status}')">修改状态</button>
                                </td>
                            </tr>
                        `).join('');
                    } else {
                        tbody.innerHTML = '<tr><td colspan="7" class="empty-state"><div class="icon">📋</div>暂无报修单数据</td></tr>';
                    }
                })
                .catch(() => {
                    document.getElementById('report-table-body').innerHTML = '<tr><td colspan="7" class="empty-state"><div class="icon">❌</div>加载失败</td></tr>';
                });
        }

        function loadStats() {
            fetch('admin?action=getStats')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('stat-users').textContent = data.userCount || 0;
                        document.getElementById('stat-reports').textContent = data.reportCount || 0;
                        document.getElementById('stat-pending').textContent = data.pendingCount || 0;
                        document.getElementById('stat-completed').textContent = data.completedCount || 0;
                    }
                });
        }

        function openStatusModal(reportId, currentStatus) {
            document.getElementById('report-id').value = reportId;
            document.getElementById('status-select').value = currentStatus;
            document.getElementById('remark').value = '';
            document.getElementById('status-modal').classList.add('show');
        }

        function closeModal() {
            document.getElementById('status-modal').classList.remove('show');
        }

        function updateReportStatus() {
            const reportId = document.getElementById('report-id').value;
            const status = document.getElementById('status-select').value;
            const remark = document.getElementById('remark').value;

            fetch('admin?action=updateStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'id=' + encodeURIComponent(reportId) +
                       '&status=' + encodeURIComponent(status) +
                       '&remark=' + encodeURIComponent(remark)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('状态更新成功');
                    closeModal();
                    loadReports();
                    loadStats();
                } else {
                    alert('更新失败: ' + data.message);
                }
            })
            .catch(() => {
                alert('更新失败');
            });
        }

        function toggleUserStatus(username, currentStatus) {
            const newStatus = currentStatus === 'active' ? 'disabled' : 'active';
            if (!confirm(`确定要${newStatus === 'active' ? '启用' : '禁用'}用户 ${username} 吗？`)) {
                return;
            }

            fetch('admin?action=toggleUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'username=' + encodeURIComponent(username) +
                       '&status=' + encodeURIComponent(newStatus)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('操作成功');
                    loadUsers();
                } else {
                    alert('操作失败: ' + data.message);
                }
            })
            .catch(() => {
                alert('操作失败');
            });
        }

        function logout() {
            if (confirm('确定要退出管理员登录吗？')) {
                fetch('admin?action=logout')
                    .then(() => {
                        window.location.href = 'index.jsp';
                    });
            }
        }

        function getStatusText(status) {
            const map = {
                'pending': '待处理',
                'processing': '处理中',
                'completed': '已完成'
            };
            return map[status] || '未知';
        }

        function escapeHtml(text) {
            if (!text) return '';
            return text.replace(/&/g, '&amp;')
                       .replace(/</g, '&lt;')
                       .replace(/>/g, '&gt;')
                       .replace(/"/g, '&quot;');
        }

        document.getElementById('user-search').addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            document.querySelectorAll('#user-table-body tr').forEach(row => {
                const username = row.querySelector('td:first-child').textContent.toLowerCase();
                row.style.display = username.includes(searchText) ? '' : 'none';
            });
        });

        document.getElementById('report-search').addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            document.querySelectorAll('#report-table-body tr').forEach(row => {
                const problem = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                row.style.display = problem.includes(searchText) ? '' : 'none';
            });
        });

        window.addEventListener('click', function(e) {
            if (e.target.classList.contains('modal-overlay')) {
                closeModal();
            }
        });

        loadUsers();
        loadStats();
    </script>
</body>
</html>