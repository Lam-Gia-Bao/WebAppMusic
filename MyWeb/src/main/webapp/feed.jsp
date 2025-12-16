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
<link rel="stylesheet" href="assets/css/feed.css">
<title>Feed</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<script>
		// Change active nav to "Tin tức" for feed page
		document.addEventListener('DOMContentLoaded', function() {
			const navLinks = document.querySelectorAll('.site-nav .nav-link');
			navLinks.forEach(link => {
				link.classList.remove('active');
				if (link.textContent.trim() === 'Tin tức') {
					link.classList.add('active');
				}
			});
		});
	</script>

	<div class="container home-wrapper">

		<!-- Two Column Layout -->
		<div class="row">
			<!-- Left Column: Playlists -->
			<div class="col-lg-8">
				<!-- MAIN TITLE -->
				<!-- Feed Header -->
				<div class="feed-header">
					<h2 class="section-title">Hear the latest posts from the people you're following:</h2>
					<div class="feed-filter">
						<span>Reposts</span>
						<label class="feed-toggle">
							<input type="checkbox" checked>
							<span class="toggle-slider"></span>
						</label>
					</div>
				</div>

				<!-- Feed Posts -->
				<div class="feed-posts">
					<!-- Post 1 -->
					<div class="feed-post">
						<div class="post-header">
							<img src="assets/img/avt_travis-scott.jpg" alt="User" class="post-avatar">
							<div class="post-user-info">
								<span class="post-username">Bảo Lâm</span>
								<i class="bi bi-repeat" style="font-size: 14px; color: #999; margin: 0 5px;"></i>
								<span class="post-time">reposted a track 3 days ago</span>
							</div>
						</div>

						<div class="post-content">
							<img src="assets/img/edm-playlist.jpg" alt="Track" class="post-cover">
							<div class="post-player">
								<div class="player-top">
									<button class="post-play-btn">
										<i class="bi bi-play-fill"></i>
									</button>
									<div class="track-info">
										<div class="track-artist">buitruonglinh</div>
										<div class="track-title">Dù Cho Mai Về Sau (demo)</div>
									</div>
									<div class="post-tag"># R&B & Soul</div>
								</div>
								<div class="track-waveform">
									<div class="waveform-track">
										<div class="waveform-progress"></div>
										<div class="waveform-thumb"></div>
									</div>
									<div class="track-duration">3:00</div>
								</div>
								<div class="post-actions">
									<div class="action-buttons">
										<button class="post-action-btn liked">
											<i class="bi bi-heart-fill"></i>
											<span>22.4K</span>
										</button>
										<button class="post-action-btn reposted">
											<i class="bi bi-repeat"></i>
											<span>638</span>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-share"></i>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-files"></i>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-three-dots"></i>
										</button>
									</div>
									<div class="post-stats">
										<span class="plays"><i class="bi bi-play-fill"></i> 3.55M</span>
										<span class="comments"><i class="bi bi-chat"></i> 580</span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Post 2 -->
					<div class="feed-post">
						<div class="post-header">
							<img src="assets/img/avt_bad-bunny.jpg" alt="User" class="post-avatar">
							<div class="post-user-info">
								<span class="post-username">Minh Anh</span>
								<span class="post-time">posted a track 7 days ago</span>
							</div>
						</div>

						<div class="post-content">
							<img src="assets/img/nkl2-playlist.jpg" alt="Track" class="post-cover">
							<div class="post-player">
								<div class="player-top">
									<button class="post-play-btn">
										<i class="bi bi-play-fill"></i>
									</button>
									<div class="track-info">
										<div class="track-artist">Hensonn</div>
										<div class="track-title">taca taca bro (unreleased)</div>
									</div>
									<div class="post-tag"># Electronic</div>
								</div>
								<div class="track-waveform">
									<div class="waveform-track">
										<div class="waveform-progress"></div>
										<div class="waveform-thumb"></div>
									</div>
									<div class="track-duration">3:05</div>
								</div>
								<div class="post-actions">
									<div class="action-buttons">
										<button class="post-action-btn">
											<i class="bi bi-heart"></i>
											<span>87</span>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-repeat"></i>
											<span>12</span>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-share"></i>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-files"></i>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-three-dots"></i>
										</button>
									</div>
									<div class="post-stats">
										<span class="plays"><i class="bi bi-play-fill"></i> 1.57K</span>
										<span class="comments"><i class="bi bi-chat"></i> 9</span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Post 3 -->
					<div class="feed-post">
						<div class="post-header">
							<img src="assets/img/avt_doja-cat.png" alt="User" class="post-avatar">
							<div class="post-user-info">
								<span class="post-username">Thu Hà</span>
								<span class="post-time">posted a track 8 days ago</span>
							</div>
						</div>

						<div class="post-content">
							<img src="assets/img/pop-playlist.jpg" alt="Track" class="post-cover">
							<div class="post-player">
								<div class="player-top">
									<button class="post-play-btn">
										<i class="bi bi-play-fill"></i>
									</button>
									<div class="track-info">
										<div class="track-artist">Htingale</div>
										<div class="track-title">winter song</div>
									</div>
									<div class="post-tag"># Deep House</div>
								</div>
								<div class="track-waveform">
									<div class="waveform-track">
										<div class="waveform-progress"></div>
										<div class="waveform-thumb"></div>
									</div>
									<div class="track-duration">4:15</div>
								</div>
								<div class="post-actions">
									<div class="action-buttons">
										<button class="post-action-btn">
											<i class="bi bi-heart"></i>
											<span>52</span>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-repeat"></i>
											<span>8</span>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-share"></i>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-files"></i>
										</button>
										<button class="post-action-btn">
											<i class="bi bi-three-dots"></i>
										</button>
									</div>
									<div class="post-stats">
										<span class="plays"><i class="bi bi-play-fill"></i> 892</span>
										<span class="comments"><i class="bi bi-chat"></i> 4</span>
									</div>
								</div>
							</div>
						</div>
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
						<a href="#" class="view-all-link-small">Xem tất cả</a>
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

		</div>

	<%@ include file="player.jsp" %>
	<%@ include file="footer.jsp" %>
	<script src="assets/js/app.js"></script>
</body>
</html>