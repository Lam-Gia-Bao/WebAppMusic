<!-- NAVBAR -->
<nav class="site-nav">
	<div class="container d-flex align-items-center justify-content-between">
		<div class="d-flex align-items-center gap-3">
			<div class="bf-logo">
				<img src="assets/img/logo.png" alt="BeatFlow logo" class="bf-logo-img">
				<span class="brand">BeatFlow</span>
			</div>
			<ul class="nav d-none d-md-flex">
				<li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Thư viện</a></li>
			</ul>
		</div>
		<div class="flex-grow-1 px-4">
			<div class="search-wrapper">
				<input class="search-input" type="text" placeholder="Tìm kiếm những bài hát, bản nhạc, playlist, album">
				<i class="bi bi-search search-icon"></i>
			</div>
		</div>
		<div class="d-flex align-items-center gap-3">
			<a href="#" class="nav-function-link">Dành cho nghệ sĩ</a>
			<a href="upload.jsp" class="nav-function-link">Đăng tải</a>
			<button class="btn-icon-nav">
				<img src="assets/img/profile_avatar.jpg" alt="Profile" class="profile-avatar-small">
			</button>
			<div class="dropdown-container">
				<button class="btn-icon-nav" id="dropdownMenuButton">
					<i class="bi bi-chevron-down"></i>
				</button>
				<!-- Dropdown Menu -->
				<div class="dropdown-menu-custom" id="dropdownMenu">
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-person"></i>
						<span>Trang cá nhân</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-heart"></i>
						<span>Đã thích</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-collection-play"></i>
						<span>Playlist nhạc</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-broadcast"></i>
						<span>Đài phát thanh</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-people"></i>
						<span>Đang theo dõi</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-person-plus"></i>
						<span>Đề xuất theo dõi</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-music-note-list"></i>
						<span>Những bản track</span>
					</a>
					<a href="#" class="dropdown-item-custom">
						<i class="bi bi-bar-chart"></i>
						<span>Thông tin về người nghe</span>
					</a>
				</div>
			</div>
			<div class="dropdown-container">
				<button class="btn-icon-nav" id="notificationsMenuButton">
					<i class="bi bi-bell"></i>
				</button>
				<!-- Notifications Dropdown -->
				<div class="messages-dropdown" id="notificationsMenu">
					<div class="messages-header">
						<h5>Thông báo</h5>
					</div>
					<div class="messages-body">
						<p class="no-messages">Bạn chưa có thông báo nào.</p>
					</div>
					<div class="messages-footer">
						<a href="#" class="view-all-link">Xem tất cả thông báo</a>
					</div>
				</div>
			</div>
			<div class="dropdown-container">
				<button class="btn-icon-nav" id="messagesMenuButton">
					<i class="bi bi-envelope"></i>
				</button>
				<!-- Messages Dropdown -->
				<div class="messages-dropdown" id="messagesMenu">
					<div class="messages-header">
						<h5>Tin nhắn</h5>
					</div>
					<div class="messages-body">
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
