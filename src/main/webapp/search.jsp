<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">
<title>Tìm kiếm - BeatFlow</title>
<link rel="stylesheet" href="assets/css/search.css">
</head>
<body>

	<!-- NAVBAR -->
	<nav class="site-nav">
		<div
			class="container d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center gap-3">
				<div class="bf-logo d-flex align-items-center gap-2">
					<img src="assets/img/logo.png" alt="BeatFlow logo"
						class="bf-logo-img"> <span class="brand">BeatFlow</span>
				</div>
				<ul class="nav d-none d-md-flex">
					<li class="nav-item"><a class="nav-link" href="#">Trang
							chủ</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
					<li class="nav-item"><a class="nav-link" href="library.jsp">Thư
							viện</a></li>
				</ul>
			</div>

			<div class="flex-grow-1 px-4">
				<div class="search-wrapper">
					<input class="search-input" type="text" value="ballad"
						placeholder="Tìm kiếm những bài hát, bản nhạc, playlist, album" />
					<i class="bi bi-search search-icon"></i>
				</div>
			</div>

			<div class="d-flex align-items-center gap-3">
				<a href="#" class="nav-function-link">Dành cho nghệ sĩ</a> <a
					href="upload.jsp" class="nav-function-link">Đăng tải</a>

				<button class="btn-icon-nav" id="profileMenuButton"
					aria-label="Profile" aria-expanded="false" aria-haspopup="true">
					<img src="assets/img/profile_avatar.jpg" alt="Profile"
						class="profile-avatar-small">
				</button>

				<div class="dropdown-container">
					<button class="btn-icon-nav" id="dropdownMenuButton"
						aria-haspopup="true" aria-expanded="false" aria-label="Tài khoản">
						<i class="bi bi-chevron-down"></i>
					</button>
					<div class="dropdown-menu-custom" id="dropdownMenu" role="menu">
						<a href="#" class="dropdown-item-custom"><i
							class="bi bi-person"></i><span>Trang cá nhân</span></a> <a href="#"
							class="dropdown-item-custom"><i class="bi bi-heart"></i><span>Đã
								thích</span></a> <a href="#" class="dropdown-item-custom"><i
							class="bi bi-collection-play"></i><span>Playlist nhạc</span></a> <a
							href="#" class="dropdown-item-custom"><i
							class="bi bi-broadcast"></i><span>Đài phát thanh</span></a>
					</div>
				</div>

				<div class="dropdown-container">
					<button class="btn-icon-nav" id="notificationsMenuButton"
						aria-label="Thông báo" aria-expanded="false" aria-haspopup="true">
						<i class="bi bi-bell"></i>
					</button>
					<div class="messages-dropdown" id="notificationsMenu" role="menu">
						<div class="messages-header">
							<h5 class="m-0">Thông báo</h5>
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
					<button class="btn-icon-nav" id="messagesMenuButton"
						aria-label="Tin nhắn" aria-expanded="false" aria-haspopup="true">
						<i class="bi bi-envelope"></i>
					</button>
					<div class="messages-dropdown" id="messagesMenu" role="menu">
						<div class="messages-header">
							<h5 class="m-0">Tin nhắn</h5>
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

	<!-- SEARCH PAGE -->
	<main class="container search-page">
		<!-- Sidebar filters -->
		<aside class="search-sidebar">
			<h2 class="sr-title">Search results for “ballad”</h2>
			<p class="sr-meta">Found 500+ playlists, 500+ tracks, 500+ people</p>

			<div class="filter-list" id="filterList">
				<button class="filter-item active" data-target="all">Everything</button>
				<button class="filter-item" data-target="tracks">Tracks</button>
				<button class="filter-item" data-target="people">People</button>
				<button class="filter-item" data-target="albums">Albums</button>
				<button class="filter-item" data-target="playlists">Playlists</button>
			</div>

			<div class="legal-links">
				<a href="#">Legal</a> · <a href="#">Privacy</a> · <a href="#">Cookie
					Policy</a> · <a href="#">Artist Resources</a>
			</div>
			<div class="language">
				Language: <a href="#">Tiếng Việt (VN)</a>
			</div>
		</aside>

		<!-- Results -->
		<section class="search-results">
			<!-- Featured playlist style block -->
			<article class="featured">
				<div class="featured-cover">
					<img src="assets/img/playlist.jpg" alt="Featured cover">
					<button class="btn-play-lg" aria-label="Play">
						<i class="bi bi-play-fill"></i>
					</button>
				</div>
				<div class="featured-body">
					<div class="featured-head">
						<div>
							<div class="featured-author">Duy Quốc</div>
							<h3 class="featured-title">ballad việt</h3>
							<div class="featured-time">3 years ago</div>
						</div>
					</div>
					<div class="wave-skeleton" aria-hidden="true"></div>

					<!-- UPDATED: numbered list, bold title, muted uploader -->
					<ol class="featured-tracks">
						<li><span class="idx">1</span>
							<div class="ft-line">
								<span class="ft-title">Xuân Thi</span> <span class="sep">–</span>
								<span class="ft-artist">Phạm Mạnh Quỳnh souloftheforest</span>
							</div> <span class="plays"><i class="bi bi-play-fill"></i>150K</span></li>
						<li><span class="idx">2</span>
							<div class="ft-line">
								<span class="ft-title">Đấu có lời lắm</span> <span class="sep">–</span>
								<span class="ft-artist">Hà Anh Tuấn [ RC in SG ]</span>
							</div> <span class="plays"><i class="bi bi-play-fill"></i>2.66M</span>
						</li>
						<li><span class="idx">3</span>
							<div class="ft-line">
								<span class="ft-title">Chỉ Là Muốn Nói (New Version)</span> <span
									class="sep">–</span> <span class="ft-artist">Khải</span>
							</div> <span class="plays"><i class="bi bi-play-fill"></i>770K</span></li>
						<li><span class="idx">4</span>
							<div class="ft-line">
								<span class="ft-title">Tháng Tư Là Lời Nói Dối Của Em</span> <span
									class="sep">–</span> <span class="ft-artist">Hà Anh Tuấn</span>
							</div> <span class="plays"><i class="bi bi-play-fill"></i>4.58M</span>
						</li>
						<li><span class="idx">5</span>
							<div class="ft-line">
								<span class="ft-title">Chờ Anh Nhé</span> <span class="sep">–</span>
								<span class="ft-artist">Hoàng Dũng</span>
							</div> <span class="plays"><i class="bi bi-play-fill"></i>6.81M</span>
						</li>
					</ol>

					<div class="feat-actions">
						<a href="#" class="view-link"><strong>View 5,000
								tracks</strong></a>
						<div class="action-right">
							<button class="btn-chip">
								<i class="bi bi-heart"></i> 262
							</button>
							<button class="btn-chip">
								<i class="bi bi-arrow-left-right"></i> 5
							</button>
							<button class="btn-chip">
								<i class="bi bi-bookmark"></i>
							</button>
							<button class="btn-chip">
								<i class="bi bi-download"></i>
							</button>
						</div>
					</div>
				</div>
			</article>

			<!-- Tracks list -->
			<div class="result-group" data-group="tracks">
				<h4 class="rg-title">Tracks</h4>

				<article class="track-row">
					<img class="trk-thumb" src="assets/img/track1.jpg" alt="thumb">
					<button class="trk-play">
						<i class="bi bi-play-fill"></i>
					</button>
					<div class="trk-main">
						<a href="#" class="trk-artist">NU9EVE</a> <a href="#"
							class="trk-title">Người Đầu Tiên - Juky San (nueve remake)</a>
						<div class="trk-tags">
							<span class="tag">#Piano</span>
						</div>
						<div class="wave-skeleton small" aria-hidden="true"></div>
						<div class="trk-stats">
							<button class="btn-chip">
								<i class="bi bi-heart"></i> 3,127
							</button>
							<button class="btn-chip">
								<i class="bi bi-arrow-left-right"></i> 38
							</button>
							<button class="btn-chip">
								<i class="bi bi-bookmark"></i>
							</button>
							<button class="btn-chip">
								<i class="bi bi-download"></i>
							</button>
						</div>
					</div>
					<div class="trk-meta">
						<div class="time">1 month ago</div>
						<div class="plays">
							<i class="bi bi-play-fill"></i> 325K
						</div>
						<div class="cmts">
							<i class="bi bi-chat"></i> 12
						</div>
					</div>
				</article>

				<article class="track-row">
					<img class="trk-thumb" src="assets/img/track2.jpg" alt="thumb">
					<button class="trk-play">
						<i class="bi bi-play-fill"></i>
					</button>
					<div class="trk-main">
						<a href="#" class="trk-artist">Pierre Bourne</a> <a href="#"
							class="trk-title">Ballad</a>
						<div class="wave-skeleton small" aria-hidden="true"></div>
						<div class="trk-stats">
							<button class="btn-chip">
								<i class="bi bi-heart"></i> 1,208
							</button>
							<button class="btn-chip">
								<i class="bi bi-arrow-left-right"></i> 19
							</button>
							<button class="btn-chip">
								<i class="bi bi-bookmark"></i>
							</button>
							<button class="btn-chip">
								<i class="bi bi-download"></i>
							</button>
						</div>
					</div>
					<div class="trk-meta">
						<div class="time">6 years ago</div>
						<div class="plays">
							<i class="bi bi-play-fill"></i> 120K
						</div>
						<div class="cmts">
							<i class="bi bi-chat"></i> 9
						</div>
					</div>
				</article>

				<div class="load-more">
					<button class="btn-more">
						<i class="bi bi-arrow-clockwise"></i> Load more
					</button>
				</div>
			</div>

			<!-- People -->
			<div class="result-group" data-group="people" hidden>
				<h4 class="rg-title">People</h4>
				<div class="people-grid">
					<a href="#" class="person-card"> <img src="assets/img/user.jpg"
						alt="avatar">
						<div class="person-name">Takezo</div>
						<div class="person-sub">258K followers</div>
					</a> <a href="#" class="person-card"> <img
						src="assets/img/profile_avatar.jpg" alt="avatar">
						<div class="person-name">MCK</div>
						<div class="person-sub">120K followers</div>
					</a>
				</div>
			</div>

			<!-- Albums -->
			<div class="result-group" data-group="albums" hidden>
				<h4 class="rg-title">Albums</h4>
				<div class="card-row">
					<a href="#" class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/album1.jpg" class="playlist-img" alt="Album">
						</div>
						<div class="playlist-title">Best Ballads</div>
						<div class="playlist-desc">by Various</div>
					</a> <a href="#" class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/playlist2.jpg" class="playlist-img"
								alt="Album">
						</div>
						<div class="playlist-title">Piano Ballads</div>
						<div class="playlist-desc">by Various</div>
					</a>
				</div>
			</div>

			<!-- Playlists -->
			<div class="result-group" data-group="playlists" hidden>
				<h4 class="rg-title">Playlists</h4>
				<div class="card-row">
					<a href="#" class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/playlist3.jpg" class="playlist-img"
								alt="Playlist">
						</div>
						<div class="playlist-title">Ballad Việt</div>
						<div class="playlist-desc">by Takezo</div>
					</a> <a href="#" class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/playlist6.jpg" class="playlist-img"
								alt="Playlist">
						</div>
						<div class="playlist-title">Sad Ballads</div>
						<div class="playlist-desc">by Nu9eve</div>
					</a>
				</div>
			</div>

		</section>
	</main>

	<script src="assets/js/search.js"></script>
</body>
</html>