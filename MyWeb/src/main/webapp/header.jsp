<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- Set default avatar nếu chưa có --%>
<c:set var="headerUserAvatar" value="${not empty sessionScope.avatar ? sessionScope.avatar : 'assets/img/profile_avatar.jpg'}" />
<c:set var="headerUsername" value="${sessionScope.user}" />
<c:set var="headerIsAdmin" value="${sessionScope.isAdmin}" />

<%-- Fallback: nếu username là 'admin' thì coi như admin --%>
<c:if test="${empty headerIsAdmin and not empty headerUsername and fn:toLowerCase(headerUsername) eq 'admin'}">
	<c:set var="headerIsAdmin" value="true" />
</c:if>

<!-- NAVBAR -->
<nav class="site-nav">
	<div class="container d-flex align-items-center justify-content-between">
		<div class="d-flex align-items-center gap-3">
			<div class="bf-logo">
				<img src="assets/img/logo.png" alt="BeatFlow logo" class="bf-logo-img">
				<span class="brand">BeatFlow</span>
			</div>
			<ul class="nav d-none d-md-flex">
				<li class="nav-item"><a class="nav-link active" href="login_home.jsp">Trang chủ</a></li>
				<li class="nav-item"><a class="nav-link" href="feed.jsp">Tin tức</a></li>
				<li class="nav-item"><a class="nav-link" href="library">Thư viện</a></li>
				<c:if test="${headerIsAdmin}">
				<li class="nav-item"><a class="nav-link" href="admin.jsp" style="color: #ff6a00; font-weight: 600;"><i class="bi bi-shield-lock me-1"></i>Quản lý</a></li>
				</c:if>
			</ul>
		</div>
		<div class="flex-grow-1 px-4">
			<div class="search-wrapper">
				<input class="search-input" type="text" placeholder="Tìm kiếm những bài hát, bản nhạc, playlist, album" id="searchInput">
				<i class="bi bi-search search-icon"></i>
			</div>
		</div>
		<div class="d-flex align-items-center gap-3">
			<a href="profile" class="nav-function-link">Dành cho nghệ sĩ</a>
			<a href="upload.jsp" class="nav-function-link">Đăng tải</a>
			<button class="btn-icon-nav" onclick="window.location.href='profile'" title="Trang cá nhân">
				<img src="${headerUserAvatar}" alt="Profile" class="profile-avatar-small" onerror="this.src='assets/img/profile_avatar.jpg'">
			</button>
			<!-- User Menu Dropdown -->
			<div class="dropdown-container">
				<button class="btn-icon-nav" id="dropdownMenuButton" aria-expanded="false" aria-haspopup="true">
					<i class="bi bi-chevron-down"></i>
				</button>
				<!-- Dropdown Menu -->
				<div class="dropdown-menu-custom" id="dropdownMenu" role="menu">
					<div style="padding: 10px 15px; border-bottom: 1px solid #e0e0e0; font-weight: 500;">
						<span id="userDisplayName"><c:out value="${not empty headerUsername ? headerUsername : 'Người dùng'}" /></span>
						<c:if test="${headerIsAdmin}">
						<span class="badge bg-danger ms-2" style="font-size: 10px;">Admin</span>
						</c:if>
					</div>
					<c:if test="${headerIsAdmin}">
						<a href="admin.jsp" class="dropdown-item-custom" style="background: rgba(255, 106, 0, 0.1);">
						<i class="bi bi-shield-lock" style="color: #ff6a00;"></i>
						<span style="color: #ff6a00; font-weight: 600;">Trang quản trị</span>
					</a>
					<hr style="margin: 5px 0;">
					</c:if>
					<a href="profile" class="dropdown-item-custom">
						<i class="bi bi-person"></i>
						<span>Trang cá nhân</span>
					</a>
					<a href="profile?tab=favorite" class="dropdown-item-custom">
						<i class="bi bi-heart"></i>
						<span>Đã thích</span>
					</a>
					<a href="profile?tab=playlist" class="dropdown-item-custom">
						<i class="bi bi-collection-play"></i>
						<span>Playlist nhạc</span>
					</a>
					<a href="library" class="dropdown-item-custom">
						<i class="bi bi-broadcast"></i>
						<span>Đài phát thanh</span>
					</a>
					<a href="profile" class="dropdown-item-custom">
						<i class="bi bi-people"></i>
						<span>Đang theo dõi</span>
					</a>
					<a href="profile" class="dropdown-item-custom">
						<i class="bi bi-person-plus"></i>
						<span>Đề xuất theo dõi</span>
					</a>
					<a href="profile?tab=tracks" class="dropdown-item-custom">
						<i class="bi bi-music-note-list"></i>
						<span>Những bản track</span>
					</a>
					<a href="profile" class="dropdown-item-custom">
						<i class="bi bi-bar-chart"></i>
						<span>Thông tin về người nghe</span>
					</a>
					<hr style="margin: 5px 0;">
					<a href="#" class="dropdown-item-custom text-danger" onclick="logout(event)">
						<i class="bi bi-box-arrow-left"></i>
						<span>Đăng xuất</span>
					</a>
				</div>
			</div>
			<!-- Notifications Dropdown -->
			<div class="dropdown-container">
				<button class="btn-icon-nav" id="notificationsMenuButton" aria-expanded="false" aria-haspopup="true" title="Thông báo">
					<i class="bi bi-bell"></i>
					<span class="notification-badge" id="notificationBadge" style="display: none;">0</span>
				</button>
				<div class="messages-dropdown" id="notificationsMenu" role="menu">
					<div class="messages-header">
						<h5 class="m-0">Thông báo</h5>
					</div>
					<div class="messages-body" id="notificationsBody">
						<p class="no-messages">Bạn chưa có thông báo nào.</p>
					</div>
					<div class="messages-footer">
						<a href="#" class="view-all-link">Xem tất cả thông báo</a>
					</div>
				</div>
			</div>
			<!-- Messages Dropdown -->
			<div class="dropdown-container">
				<button class="btn-icon-nav" id="messagesMenuButton" aria-expanded="false" aria-haspopup="true" title="Tin nhắn">
					<i class="bi bi-envelope"></i>
					<span class="notification-badge" id="messageBadge" style="display: none;">0</span>
				</button>
				<div class="messages-dropdown" id="messagesMenu" role="menu">
					<div class="messages-header">
						<h5 class="m-0">Tin nhắn</h5>
					</div>
					<div class="messages-body" id="messagesBody">
						<p class="no-messages">Bạn chưa có tin nhắn nào.</p>
					</div>
					<div class="messages-footer">
						<a href="#" class="view-all-link">Xem tất cả tin nhắn</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>

<script>
	// Khởi tạo header
	document.addEventListener('DOMContentLoaded', function() {
		setupHeaderEvents();
		loadNotifications();
		loadMessages();
		loadSearchSuggestions();
	});

	// Thiết lập sự kiện cho header
	function setupHeaderEvents() {
		// Dropdown menu toggle
		document.getElementById('dropdownMenuButton')?.addEventListener('click', function(e) {
			e.stopPropagation();
			const menu = document.getElementById('dropdownMenu');
			menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
		});

		// Notifications toggle
		document.getElementById('notificationsMenuButton')?.addEventListener('click', function(e) {
			e.stopPropagation();
			const menu = document.getElementById('notificationsMenu');
			menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
		});

		// Messages toggle
		document.getElementById('messagesMenuButton')?.addEventListener('click', function(e) {
			e.stopPropagation();
			const menu = document.getElementById('messagesMenu');
			menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
		});

		// Close menus when clicking outside
		document.addEventListener('click', function(e) {
			if (!e.target.closest('.dropdown-container')) {
				document.querySelectorAll('.dropdown-menu-custom, .messages-dropdown').forEach(function(menu) {
					menu.style.display = 'none';
				});
			}
		});

		// Search functionality
		const searchInput = document.getElementById('searchInput');
		if (searchInput) {
			searchInput.addEventListener('keydown', function(e) {
				if (e.key === 'Enter') {
					performSearch(this.value);
				}
			});
		}
	}

	// Load notifications từ database
	function loadNotifications() {
		fetch('api/notifications', {
			method: 'GET',
			headers: {
				'Content-Type': 'application/json'
			},
			credentials: 'include'
		})
		.then(function(response) { return response.json(); })
		.then(function(data) {
			const badge = document.getElementById('notificationBadge');
			const body = document.getElementById('notificationsBody');
			
			if (data && data.length > 0) {
				badge.textContent = data.length;
				badge.style.display = 'block';
				
				body.innerHTML = data.map(function(notif) {
					return '<div class="message-item" style="padding: 10px; border-bottom: 1px solid #f0f0f0;">' +
						'<div style="font-weight: 500; color: #333;">' + escapeHtml(notif.title) + '</div>' +
						'<div style="font-size: 0.9em; color: #666;">' + escapeHtml(notif.message) + '</div>' +
						'<div style="font-size: 0.8em; color: #999; margin-top: 5px;">' + notif.time + '</div>' +
					'</div>';
				}).join('');
			}
		})
		.catch(function(error) { console.error('Error loading notifications:', error); });
	}

	// Load messages từ database
	function loadMessages() {
		fetch('api/messages', {
			method: 'GET',
			headers: {
				'Content-Type': 'application/json'
			},
			credentials: 'include'
		})
		.then(function(response) { return response.json(); })
		.then(function(data) {
			const badge = document.getElementById('messageBadge');
			const body = document.getElementById('messagesBody');
			
			if (data && data.length > 0) {
				badge.textContent = data.length;
				badge.style.display = 'block';
				
				body.innerHTML = data.map(function(msg) {
					return '<div class="message-item" style="padding: 10px; border-bottom: 1px solid #f0f0f0; cursor: pointer;" onclick="openMessage(' + msg.id + ')">' +
						'<div style="font-weight: 500; color: #333;">' + escapeHtml(msg.senderName) + '</div>' +
						'<div style="font-size: 0.9em; color: #666;">' + escapeHtml(msg.content) + '</div>' +
						'<div style="font-size: 0.8em; color: #999; margin-top: 5px;">' + msg.time + '</div>' +
					'</div>';
				}).join('');
			}
		})
		.catch(function(error) { console.error('Error loading messages:', error); });
	}

	// Search functionality
	function loadSearchSuggestions() {
		const searchInput = document.getElementById('searchInput');
		if (!searchInput) return;

		let debounceTimer;
		searchInput.addEventListener('input', function(e) {
			clearTimeout(debounceTimer);
			if (this.value.length < 2) return;
			var self = this;

			debounceTimer = setTimeout(function() {
				fetch('api/search/suggestions?q=' + encodeURIComponent(self.value), {
					method: 'GET',
					headers: {
						'Content-Type': 'application/json'
					},
					credentials: 'include'
				})
				.then(function(response) { return response.json(); })
				.then(function(data) {
					// Có thể hiển thị suggestions dưới search input
					console.log('Search suggestions:', data);
				})
				.catch(function(error) { console.error('Error fetching suggestions:', error); });
			}, 300);
		});
	}

	// Thực hiện tìm kiếm
	function performSearch(query) {
		if (query.trim()) {
			window.location.href = 'search.jsp?q=' + encodeURIComponent(query);
		}
	}

	// Logout
	function logout(e) {
		e.preventDefault();
		if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
			fetch('logout', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				credentials: 'include'
			})
			.then(function(response) {
				if (response.ok) {
					window.location.href = 'login';
				}
			})
			.catch(function(error) {
				console.error('Error logging out:', error);
				// Force logout anyway
				window.location.href = 'login';
			});
		}
	}

	// Open message detail
	function openMessage(messageId) {
		// Implement message detail view
		console.log('Opening message:', messageId);
	}

	// Escape HTML
	function escapeHtml(text) {
		if (!text) return '';
		const div = document.createElement('div');
		div.textContent = text;
		return div.innerHTML;
	}

	// Refresh notifications and messages periodically
	setInterval(function() {
		loadNotifications();
		loadMessages();
	}, 30000); // Every 30 seconds
</script>

<style>
	.notification-badge {
		position: absolute;
		top: 0;
		right: 0;
		background-color: #ff4444;
		color: white;
		border-radius: 50%;
		width: 20px;
		height: 20px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 0.7em;
		font-weight: bold;
	}

	.btn-icon-nav {
		position: relative;
	}
</style>