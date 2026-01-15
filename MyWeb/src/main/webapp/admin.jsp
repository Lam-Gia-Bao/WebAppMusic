<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- Kiểm tra đăng nhập --%>
<c:if test="${empty sessionScope.user}">
	<c:redirect url="login"/>
</c:if>

<%-- Kiểm tra quyền admin: từ session hoặc fallback theo username --%>
<c:set var="isAdmin" value="${sessionScope.isAdmin}" />
<c:if test="${empty isAdmin and fn:toLowerCase(sessionScope.user) eq 'admin'}">
	<c:set var="isAdmin" value="true" />
</c:if>

<%-- Redirect nếu không phải admin --%>
<c:if test="${not isAdmin}">
	<c:redirect url="login"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BeatFlow</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Admin CSS -->
    <link rel="stylesheet" href="assets/css/admin.css">
</head>
<body>
    <!-- Sidebar -->
    <div class="admin-sidebar" id="sidebar">
        <div class="sidebar-header">
            <img src="assets/img/logo.png" alt="BeatFlow" class="sidebar-logo">
            <span class="sidebar-brand">BeatFlow Admin</span>
        </div>
        
        <nav class="sidebar-nav">
            <a href="#" class="nav-item active" data-section="dashboard">
                <i class="bi bi-speedometer2"></i>
                <span>Dashboard</span>
            </a>
            <a href="#" class="nav-item" data-section="users">
                <i class="bi bi-people"></i>
                <span>Quản lý người dùng</span>
            </a>
            <a href="#" class="nav-item" data-section="tracks">
                <i class="bi bi-music-note-list"></i>
                <span>Quản lý bài hát</span>
            </a>
            <a href="#" class="nav-item" data-section="playlists">
                <i class="bi bi-collection-play"></i>
                <span>Quản lý playlist</span>
            </a>
            <a href="#" class="nav-item" data-section="statistics">
                <i class="bi bi-bar-chart-line"></i>
                <span>Thống kê</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="login_home.jsp" class="nav-item">
                <i class="bi bi-house"></i>
                <span>Về trang chủ</span>
            </a>
            <a href="logout" class="nav-item text-danger">
                <i class="bi bi-box-arrow-left"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="admin-main">
        <!-- Top Header -->
        <header class="admin-header">
            <button class="btn btn-link sidebar-toggle" id="sidebarToggle">
                <i class="bi bi-list"></i>
            </button>
            
            <div class="header-search">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Tìm kiếm..." id="globalSearch">
            </div>
            
            <div class="header-right">
                <span class="admin-username">Xin chào, ${sessionScope.user}</span>
                <img src="assets/img/profile_avatar.jpg" alt="Admin" class="admin-avatar">
            </div>
        </header>

        <!-- Content Area -->
        <main class="admin-content">
            <!-- Dashboard Section -->
            <section id="dashboard-section" class="content-section active">
                <h2 class="section-title">Dashboard</h2>
                
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon bg-primary">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalUsers">0</h3>
                            <p>Tổng người dùng</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon bg-success">
                            <i class="bi bi-music-note-beamed"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalTracks">0</h3>
                            <p>Tổng bài hát</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon bg-warning">
                            <i class="bi bi-collection-play"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalPlaylists">0</h3>
                            <p>Tổng playlist</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon bg-info">
                            <i class="bi bi-play-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalPlays">0</h3>
                            <p>Tổng lượt nghe</p>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="charts-row">
                    <div class="chart-container">
                        <h4>Lượt nghe theo ngày (30 ngày gần nhất)</h4>
                        <div class="chart-wrapper">
                            <canvas id="playStatsChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Quick Tables -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="admin-card">
                            <h4>Top bài hát được nghe nhiều nhất</h4>
                            <div class="table-responsive">
                                <table class="table admin-table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Bài hát</th>
                                            <th>Nghệ sĩ</th>
                                            <th>Lượt nghe</th>
                                        </tr>
                                    </thead>
                                    <tbody id="topTracksTable">
                                        <tr><td colspan="4" class="text-center">Đang tải...</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="admin-card">
                            <h4>Người dùng hoạt động nhiều nhất</h4>
                            <div class="table-responsive">
                                <table class="table admin-table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Người dùng</th>
                                            <th>Hoạt động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="activeUsersTable">
                                        <tr><td colspan="3" class="text-center">Đang tải...</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Users Section -->
            <section id="users-section" class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Quản lý người dùng</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="bi bi-plus-lg"></i> Thêm người dùng
                    </button>
                </div>
                
                <div class="admin-card">
                    <div class="card-header-actions">
                        <input type="text" class="form-control search-input" placeholder="Tìm kiếm người dùng..." id="userSearch">
                    </div>
                    <div class="table-responsive">
                        <table class="table admin-table" id="usersTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Avatar</th>
                                    <th>Tên người dùng</th>
                                    <th>Email</th>
                                    <th>Họ tên</th>
                                    <th>Vai trò</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="usersTableBody">
                                <tr><td colspan="8" class="text-center">Đang tải...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- Tracks Section -->
            <section id="tracks-section" class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Quản lý bài hát</h2>
                </div>
                
                <div class="admin-card">
                    <div class="card-header-actions">
                        <input type="text" class="form-control search-input" placeholder="Tìm kiếm bài hát..." id="trackSearch">
                    </div>
                    <div class="table-responsive">
                        <table class="table admin-table" id="tracksTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Ảnh</th>
                                    <th>Tiêu đề</th>
                                    <th>Nghệ sĩ</th>
                                    <th>Thể loại</th>
                                    <th>Lượt nghe</th>
                                    <th>Lượt thích</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="tracksTableBody">
                                <tr><td colspan="9" class="text-center">Đang tải...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- Playlists Section -->
            <section id="playlists-section" class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Quản lý playlist</h2>
                </div>
                
                <div class="admin-card">
                    <div class="card-header-actions">
                        <input type="text" class="form-control search-input" placeholder="Tìm kiếm playlist..." id="playlistSearch">
                    </div>
                    <div class="table-responsive">
                        <table class="table admin-table" id="playlistsTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Ảnh</th>
                                    <th>Tên playlist</th>
                                    <th>Chủ sở hữu</th>
                                    <th>Số bài hát</th>
                                    <th>Công khai</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="playlistsTableBody">
                                <tr><td colspan="8" class="text-center">Đang tải...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- Statistics Section -->
            <section id="statistics-section" class="content-section">
                <h2 class="section-title">Thống kê chi tiết</h2>
                
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="admin-card chart-card">
                            <h4>Biểu đồ bài hát được nghe nhiều nhất</h4>
                            <div class="chart-period-selector">
                                <select class="form-select form-select-sm" id="topTracksLimit">
                                    <option value="5">Top 5</option>
                                    <option value="10" selected>Top 10</option>
                                    <option value="20">Top 20</option>
                                </select>
                            </div>
                            <div class="chart-wrapper">
                                <canvas id="topTracksChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="admin-card chart-card">
                            <h4>Biểu đồ người dùng hoạt động</h4>
                            <div class="chart-period-selector">
                                <select class="form-select form-select-sm" id="activeUsersLimit">
                                    <option value="5">Top 5</option>
                                    <option value="10" selected>Top 10</option>
                                    <option value="20">Top 20</option>
                                </select>
                            </div>
                            <div class="chart-wrapper">
                                <canvas id="activeUsersChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12">
                        <div class="admin-card chart-card">
                            <h4>Thống kê lượt nghe theo thời gian</h4>
                            <div class="chart-period-selector">
                                <select class="form-select form-select-sm" id="playStatsDays">
                                    <option value="7">7 ngày</option>
                                    <option value="30" selected>30 ngày</option>
                                    <option value="90">90 ngày</option>
                                </select>
                            </div>
                            <div class="chart-wrapper">
                                <canvas id="playStatsDetailChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Thêm người dùng mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addUserForm">
                        <div class="mb-3">
                            <label for="newUsername" class="form-label">Tên người dùng *</label>
                            <input type="text" class="form-control" id="newUsername" required>
                        </div>
                        <div class="mb-3">
                            <label for="newEmail" class="form-label">Email *</label>
                            <input type="email" class="form-control" id="newEmail" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Mật khẩu *</label>
                            <input type="password" class="form-control" id="newPassword" required minlength="6">
                        </div>
                        <div class="mb-3">
                            <label for="newFullName" class="form-label">Họ tên</label>
                            <input type="text" class="form-control" id="newFullName">
                        </div>
                        <div class="mb-3">
                            <label for="newRole" class="form-label">Vai trò</label>
                            <select class="form-select" id="newRole">
                                <option value="user">Người dùng</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="createUser()">Thêm người dùng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Chỉnh sửa người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editUserForm">
                        <input type="hidden" id="editUserId">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editUsername" class="form-label">Tên người dùng *</label>
                                <input type="text" class="form-control" id="editUsername" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editEmail" class="form-label">Email *</label>
                                <input type="email" class="form-control" id="editEmail" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editFullName" class="form-label">Họ tên</label>
                                <input type="text" class="form-control" id="editFullName">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editRole" class="form-label">Vai trò</label>
                                <select class="form-select" id="editRole">
                                    <option value="user">Người dùng</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="editBio" class="form-label">Giới thiệu</label>
                            <textarea class="form-control" id="editBio" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="updateUser()">Lưu thay đổi</button>
                </div>
            </div>
        </div>
    </div>

    <!-- View User Detail Modal -->
    <div class="modal fade" id="viewUserModal" tabindex="-1" aria-labelledby="viewUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewUserModalLabel">Chi tiết người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="userDetailContent">
                    <div class="text-center">
                        <div class="spinner-border" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Track Modal -->
    <div class="modal fade" id="editTrackModal" tabindex="-1" aria-labelledby="editTrackModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editTrackModalLabel">Chỉnh sửa bài hát</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editTrackForm">
                        <input type="hidden" id="editTrackId">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editTrackTitle" class="form-label">Tiêu đề *</label>
                                <input type="text" class="form-control" id="editTrackTitle" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editTrackArtist" class="form-label">Nghệ sĩ</label>
                                <input type="text" class="form-control" id="editTrackArtist">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editTrackGenre" class="form-label">Thể loại</label>
                                <input type="text" class="form-control" id="editTrackGenre">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editTrackPrivacy" class="form-label">Trạng thái</label>
                                <select class="form-select" id="editTrackPrivacy">
                                    <option value="public">Công khai</option>
                                    <option value="private">Riêng tư</option>
                                    <option value="schedule">Đã lên lịch</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="editTrackTags" class="form-label">Tags</label>
                            <input type="text" class="form-control" id="editTrackTags" placeholder="tag1, tag2, tag3">
                        </div>
                        <div class="mb-3">
                            <label for="editTrackDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="editTrackDescription" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="updateTrack()">Lưu thay đổi</button>
                </div>
            </div>
        </div>
    </div>

    <!-- View Track Detail Modal -->
    <div class="modal fade" id="viewTrackModal" tabindex="-1" aria-labelledby="viewTrackModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewTrackModalLabel">Chi tiết bài hát</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="trackDetailContent">
                    <div class="text-center">
                        <div class="spinner-border" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Playlist Modal -->
    <div class="modal fade" id="editPlaylistModal" tabindex="-1" aria-labelledby="editPlaylistModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editPlaylistModalLabel">Chỉnh sửa playlist</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editPlaylistForm">
                        <input type="hidden" id="editPlaylistId">
                        <div class="mb-3">
                            <label for="editPlaylistName" class="form-label">Tên playlist *</label>
                            <input type="text" class="form-control" id="editPlaylistName" required>
                        </div>
                        <div class="mb-3">
                            <label for="editPlaylistDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="editPlaylistDescription" rows="3"></textarea>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="editPlaylistPublic">
                            <label class="form-check-label" for="editPlaylistPublic">
                                Công khai playlist
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="updatePlaylist()">Lưu thay đổi</button>
                </div>
            </div>
        </div>
    </div>

    <!-- View Playlist Detail Modal -->
    <div class="modal fade" id="viewPlaylistModal" tabindex="-1" aria-labelledby="viewPlaylistModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewPlaylistModalLabel">Chi tiết playlist</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="playlistDetailContent">
                    <div class="text-center">
                        <div class="spinner-border" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="deleteConfirmMessage">Bạn có chắc chắn muốn xóa?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Xóa</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="adminToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto" id="toastTitle">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage"></div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Admin JS -->
    <script src="assets/js/admin.js"></script>
</body>
</html>
