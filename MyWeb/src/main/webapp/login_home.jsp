<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1" />
<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/home.css?v=2">
<link rel="stylesheet" href="assets/css/next_up.css">
<title>Home</title>
</head>
<body>
	<%@ include file="header.jsp" %>

	<div class="container home-wrapper">
		<div class="row">
			<!-- Left Column: playlists -->
			<div class="col-lg-8">
				<h2 class="section-title">Khám phá các bản nhạc và danh sách phát</h2>
				<h4 class="sub-title">Đề cử theo sở thích của bạn</h4>

				<div class="d-flex gap-4 flex-wrap mb-4">
					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/edm-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
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
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
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
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
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
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Rap và Hip-Hop</div>
						<div class="playlist-desc">RnH</div>
					</div>
				</div>

				<h4 class="sub-title">Nghệ sĩ đáng chú ý</h4>
				<div class="d-flex gap-4 flex-wrap">
					<div class="playlist-card">
						<div class="playlist-img-wrapper">
							<img src="assets/img/viet-playlist.jpg" class="playlist-img">
							<div class="playlist-overlay">
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
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
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
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
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
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
								<button class="btn-play"><i class="bi bi-play-fill"></i></button>
								<div class="playlist-actions">
									<button class="btn-action"><i class="bi bi-heart"></i></button>
									<button class="btn-action"><i class="bi bi-person-plus"></i></button>
									<button class="btn-action"><i class="bi bi-three-dots"></i></button>
								</div>
							</div>
						</div>
						<div class="playlist-title">Pop</div>
						<div class="playlist-desc">New!</div>
					</div>
				</div>
			</div>

			<!-- Right Column: Artists & history -->
			<div class="col-lg-4">
				<h2 class="section-title artist-section-title">Các nghệ sĩ thịnh hành</h2>
				<button class="btn-refresh-artists mb-3">
					<span>Làm mới danh sách</span>
				</button>

				<div class="artists-list">
					<div class="artist-card">
						<img src="assets/img/avt_travis-scott.jpg" alt="Travis Scott" class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">Travis Scott <i class="bi bi-patch-check-fill verified-icon"></i></div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 5.56M</span>
								<span><i class="bi bi-music-note-beamed"></i> 174</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>

					<div class="artist-card">
						<img src="assets/img/avt_bad-bunny.jpg" alt="Bad Bunny" class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">Bad Bunny <i class="bi bi-patch-check-fill verified-icon"></i></div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 2.51M</span>
								<span><i class="bi bi-music-note-beamed"></i> 167</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>

					<div class="artist-card">
						<img src="assets/img/avt_doja-cat.png" alt="Doja Cat" class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">DOJA CAT <i class="bi bi-patch-check-fill verified-icon"></i></div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 1.73M</span>
								<span><i class="bi bi-music-note-beamed"></i> 164</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>
				</div>

				<div class="listening-history-section mt-5">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="history-title">Lịch sử nghe nhạc</h4>
						<a href="#" class="view-all-link-small">View all</a>
					</div>

					<div class="history-list">
						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/ca-phe_song.jpg" alt="Song thumbnail" class="history-thumbnail">
								<button class="history-play-btn"><i class="bi bi-play-fill"></i></button>
							</div>
							<div class="history-info">
								<div class="history-artist">Lil Liem</div>
								<div class="history-song-title">uocgianhaynoiyeutoi</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 353K</span>
									<span><i class="bi bi-heart-fill"></i> 3,527</span>
									<span><i class="bi bi-repeat"></i> 88</span>
									<span><i class="bi bi-chat"></i> 78</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like"><i class="bi bi-heart"></i></button>
								<button class="history-action-btn" title="More"><i class="bi bi-three-dots"></i></button>
							</div>
						</div>

						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/kem-duyen_song.jpg" alt="Song thumbnail" class="history-thumbnail">
								<button class="history-play-btn"><i class="bi bi-play-fill"></i></button>
							</div>
							<div class="history-info">
								<div class="history-artist">n1ay</div>
								<div class="history-song-title">KÈM DUYÊN (remix by Higo) (reup on ...</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 127K</span>
									<span><i class="bi bi-heart-fill"></i> 964</span>
									<span><i class="bi bi-repeat"></i> 10</span>
									<span><i class="bi bi-chat"></i> 9</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like"><i class="bi bi-heart"></i></button>
								<button class="history-action-btn" title="More"><i class="bi bi-three-dots"></i></button>
							</div>
						</div>

						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/kem-duyen-drill_song.jpg" alt="Song thumbnail" class="history-thumbnail">
								<button class="history-play-btn"><i class="bi bi-play-fill"></i></button>
							</div>
							<div class="history-info">
								<div class="history-artist">Sevenlow</div>
								<div class="history-song-title">Kem duyen drill mix tiktok</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 95.5K</span>
									<span><i class="bi bi-heart-fill"></i> 851</span>
									<span><i class="bi bi-repeat"></i> 9</span>
									<span><i class="bi bi-chat"></i> 7</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like"><i class="bi bi-heart"></i></button>
								<button class="history-action-btn" title="More"><i class="bi bi-three-dots"></i></button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="assets/js/app.js"></script>
	<script src="assets/js/login_home.js"></script>
	<%@ include file="footer.jsp" %>
	<%@ include file="player.jsp" %>
</body>
</html>