/**
 * Admin Dashboard JavaScript
 * Handles all admin functionality including CRUD operations and charts
 * ES5 compatible version for Eclipse
 */

// Global variables
var usersData = [];
var tracksData = [];
var playlistsData = [];
var playStatsChart = null;
var topTracksChart = null;
var activeUsersChart = null;
var playStatsDetailChart = null;

// Configure Chart.js defaults to prevent continuous animation loop
if (typeof Chart !== 'undefined') {
    // Tắt hoàn toàn animation
    Chart.defaults.animation = false;
    Chart.defaults.animations = false;
    Chart.defaults.transitions = {
        active: {
            animation: {
                duration: 0
            }
        },
        resize: {
            animation: {
                duration: 0
            }
        }
    };
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    initializeSidebar();
    loadDashboardData();
    setupEventListeners();
});

// ==================== SIDEBAR ====================
function initializeSidebar() {
    var sidebarToggle = document.getElementById('sidebarToggle');
    var sidebar = document.getElementById('sidebar');
    
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            sidebar.classList.toggle('show');
        });
    }
    
    // Navigation
    var navItems = document.querySelectorAll('.sidebar-nav .nav-item');
    for (var i = 0; i < navItems.length; i++) {
        navItems[i].addEventListener('click', function(e) {
            e.preventDefault();
            var section = this.dataset.section;
            navigateToSection(section);
        });
    }
}

function navigateToSection(section) {
    // Update nav items
    var navItems = document.querySelectorAll('.sidebar-nav .nav-item');
    for (var i = 0; i < navItems.length; i++) {
        navItems[i].classList.remove('active');
        if (navItems[i].dataset.section === section) {
            navItems[i].classList.add('active');
        }
    }
    
    // Update sections
    var sections = document.querySelectorAll('.content-section');
    for (var j = 0; j < sections.length; j++) {
        sections[j].classList.remove('active');
    }
    var sectionEl = document.getElementById(section + '-section');
    if (sectionEl) sectionEl.classList.add('active');
    
    // Load data for section
    switch(section) {
        case 'dashboard':
            loadDashboardData();
            break;
        case 'users':
            loadUsers();
            break;
        case 'tracks':
            loadTracks();
            break;
        case 'playlists':
            loadPlaylists();
            break;
        case 'statistics':
            loadStatisticsCharts();
            break;
    }
}

// ==================== EVENT LISTENERS ====================
function setupEventListeners() {
    // Search inputs
    var userSearch = document.getElementById('userSearch');
    var trackSearch = document.getElementById('trackSearch');
    var playlistSearch = document.getElementById('playlistSearch');
    var topTracksLimit = document.getElementById('topTracksLimit');
    var activeUsersLimit = document.getElementById('activeUsersLimit');
    var playStatsDays = document.getElementById('playStatsDays');
    
    if (userSearch) userSearch.addEventListener('input', filterUsers);
    if (trackSearch) trackSearch.addEventListener('input', filterTracks);
    if (playlistSearch) playlistSearch.addEventListener('input', filterPlaylists);
    
    // Chart selectors
    if (topTracksLimit) topTracksLimit.addEventListener('change', loadTopTracksChart);
    if (activeUsersLimit) activeUsersLimit.addEventListener('change', loadActiveUsersChart);
    if (playStatsDays) playStatsDays.addEventListener('change', loadPlayStatsDetailChart);
}

// ==================== DASHBOARD ====================
function loadDashboardData() {
    // Load stats
    fetch('admin/api/stats')
        .then(function(response) { 
            if (!response.ok) {
                throw new Error('HTTP ' + response.status);
            }
            return response.json(); 
        })
        .then(function(stats) {
            document.getElementById('totalUsers').textContent = formatNumber(stats.totalUsers || 0);
            document.getElementById('totalTracks').textContent = formatNumber(stats.totalTracks || 0);
            document.getElementById('totalPlaylists').textContent = formatNumber(stats.totalPlaylists || 0);
            document.getElementById('totalPlays').textContent = formatNumber(stats.totalPlays || 0);
        })
        .catch(function(error) {
            console.error('Error loading stats:', error);
            showToast('Lỗi', 'Không thể tải dữ liệu thống kê: ' + error.message, 'error');
        });
    
    // Load top tracks table
    loadTopTracksTable();
    
    // Load active users table
    loadActiveUsersTable();
    
    // Load play stats chart
    loadPlayStatsChart();
}

function loadTopTracksTable() {
    fetch('admin/api/top-tracks?limit=5')
        .then(function(response) { return response.json(); })
        .then(function(tracks) {
            var tbody = document.getElementById('topTracksTable');
            if (tracks.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">Chưa có dữ liệu</td></tr>';
                return;
            }
            
            var html = '';
            for (var i = 0; i < tracks.length; i++) {
                var track = tracks[i];
                html += '<tr>';
                html += '<td>' + (i + 1) + '</td>';
                html += '<td>' + escapeHtml(track.title) + '</td>';
                html += '<td>' + escapeHtml(track.artist || 'N/A') + '</td>';
                html += '<td>' + formatNumber(track.playCount) + '</td>';
                html += '</tr>';
            }
            tbody.innerHTML = html;
        })
        .catch(function(error) {
            console.error('Error loading top tracks:', error);
        });
}

function loadActiveUsersTable() {
    fetch('admin/api/active-users?limit=5')
        .then(function(response) { return response.json(); })
        .then(function(users) {
            var tbody = document.getElementById('activeUsersTable');
            if (users.length === 0) {
                tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted">Chưa có dữ liệu</td></tr>';
                return;
            }
            
            var html = '';
            for (var i = 0; i < users.length; i++) {
                var user = users[i];
                var profileImg = user.profileImage || 'assets/img/profile_avatar.jpg';
                html += '<tr>';
                html += '<td>' + (i + 1) + '</td>';
                html += '<td>';
                html += '<div class="d-flex align-items-center gap-2">';
                html += '<img src="' + profileImg + '" alt="' + escapeHtml(user.username) + '" class="table-avatar" onerror="this.onerror=null;this.src=\'assets/img/profile_avatar.jpg\'">';
                html += escapeHtml(user.username);
                html += '</div>';
                html += '</td>';
                html += '<td>' + formatNumber(user.activityCount) + ' lượt nghe</td>';
                html += '</tr>';
            }
            tbody.innerHTML = html;
        })
        .catch(function(error) {
            console.error('Error loading active users:', error);
        });
}

function loadPlayStatsChart() {
    fetch('admin/api/play-stats?days=30')
        .then(function(response) { return response.json(); })
        .then(function(data) {
            var chartEl = document.getElementById('playStatsChart');
            var ctx = chartEl ? chartEl.getContext('2d') : null;
            if (!ctx) return;
            
            if (playStatsChart) {
                playStatsChart.destroy();
            }
            
            var labels = [];
            var values = [];
            for (var i = 0; i < data.length; i++) {
                labels.push(formatDate(data[i].date));
                values.push(data[i].count);
            }
            
            playStatsChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Lượt nghe',
                        data: values,
                        backgroundColor: 'rgba(255, 106, 0, 0.8)',
                        borderColor: '#ff6a00',
                        borderWidth: 1,
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#8b8b9a',
                                maxRotation: 45
                            }
                        },
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#8b8b9a'
                            }
                        }
                    }
                }
            });
        })
        .catch(function(error) {
            console.error('Error loading play stats chart:', error);
        });
}

// ==================== USERS MANAGEMENT ====================
function loadUsers() {
    fetch('admin/api/users')
        .then(function(response) { return response.json(); })
        .then(function(users) {
            usersData = users;
            renderUsersTable(usersData);
        })
        .catch(function(error) {
            console.error('Error loading users:', error);
            showToast('Lỗi', 'Không thể tải danh sách người dùng', 'error');
        });
}

function renderUsersTable(users) {
    var tbody = document.getElementById('usersTableBody');
    if (!tbody) return;
    
    if (users.length === 0) {
        tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">Không có người dùng nào</td></tr>';
        return;
    }
    
    var html = '';
    for (var i = 0; i < users.length; i++) {
        var user = users[i];
        var profileImg = user.profileImage || 'assets/img/profile_avatar.jpg';
        var roleClass = user.role === 'admin' ? 'badge-admin' : 'badge-user';
        var roleText = user.role === 'admin' ? 'Admin' : 'Người dùng';
        
        html += '<tr>';
        html += '<td>' + user.userId + '</td>';
        html += '<td><img src="' + profileImg + '" alt="' + escapeHtml(user.username) + '" class="table-avatar" onerror="this.onerror=null;this.src=\'assets/img/profile_avatar.jpg\'"></td>';
        html += '<td>' + escapeHtml(user.username) + '</td>';
        html += '<td>' + escapeHtml(user.email) + '</td>';
        html += '<td>' + escapeHtml(user.fullName || 'N/A') + '</td>';
        html += '<td><span class="badge-role ' + roleClass + '">' + roleText + '</span></td>';
        html += '<td>' + formatDateTime(user.createdAt) + '</td>';
        html += '<td>';
        html += '<div class="action-buttons">';
        html += '<button class="btn-action btn-view" onclick="viewUser(' + user.userId + ')" title="Xem chi tiết"><i class="bi bi-eye"></i></button>';
        html += '<button class="btn-action btn-edit" onclick="editUser(' + user.userId + ')" title="Chỉnh sửa"><i class="bi bi-pencil"></i></button>';
        html += '<button class="btn-action btn-delete" onclick="confirmDeleteUser(' + user.userId + ')" title="Xóa"><i class="bi bi-trash"></i></button>';
        html += '</div>';
        html += '</td>';
        html += '</tr>';
    }
    tbody.innerHTML = html;
}

function filterUsers() {
    var query = document.getElementById('userSearch').value.toLowerCase();
    var filtered = [];
    for (var i = 0; i < usersData.length; i++) {
        var user = usersData[i];
        if (user.username.toLowerCase().indexOf(query) !== -1 ||
            user.email.toLowerCase().indexOf(query) !== -1 ||
            (user.fullName && user.fullName.toLowerCase().indexOf(query) !== -1)) {
            filtered.push(user);
        }
    }
    renderUsersTable(filtered);
}

function viewUser(userId) {
    fetch('admin/api/user/' + userId)
        .then(function(response) { return response.json(); })
        .then(function(user) {
            var profileImg = user.profileImage || 'assets/img/profile_avatar.jpg';
            var roleClass = user.role === 'admin' ? 'badge-admin' : 'badge-user';
            var roleText = user.role === 'admin' ? 'Admin' : 'Người dùng';
            
            var html = '';
            html += '<div class="detail-header">';
            html += '<img src="' + profileImg + '" alt="' + escapeHtml(user.username) + '" class="detail-avatar" onerror="this.onerror=null;this.src=\'assets/img/profile_avatar.jpg\'">';
            html += '<div class="detail-info">';
            html += '<h3>' + escapeHtml(user.username) + '</h3>';
            html += '<p><i class="bi bi-envelope me-2"></i>' + escapeHtml(user.email) + '</p>';
            html += '<p><span class="badge-role ' + roleClass + '">' + roleText + '</span></p>';
            html += '</div>';
            html += '</div>';
            html += '<div class="detail-grid">';
            html += '<div class="detail-item"><label>ID người dùng</label><span>' + user.userId + '</span></div>';
            html += '<div class="detail-item"><label>Họ tên</label><span>' + escapeHtml(user.fullName || 'Chưa cập nhật') + '</span></div>';
            html += '<div class="detail-item"><label>Ngày tạo</label><span>' + formatDateTime(user.createdAt) + '</span></div>';
            html += '<div class="detail-item"><label>Cập nhật lần cuối</label><span>' + formatDateTime(user.updatedAt) + '</span></div>';
            html += '</div>';
            html += '<div class="detail-item mt-3"><label>Giới thiệu</label><span>' + escapeHtml(user.bio || 'Chưa có giới thiệu') + '</span></div>';
            
            document.getElementById('userDetailContent').innerHTML = html;
            new bootstrap.Modal(document.getElementById('viewUserModal')).show();
        })
        .catch(function(error) {
            console.error('Error viewing user:', error);
            showToast('Lỗi', 'Không thể tải thông tin người dùng', 'error');
        });
}

function editUser(userId) {
    fetch('admin/api/user/' + userId)
        .then(function(response) { return response.json(); })
        .then(function(user) {
            document.getElementById('editUserId').value = user.userId;
            document.getElementById('editUsername').value = user.username;
            document.getElementById('editEmail').value = user.email;
            document.getElementById('editFullName').value = user.fullName || '';
            document.getElementById('editBio').value = user.bio || '';
            document.getElementById('editRole').value = user.role || 'user';
            
            new bootstrap.Modal(document.getElementById('editUserModal')).show();
        })
        .catch(function(error) {
            console.error('Error editing user:', error);
            showToast('Lỗi', 'Không thể tải thông tin người dùng', 'error');
        });
}

function updateUser() {
    var userId = document.getElementById('editUserId').value;
    var formData = new FormData();
    formData.append('userId', userId);
    formData.append('username', document.getElementById('editUsername').value);
    formData.append('email', document.getElementById('editEmail').value);
    formData.append('fullName', document.getElementById('editFullName').value);
    formData.append('bio', document.getElementById('editBio').value);
    formData.append('role', document.getElementById('editRole').value);
    
    fetch('admin/api/user/update', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('editUserModal')).hide();
            loadUsers();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error updating user:', error);
        showToast('Lỗi', 'Không thể cập nhật người dùng', 'error');
    });
}

function confirmDeleteUser(userId) {
    document.getElementById('deleteConfirmMessage').textContent = 'Bạn có chắc chắn muốn xóa người dùng này? Hành động này không thể hoàn tác.';
    document.getElementById('confirmDeleteBtn').onclick = function() { deleteUser(userId); };
    new bootstrap.Modal(document.getElementById('deleteConfirmModal')).show();
}

function deleteUser(userId) {
    var formData = new FormData();
    formData.append('userId', userId);
    
    fetch('admin/api/user/delete', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal')).hide();
            loadUsers();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error deleting user:', error);
        showToast('Lỗi', 'Không thể xóa người dùng', 'error');
    });
}

function createUser() {
    var formData = new FormData();
    formData.append('username', document.getElementById('newUsername').value);
    formData.append('email', document.getElementById('newEmail').value);
    formData.append('password', document.getElementById('newPassword').value);
    formData.append('fullName', document.getElementById('newFullName').value);
    formData.append('role', document.getElementById('newRole').value);
    
    fetch('admin/api/user/create', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('addUserModal')).hide();
            document.getElementById('addUserForm').reset();
            loadUsers();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error creating user:', error);
        showToast('Lỗi', 'Không thể tạo người dùng', 'error');
    });
}

// ==================== TRACKS MANAGEMENT ====================
function loadTracks() {
    fetch('admin/api/tracks')
        .then(function(response) { 
            if (!response.ok) {
                throw new Error('HTTP ' + response.status + ': ' + response.statusText);
            }
            return response.json(); 
        })
        .then(function(tracks) {
            tracksData = tracks;
            renderTracksTable(tracksData);
        })
        .catch(function(error) {
            console.error('Error loading tracks:', error);
            showToast('Lỗi', 'Không thể tải danh sách bài hát: ' + error.message, 'error');
        });
}

function renderTracksTable(tracks) {
    var tbody = document.getElementById('tracksTableBody');
    if (!tbody) return;
    
    if (tracks.length === 0) {
        tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted">Không có bài hát nào</td></tr>';
        return;
    }
    
    var html = '';
    for (var i = 0; i < tracks.length; i++) {
        var track = tracks[i];
        var artworkUrl = track.artworkUrl || 'assets/img/default-track.jpg';
        
        html += '<tr>';
        html += '<td>' + track.trackId + '</td>';
        html += '<td><img src="' + artworkUrl + '" alt="' + escapeHtml(track.title) + '" class="table-artwork" onerror="this.onerror=null;this.src=\'assets/img/default-track.jpg\'"></td>';
        html += '<td>' + escapeHtml(track.title) + '</td>';
        html += '<td>' + escapeHtml(track.artist || 'N/A') + '</td>';
        html += '<td>' + escapeHtml(track.genre || 'N/A') + '</td>';
        html += '<td>' + formatNumber(track.playCount) + '</td>';
        html += '<td>' + formatNumber(track.likeCount) + '</td>';
        html += '<td><span class="badge-privacy badge-' + track.privacy + '">' + getPrivacyLabel(track.privacy) + '</span></td>';
        html += '<td>';
        html += '<div class="action-buttons">';
        html += '<button class="btn-action btn-view" onclick="viewTrack(' + track.trackId + ')" title="Xem chi tiết"><i class="bi bi-eye"></i></button>';
        html += '<button class="btn-action btn-edit" onclick="editTrack(' + track.trackId + ')" title="Chỉnh sửa"><i class="bi bi-pencil"></i></button>';
        html += '<button class="btn-action btn-delete" onclick="confirmDeleteTrack(' + track.trackId + ')" title="Xóa"><i class="bi bi-trash"></i></button>';
        html += '</div>';
        html += '</td>';
        html += '</tr>';
    }
    tbody.innerHTML = html;
}

function filterTracks() {
    var query = document.getElementById('trackSearch').value.toLowerCase();
    var filtered = [];
    for (var i = 0; i < tracksData.length; i++) {
        var track = tracksData[i];
        if (track.title.toLowerCase().indexOf(query) !== -1 ||
            (track.artist && track.artist.toLowerCase().indexOf(query) !== -1) ||
            (track.genre && track.genre.toLowerCase().indexOf(query) !== -1)) {
            filtered.push(track);
        }
    }
    renderTracksTable(filtered);
}

function viewTrack(trackId) {
    fetch('admin/api/track/' + trackId)
        .then(function(response) { return response.json(); })
        .then(function(track) {
            var artworkUrl = track.artworkUrl || 'assets/img/default-track.jpg';
            
            var html = '';
            html += '<div class="detail-header">';
            html += '<img src="' + artworkUrl + '" alt="' + escapeHtml(track.title) + '" class="detail-avatar" onerror="this.onerror=null;this.src=\'assets/img/default-track.jpg\'">';
            html += '<div class="detail-info">';
            html += '<h3>' + escapeHtml(track.title) + '</h3>';
            html += '<p><i class="bi bi-person me-2"></i>' + escapeHtml(track.artist || 'N/A') + '</p>';
            html += '<p><i class="bi bi-music-note me-2"></i>' + escapeHtml(track.genre || 'N/A') + '</p>';
            html += '<p><span class="badge-privacy badge-' + track.privacy + '">' + getPrivacyLabel(track.privacy) + '</span></p>';
            html += '</div>';
            html += '</div>';
            html += '<div class="detail-grid">';
            html += '<div class="detail-item"><label>ID bài hát</label><span>' + track.trackId + '</span></div>';
            html += '<div class="detail-item"><label>Người tải lên</label><span>' + escapeHtml(track.uploaderUsername || 'N/A') + '</span></div>';
            html += '<div class="detail-item"><label>Lượt nghe</label><span>' + formatNumber(track.playCount) + '</span></div>';
            html += '<div class="detail-item"><label>Lượt thích</label><span>' + formatNumber(track.likeCount) + '</span></div>';
            html += '<div class="detail-item"><label>Thời lượng</label><span>' + formatDuration(track.duration) + '</span></div>';
            html += '<div class="detail-item"><label>Ngày tải lên</label><span>' + formatDateTime(track.createdAt) + '</span></div>';
            html += '</div>';
            html += '<div class="detail-item mt-3"><label>Tags</label><span>' + escapeHtml(track.tags || 'Không có tags') + '</span></div>';
            html += '<div class="detail-item mt-3"><label>Mô tả</label><span>' + escapeHtml(track.description || 'Chưa có mô tả') + '</span></div>';
            
            document.getElementById('trackDetailContent').innerHTML = html;
            new bootstrap.Modal(document.getElementById('viewTrackModal')).show();
        })
        .catch(function(error) {
            console.error('Error viewing track:', error);
            showToast('Lỗi', 'Không thể tải thông tin bài hát', 'error');
        });
}

function editTrack(trackId) {
    fetch('admin/api/track/' + trackId)
        .then(function(response) { return response.json(); })
        .then(function(track) {
            document.getElementById('editTrackId').value = track.trackId;
            document.getElementById('editTrackTitle').value = track.title;
            document.getElementById('editTrackArtist').value = track.artist || '';
            document.getElementById('editTrackGenre').value = track.genre || '';
            document.getElementById('editTrackTags').value = track.tags || '';
            document.getElementById('editTrackDescription').value = track.description || '';
            document.getElementById('editTrackPrivacy').value = track.privacy || 'public';
            
            new bootstrap.Modal(document.getElementById('editTrackModal')).show();
        })
        .catch(function(error) {
            console.error('Error editing track:', error);
            showToast('Lỗi', 'Không thể tải thông tin bài hát', 'error');
        });
}

function updateTrack() {
    var trackId = document.getElementById('editTrackId').value;
    var formData = new FormData();
    formData.append('trackId', trackId);
    formData.append('title', document.getElementById('editTrackTitle').value);
    formData.append('artist', document.getElementById('editTrackArtist').value);
    formData.append('genre', document.getElementById('editTrackGenre').value);
    formData.append('tags', document.getElementById('editTrackTags').value);
    formData.append('description', document.getElementById('editTrackDescription').value);
    formData.append('privacy', document.getElementById('editTrackPrivacy').value);
    
    fetch('admin/api/track/update', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('editTrackModal')).hide();
            loadTracks();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error updating track:', error);
        showToast('Lỗi', 'Không thể cập nhật bài hát', 'error');
    });
}

function confirmDeleteTrack(trackId) {
    document.getElementById('deleteConfirmMessage').textContent = 'Bạn có chắc chắn muốn xóa bài hát này? Hành động này không thể hoàn tác.';
    document.getElementById('confirmDeleteBtn').onclick = function() { deleteTrack(trackId); };
    new bootstrap.Modal(document.getElementById('deleteConfirmModal')).show();
}

function deleteTrack(trackId) {
    var formData = new FormData();
    formData.append('trackId', trackId);
    
    fetch('admin/api/track/delete', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal')).hide();
            loadTracks();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error deleting track:', error);
        showToast('Lỗi', 'Không thể xóa bài hát', 'error');
    });
}

// ==================== PLAYLISTS MANAGEMENT ====================
function loadPlaylists() {
    fetch('admin/api/playlists')
        .then(function(response) { return response.json(); })
        .then(function(playlists) {
            playlistsData = playlists;
            renderPlaylistsTable(playlistsData);
        })
        .catch(function(error) {
            console.error('Error loading playlists:', error);
            showToast('Lỗi', 'Không thể tải danh sách playlist', 'error');
        });
}

function renderPlaylistsTable(playlists) {
    var tbody = document.getElementById('playlistsTableBody');
    if (!tbody) return;
    
    if (playlists.length === 0) {
        tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">Không có playlist nào</td></tr>';
        return;
    }
    
    var html = '';
    for (var i = 0; i < playlists.length; i++) {
        var playlist = playlists[i];
        var artworkUrl = playlist.artworkUrl || 'assets/img/default-playlist.jpg';
        var privacyClass = playlist.public ? 'badge-public' : 'badge-private';
        var privacyText = playlist.public ? 'Công khai' : 'Riêng tư';
        
        html += '<tr>';
        html += '<td>' + playlist.id + '</td>';
        html += '<td><img src="' + artworkUrl + '" alt="' + escapeHtml(playlist.name) + '" class="table-artwork" onerror="this.onerror=null;this.src=\'assets/img/default-playlist.jpg\'"></td>';
        html += '<td>' + escapeHtml(playlist.name) + '</td>';
        html += '<td>' + escapeHtml(playlist.ownerUsername || 'N/A') + '</td>';
        html += '<td>' + playlist.trackCount + '</td>';
        html += '<td><span class="badge-privacy ' + privacyClass + '">' + privacyText + '</span></td>';
        html += '<td>' + formatDateTime(playlist.createdAt) + '</td>';
        html += '<td>';
        html += '<div class="action-buttons">';
        html += '<button class="btn-action btn-view" onclick="viewPlaylist(' + playlist.id + ')" title="Xem chi tiết"><i class="bi bi-eye"></i></button>';
        html += '<button class="btn-action btn-edit" onclick="editPlaylist(' + playlist.id + ')" title="Chỉnh sửa"><i class="bi bi-pencil"></i></button>';
        html += '<button class="btn-action btn-delete" onclick="confirmDeletePlaylist(' + playlist.id + ')" title="Xóa"><i class="bi bi-trash"></i></button>';
        html += '</div>';
        html += '</td>';
        html += '</tr>';
    }
    tbody.innerHTML = html;
}

function filterPlaylists() {
    var query = document.getElementById('playlistSearch').value.toLowerCase();
    var filtered = [];
    for (var i = 0; i < playlistsData.length; i++) {
        var playlist = playlistsData[i];
        if (playlist.name.toLowerCase().indexOf(query) !== -1 ||
            (playlist.ownerUsername && playlist.ownerUsername.toLowerCase().indexOf(query) !== -1)) {
            filtered.push(playlist);
        }
    }
    renderPlaylistsTable(filtered);
}

function viewPlaylist(playlistId) {
    fetch('admin/api/playlist/' + playlistId)
        .then(function(response) { return response.json(); })
        .then(function(playlist) {
            var artworkUrl = playlist.artworkUrl || 'assets/img/default-playlist.jpg';
            var privacyClass = playlist.public ? 'badge-public' : 'badge-private';
            var privacyText = playlist.public ? 'Công khai' : 'Riêng tư';
            
            var html = '';
            html += '<div class="detail-header">';
            html += '<img src="' + artworkUrl + '" alt="' + escapeHtml(playlist.name) + '" class="detail-avatar" onerror="this.onerror=null;this.src=\'assets/img/default-playlist.jpg\'">';
            html += '<div class="detail-info">';
            html += '<h3>' + escapeHtml(playlist.name) + '</h3>';
            html += '<p><i class="bi bi-person me-2"></i>' + escapeHtml(playlist.ownerUsername || 'N/A') + '</p>';
            html += '<p><span class="badge-privacy ' + privacyClass + '">' + privacyText + '</span></p>';
            html += '</div>';
            html += '</div>';
            html += '<div class="detail-grid">';
            html += '<div class="detail-item"><label>ID playlist</label><span>' + playlist.id + '</span></div>';
            html += '<div class="detail-item"><label>Số bài hát</label><span>' + playlist.trackCount + '</span></div>';
            html += '<div class="detail-item"><label>Ngày tạo</label><span>' + formatDateTime(playlist.createdAt) + '</span></div>';
            html += '<div class="detail-item"><label>ID chủ sở hữu</label><span>' + playlist.userId + '</span></div>';
            html += '</div>';
            html += '<div class="detail-item mt-3"><label>Mô tả</label><span>' + escapeHtml(playlist.description || 'Chưa có mô tả') + '</span></div>';
            
            document.getElementById('playlistDetailContent').innerHTML = html;
            new bootstrap.Modal(document.getElementById('viewPlaylistModal')).show();
        })
        .catch(function(error) {
            console.error('Error viewing playlist:', error);
            showToast('Lỗi', 'Không thể tải thông tin playlist', 'error');
        });
}

function editPlaylist(playlistId) {
    fetch('admin/api/playlist/' + playlistId)
        .then(function(response) { return response.json(); })
        .then(function(playlist) {
            document.getElementById('editPlaylistId').value = playlist.id;
            document.getElementById('editPlaylistName').value = playlist.name;
            document.getElementById('editPlaylistDescription').value = playlist.description || '';
            document.getElementById('editPlaylistPublic').checked = playlist.public;
            
            new bootstrap.Modal(document.getElementById('editPlaylistModal')).show();
        })
        .catch(function(error) {
            console.error('Error editing playlist:', error);
            showToast('Lỗi', 'Không thể tải thông tin playlist', 'error');
        });
}

function updatePlaylist() {
    var playlistId = document.getElementById('editPlaylistId').value;
    var formData = new FormData();
    formData.append('playlistId', playlistId);
    formData.append('name', document.getElementById('editPlaylistName').value);
    formData.append('description', document.getElementById('editPlaylistDescription').value);
    formData.append('isPublic', document.getElementById('editPlaylistPublic').checked);
    
    fetch('admin/api/playlist/update', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('editPlaylistModal')).hide();
            loadPlaylists();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error updating playlist:', error);
        showToast('Lỗi', 'Không thể cập nhật playlist', 'error');
    });
}

function confirmDeletePlaylist(playlistId) {
    document.getElementById('deleteConfirmMessage').textContent = 'Bạn có chắc chắn muốn xóa playlist này? Hành động này không thể hoàn tác.';
    document.getElementById('confirmDeleteBtn').onclick = function() { deletePlaylist(playlistId); };
    new bootstrap.Modal(document.getElementById('deleteConfirmModal')).show();
}

function deletePlaylist(playlistId) {
    var formData = new FormData();
    formData.append('playlistId', playlistId);
    
    fetch('admin/api/playlist/delete', {
        method: 'POST',
        body: formData
    })
    .then(function(response) { return response.json(); })
    .then(function(result) {
        if (result.success) {
            showToast('Thành công', result.message, 'success');
            bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal')).hide();
            loadPlaylists();
        } else {
            showToast('Lỗi', result.error, 'error');
        }
    })
    .catch(function(error) {
        console.error('Error deleting playlist:', error);
        showToast('Lỗi', 'Không thể xóa playlist', 'error');
    });
}

// ==================== STATISTICS CHARTS ====================
function loadStatisticsCharts() {
    loadTopTracksChart();
    loadActiveUsersChart();
    loadPlayStatsDetailChart();
}

function loadTopTracksChart() {
    var limitEl = document.getElementById('topTracksLimit');
    var limit = limitEl ? limitEl.value : 10;
    
    fetch('admin/api/top-tracks?limit=' + limit)
        .then(function(response) { return response.json(); })
        .then(function(tracks) {
            var chartEl = document.getElementById('topTracksChart');
            var ctx = chartEl ? chartEl.getContext('2d') : null;
            if (!ctx) return;
            
            if (topTracksChart) {
                topTracksChart.destroy();
            }
            
            var labels = [];
            var values = [];
            for (var i = 0; i < tracks.length; i++) {
                labels.push(truncateText(tracks[i].title, 20));
                values.push(tracks[i].playCount);
            }
            
            topTracksChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Lượt nghe',
                        data: values,
                        backgroundColor: generateGradientColors(tracks.length),
                        borderWidth: 0,
                        borderRadius: 4
                    }]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#8b8b9a'
                            }
                        },
                        y: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#8b8b9a'
                            }
                        }
                    }
                }
            });
        })
        .catch(function(error) {
            console.error('Error loading top tracks chart:', error);
        });
}

function loadActiveUsersChart() {
    var limitEl = document.getElementById('activeUsersLimit');
    var limit = limitEl ? limitEl.value : 10;
    
    fetch('admin/api/active-users?limit=' + limit)
        .then(function(response) { return response.json(); })
        .then(function(users) {
            var chartEl = document.getElementById('activeUsersChart');
            var ctx = chartEl ? chartEl.getContext('2d') : null;
            if (!ctx) return;
            
            if (activeUsersChart) {
                activeUsersChart.destroy();
            }
            
            var labels = [];
            var values = [];
            for (var i = 0; i < users.length; i++) {
                labels.push(truncateText(users[i].username, 15));
                values.push(users[i].activityCount);
            }
            
            activeUsersChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: values,
                        backgroundColor: generatePieColors(users.length),
                        borderWidth: 2,
                        borderColor: '#1a1a21'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: false,
                    plugins: {
                        legend: {
                            position: 'right',
                            labels: {
                                color: '#8b8b9a',
                                padding: 10,
                                font: {
                                    size: 11
                                }
                            }
                        }
                    }
                }
            });
        })
        .catch(function(error) {
            console.error('Error loading active users chart:', error);
        });
}

function loadPlayStatsDetailChart() {
    var daysEl = document.getElementById('playStatsDays');
    var days = daysEl ? daysEl.value : 30;
    
    fetch('admin/api/play-stats?days=' + days)
        .then(function(response) { return response.json(); })
        .then(function(data) {
            var chartEl = document.getElementById('playStatsDetailChart');
            var ctx = chartEl ? chartEl.getContext('2d') : null;
            if (!ctx) return;
            
            if (playStatsDetailChart) {
                playStatsDetailChart.destroy();
            }
            
            var labels = [];
            var values = [];
            for (var i = 0; i < data.length; i++) {
                labels.push(formatDate(data[i].date));
                values.push(data[i].count);
            }
            
            playStatsDetailChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Lượt nghe',
                        data: values,
                        borderColor: '#ff6a00',
                        backgroundColor: 'rgba(255, 106, 0, 0.1)',
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#ff6a00',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#8b8b9a',
                                maxTicksLimit: 10
                            }
                        },
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#8b8b9a'
                            }
                        }
                    }
                }
            });
        })
        .catch(function(error) {
            console.error('Error loading play stats detail chart:', error);
        });
}

// ==================== UTILITY FUNCTIONS ====================
function formatNumber(num) {
    if (num === null || num === undefined) return '0';
    return num.toLocaleString('vi-VN');
}

function formatDate(dateStr) {
    if (!dateStr) return 'N/A';
    var date = new Date(dateStr);
    return date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit' });
}

function formatDateTime(dateStr) {
    if (!dateStr) return 'N/A';
    var date = new Date(dateStr);
    return date.toLocaleDateString('vi-VN', { 
        day: '2-digit', 
        month: '2-digit', 
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

function formatDuration(seconds) {
    if (!seconds) return '0:00';
    var mins = Math.floor(seconds / 60);
    var secs = seconds % 60;
    return mins + ':' + (secs < 10 ? '0' : '') + secs;
}

function escapeHtml(text) {
    if (!text) return '';
    var div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function truncateText(text, maxLength) {
    if (!text) return '';
    return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
}

function getPrivacyLabel(privacy) {
    switch(privacy) {
        case 'public': return 'Công khai';
        case 'private': return 'Riêng tư';
        case 'schedule': return 'Đã lên lịch';
        default: return 'N/A';
    }
}

function generateGradientColors(count) {
    var colors = [];
    for (var i = 0; i < count; i++) {
        var hue = (i * 360 / count + 20) % 360;
        colors.push('hsla(' + hue + ', 80%, 55%, 0.8)');
    }
    return colors;
}

function generatePieColors(count) {
    var baseColors = [
        '#ff6a00', '#3b82f6', '#10b981', '#f59e0b', '#ef4444',
        '#8b5cf6', '#ec4899', '#06b6d4', '#84cc16', '#f97316'
    ];
    var colors = [];
    for (var i = 0; i < count; i++) {
        colors.push(baseColors[i % baseColors.length]);
    }
    return colors;
}

function showToast(title, message, type) {
    type = type || 'info';
    var toast = document.getElementById('adminToast');
    var toastTitle = document.getElementById('toastTitle');
    var toastMessage = document.getElementById('toastMessage');
    
    toastTitle.textContent = title;
    toastMessage.textContent = message;
    
    // Update toast color based on type
    toast.className = 'toast';
    if (type === 'success') {
        toast.style.borderLeft = '4px solid #10b981';
    } else if (type === 'error') {
        toast.style.borderLeft = '4px solid #ef4444';
    } else {
        toast.style.borderLeft = '4px solid #3b82f6';
    }
    
    var bsToast = new bootstrap.Toast(toast);
    bsToast.show();
}
