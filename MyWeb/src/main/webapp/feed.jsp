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
					<h2 class="section-title">Nghe những bài đăng mới nhất từ ​​những người bạn đang theo dõi:</h2>
					<div class="feed-filter">
						<span>Đăng lại</span>
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
								<span class="post-time">đã đăng lại một bài hát 3 ngày trước</span>
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
								<span class="post-time">đã đăng một bài hát 7 ngày trước</span>
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
								<span class="post-time">đã đăng một bài hát 8 ngày trước</span>
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

			<!-- Right Column: Artists You Should Follow & Listening History -->
			<%@ include file="right_column.jsp" %>
		</div>

		</div>

	<%@ include file="player.jsp" %>
	<%@ include file="footer.jsp" %>
	<script src="assets/js/app.js"></script>
</body>
</html>