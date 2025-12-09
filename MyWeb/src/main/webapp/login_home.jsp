<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1" />
<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/home.css?v=2">
<title>Home</title>
</head>
<body>
	<!-- NAVBAR -->
	<nav class="site-nav">
		<div
			class="container d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center gap-3">
				<div class="bf-logo">
					<img src="assets/img/logo.png" alt="BeatFlow logo"
						class="bf-logo-img"> <span class="brand">BeatFlow</span>
				</div>
				<ul class="nav d-none d-md-flex">
					<li class="nav-item"><a class="nav-link active" href="#">Trang
							chủ</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Thư viện</a></li>
				</ul>
			</div>
			<div class="flex-grow-1 px-4">
				<div class="search-wrapper">
					<input class="search-input" type="text"
						placeholder="Tìm kiếm những bài hát, bản nhạc, playlist, album">
					<i class="bi bi-search search-icon"></i>
				</div>
			</div>
			<div class="d-flex align-items-center gap-3">
				<a href="#" class="nav-function-link">Dành cho nghệ sĩ</a> <a
					href="upload.jsp" class="nav-function-link">Đăng tải</a>
				<button class="btn-icon-nav">
					<img src="assets/img/profile_avatar.jpg" alt="Profile"
						class="profile-avatar-small">
				</button>
				<div class="dropdown-container">
					<button class="btn-icon-nav" id="dropdownMenuButton">
						<i class="bi bi-chevron-down"></i>
					</button>
					<!-- Dropdown Menu -->
					<div class="dropdown-menu-custom" id="dropdownMenu">
						<a href="#" class="dropdown-item-custom"> <i
							class="bi bi-person"></i> <span>Trang cá nhân</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-heart"></i> <span>Đã thích</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-collection-play"></i> <span>Playlist nhạc</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-broadcast"></i> <span>Đài phát thanh</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-people"></i> <span>Đang theo dõi</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-person-plus"></i> <span>Đề xuất theo dõi</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-music-note-list"></i> <span>Những bản track</span>
						</a> <a href="#" class="dropdown-item-custom"> <i
							class="bi bi-bar-chart"></i> <span>Thông tin về người nghe</span>
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

	<div class="container home-wrapper">

		<!-- Two Column Layout -->
		<div class="row">
			<!-- Left Column: Playlists -->
			<div class="col-lg-8">
				<!-- MAIN TITLE -->
				<h2 class="section-title">Khám phá các bản nhạc và danh sách
					phát</h2>

				<h4 class="sub-title">Nhiều hơn những gì bạn thích</h4>

				<div class="d-flex gap-4 flex-wrap mb-4">

					<!-- PLAYLIST CARD -->
					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/edm-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Electronic Dance Music</div>
						<div class="playlist-desc">EDM</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/nkl2-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Nhạc Không Lời</div>
						<div class="playlist-desc">NKL</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/pop-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Nhạc POP</div>
						<div class="playlist-desc">POP</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/rnh-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Rap và Hip-Hop</div>
						<div class="playlist-desc">RnH</div>
					</div>
				</div>

				<!-- Artists to watch out for -->
				<h4 class="sub-title">Nghệ sĩ đáng chú ý</h4>

				<div class="d-flex gap-4 flex-wrap">

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/viet-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Nhạc Việt</div>
						<div class="playlist-desc">New!</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/edm2-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Electronic</div>
						<div class="playlist-desc">New!</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/rnh2-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Hip Hop & Rap</div>
						<div class="playlist-desc">New!</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/pop2-playlist.png" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Pop</div>
						<div class="playlist-desc">New!</div>
					</div>

				</div>

				<!-- Recently Played -->
				<h4 class="sub-title">Bạn đã nghe gần đây</h4>

				<div class="d-flex gap-4 flex-wrap mb-4">

					<!-- PLAYLIST CARD -->
					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/edm-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Electronic Dance Music</div>
						<div class="playlist-desc">EDM</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/nkl2-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Nhạc Không Lời</div>
						<div class="playlist-desc">NKL</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/pop-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Nhạc POP</div>
						<div class="playlist-desc">POP</div>
					</div>

					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/rnh-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="playlist-actions">
									<button class="btn-action">
										<i class="bi bi-heart"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-person-plus"></i>
									</button>
									<button class="btn-action">
										<i class="bi bi-three-dots"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Rap và Hip-Hop</div>
						<div class="playlist-desc">RnH</div>
					</div>
				</div>
			</div>

			<!-- Right Column: Artists You Should Follow -->
			<div class="col-lg-4">
				<h2 class="section-title artist-section-title">Các nghệ sĩ
					thịnh hành</h2>
				<button class="btn-refresh-artists mb-3">
					<span>Làm mới danh sách</span>
				</button>

				<!-- Artist Cards -->
				<div class="artists-list">
					<div class="artist-card">
						<img src="assets/img/avt_travis-scott.jpg" alt="Travis Scott"
							class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">
								Travis Scott <i class="bi bi-patch-check-fill verified-icon"></i>
							</div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 5.56M</span> <span><i
									class="bi bi-music-note-beamed"></i> 174</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>

					<div class="artist-card">
						<img src="assets/img/avt_bad-bunny.jpg" alt="Bad Bunny"
							class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">
								Bad Bunny <i class="bi bi-patch-check-fill verified-icon"></i>
							</div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 2.51M</span> <span><i
									class="bi bi-music-note-beamed"></i> 167</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>

					<div class="artist-card">
						<img src="assets/img/avt_doja-cat.png" alt="Doja Cat"
							class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">
								DOJA CAT <i class="bi bi-patch-check-fill verified-icon"></i>
							</div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 1.73M</span> <span><i
									class="bi bi-music-note-beamed"></i> 164</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>
				</div>

				<!-- Listening History Section -->
				<div class="listening-history-section mt-5">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="history-title">Lịch sử nghe nhạc</h4>
						<a href="#" class="view-all-link-small">View all</a>
					</div>

					<!-- History Items -->
					<div class="history-list">
						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/ca-phe_song.jpg" alt="Song thumbnail"
									class="history-thumbnail">
								<button class="history-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
							</div>
							<div class="history-info">
								<div class="history-artist">Lil Liem</div>
								<div class="history-song-title">uocgianhaynoiyeutoi</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 353K</span> <span><i
										class="bi bi-heart-fill"></i> 3,527</span> <span><i
										class="bi bi-repeat"></i> 88</span> <span><i
										class="bi bi-chat"></i> 78</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like">
									<i class="bi bi-heart"></i>
								</button>
								<button class="history-action-btn" title="More">
									<i class="bi bi-three-dots"></i>
								</button>
							</div>
						</div>

						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/kem-duyen_song.jpg" alt="Song thumbnail"
									class="history-thumbnail">
								<button class="history-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
							</div>
							<div class="history-info">
								<div class="history-artist">n1ay</div>
								<div class="history-song-title">KÈM DUYÊN (remix by Higo)
									(reup on ...</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 127K</span> <span><i
										class="bi bi-heart-fill"></i> 964</span> <span><i
										class="bi bi-repeat"></i> 10</span> <span><i
										class="bi bi-chat"></i> 9</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like">
									<i class="bi bi-heart"></i>
								</button>
								<button class="history-action-btn" title="More">
									<i class="bi bi-three-dots"></i>
								</button>
							</div>
						</div>

						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/kem-duyen-drill_song.jpg" alt="Song thumbnail"
									class="history-thumbnail">
								<button class="history-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
							</div>
							<div class="history-info">
								<div class="history-artist">Sevenlow</div>
								<div class="history-song-title">Kem duyen drill mix tiktok</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 95.5K</span> <span><i
										class="bi bi-heart-fill"></i> 851</span> <span><i
										class="bi bi-repeat"></i> 9</span> <span><i class="bi bi-chat"></i>
										7</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like">
									<i class="bi bi-heart"></i>
								</button>
								<button class="history-action-btn" title="More">
									<i class="bi bi-three-dots"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- JavaScript for Dropdown -->
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				// Profile dropdown
				const dropdownButton = document
						.getElementById('dropdownMenuButton');
				const dropdownMenu = document.getElementById('dropdownMenu');

				// Notifications dropdown
				const notificationsButton = document
						.getElementById('notificationsMenuButton');
				const notificationsMenu = document
						.getElementById('notificationsMenu');

				// Messages dropdown
				const messagesButton = document
						.getElementById('messagesMenuButton');
				const messagesMenu = document.getElementById('messagesMenu');

				dropdownButton.addEventListener('click', function(e) {
					e.stopPropagation();
					dropdownMenu.classList.toggle('show');
					messagesMenu.classList.remove('show');
					notificationsMenu.classList.remove('show');
				});

				notificationsButton.addEventListener('click', function(e) {
					e.stopPropagation();
					notificationsMenu.classList.toggle('show');
					dropdownMenu.classList.remove('show');
					messagesMenu.classList.remove('show');
				});

				messagesButton.addEventListener('click', function(e) {
					e.stopPropagation();
					messagesMenu.classList.toggle('show');
					dropdownMenu.classList.remove('show');
					notificationsMenu.classList.remove('show');
				});

				// Close dropdowns when clicking outside
				document.addEventListener('click', function(e) {
					if (!dropdownMenu.contains(e.target)
							&& e.target !== dropdownButton) {
						dropdownMenu.classList.remove('show');
					}
					if (!notificationsMenu.contains(e.target)
							&& e.target !== notificationsButton) {
						notificationsMenu.classList.remove('show');
					}
					if (!messagesMenu.contains(e.target)
							&& e.target !== messagesButton) {
						messagesMenu.classList.remove('show');
					}
				});
			});
		</script>

		<!-- Footer -->
		<footer class="py-4"
			style="background: #0d0d0d; color: #bbb; font-size: 0.9rem;">
			<div class="container text-center">
				<div class="bf-footer-links">
					<div class="mb-3">
						<a href="#" class="text-secondary me-2">Trang chính thức</a> · <a
							href="#" class="text-secondary mx-2">Bảo mật</a> · <a href="#"
							class="text-secondary mx-2">Chính sách Cookie</a> · <a href="#"
							class="text-secondary mx-2">Trình quản lý Cookie</a> · <a
							href="#" class="text-secondary mx-2">Xuất bản</a> · <a href="#"
							class="text-secondary mx-2">Nguồn nghệ sĩ</a> · <a href="#"
							class="text-secondary mx-2">Tin tức</a> · <a href="#"
							class="text-secondary mx-2">Biểu đồ</a> · <a href="#"
							class="text-secondary mx-2">Uy tín</a>
					</div>
					<div class="text-secondary">
						Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt
							(VN)</a>
					</div>
				</div>
			</div>
		</footer>
	</div>
	
	<!-- Fixed Music Player Bar -->
	<div class="fixed-player-bar">
		<div class="player-container">
			<!-- Previous/Play/Next Controls -->
			<div class="player-controls-left">
				<button class="player-btn">
					<i class="bi bi-skip-backward-fill"></i>
				</button>
				<button class="player-btn player-play-btn">
					<i class="bi bi-play-fill"></i>
				</button>
				<button class="player-btn">
					<i class="bi bi-skip-forward-fill"></i>
				</button>
			</div>
			
			<!-- Progress Bar -->
			<div class="player-progress-section">
				<span class="player-time">0:00</span>
				<div class="player-progress-bar">
					<div class="player-progress-fill"></div>
				</div>
				<span class="player-time">3:04</span>
			</div>
			
			<!-- Song Info Center -->
			<div class="player-song-info">
				<img src="assets/img/ca-phe_song.jpg" alt="Now Playing" class="player-song-thumb">
				<div class="player-song-details">
					<div class="player-song-title">Lil Liem</div>
					<div class="player-song-artist">uocgianhaynoiyeutoi</div>
				</div>
			</div>
			
			<!-- Volume & More Controls -->
			<div class="player-controls-right">
				<button class="player-btn">
					<i class="bi bi-shuffle"></i>
				</button>
				<button class="player-btn">
					<i class="bi bi-chat"></i>
				</button>
				<div class="player-volume-control">
					<i class="bi bi-volume-up"></i>
					<input type="range" class="player-volume-slider" min="0" max="100" value="50">
				</div>
				<button class="player-btn">
					<i class="bi bi-justify"></i>
				</button>
			</div>
		</div>
	</div>

</body>
</html>