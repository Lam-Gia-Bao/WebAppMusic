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
<link rel="stylesheet" href="assets/css/playlist_detail.css">
<title>Playlist Detail - BeatFlow</title>
</head>
<body>
	<%@ include file="header.jsp" %>

	<div class="playlist-detail-wrapper">
		<div class="container">
		<div class="row">
			<!-- Main Content -->
			<div class="col-12">
				<!-- Playlist Header -->
				<div class="playlist-hero">
					<button class="hero-play-btn">
						<i class="bi bi-play-fill"></i>
					</button>
					<div class="playlist-hero-content">
						<h1 class="playlist-hero-title">Related tracks: CA PHÊ - MIN (CLOUDEE REMIX)</h1>
						<div class="playlist-meta">
							<span class="badge-private"><i class="bi bi-lock-fill"></i> PRIVATE</span>
						</div>
						<div class="playlist-creator">Made for Bảo Lâm</div>
					</div>
				</div>

				<!-- Waveform Section -->
				<div class="waveform-section">
					<div class="waveform-container">
						<div class="waveform-bars">
							<!-- Generate multiple bars for waveform effect -->
							<% for(int i = 0; i < 200; i++) { 
								int height = (int)(Math.random() * 80) + 20;
							%>
								<div class="waveform-bar" style="height: <%= height %>%"></div>
							<% } %>
						</div>
						<div class="waveform-time-start">0:00</div>
						<div class="waveform-time-end">1:13</div>
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="playlist-actions">
					<button class="btn-action-large liked">
						<i class="bi bi-heart-fill"></i>
						<span>Liked</span>
					</button>
					<button class="btn-action-large">
						<i class="bi bi-share"></i>
						<span>Share</span>
					</button>
					<button class="btn-action-large">
						<i class="bi bi-clock-history"></i>
						<span>Add to Next up</span>
					</button>
					<button class="btn-action-large">
						<i class="bi bi-three-dots"></i>
						<span>More</span>
					</button>
					<div class="likes-count">
						<i class="bi bi-heart"></i> 1
					</div>
				</div>

				<!-- Related Tracks List -->
				<div class="related-tracks">
					<div class="track-item">
						<div class="track-number">1</div>
						<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="track-avatar">
						<div class="track-info">
							<div class="track-artist">CLOUDEE</div>
							<div class="track-title">CA PHÊ - MIN (CLOUDEE REMIX)</div>
						</div>
						<div class="track-stats">
							<i class="bi bi-play-fill"></i> 261K
						</div>
					</div>

					<div class="track-item">
						<div class="track-number">2</div>
						<img src="assets/img/avt_bad-bunny.jpg" alt="Artist" class="track-avatar">
						<div class="track-info">
							<div class="track-artist">prod.arya</div>
							<div class="track-title">buong doi tay nhau ra in 5 genres</div>
						</div>
						<div class="track-stats">
							<i class="bi bi-play-fill"></i> 224K
						</div>
					</div>

					<div class="track-item">
						<div class="track-number">3</div>
						<img src="assets/img/avt_doja-cat.png" alt="Artist" class="track-avatar">
						<div class="track-info">
							<div class="track-artist">Sick Goldra</div>
							<div class="track-title">2 THÁNG BÍP - VÊ QUÊ // 24k.RIGHT x MAS x MIKELODIC ( REMIX )</div>
						</div>
						<div class="track-stats">
							<i class="bi bi-play-fill"></i> 157K
						</div>
					</div>

					<div class="track-item">
						<div class="track-number">4</div>
						<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="track-avatar">
						<div class="track-info">
							<div class="track-artist">Bazos</div>
							<div class="track-title">Trước khi em tớn lại drill</div>
						</div>
						<div class="track-stats">
							<i class="bi bi-play-fill"></i> 376K
						</div>
					</div>

					<div class="track-item">
						<div class="track-number">5</div>
						<img src="assets/img/avt_bad-bunny.jpg" alt="Artist" class="track-avatar">
						<div class="track-info">
							<div class="track-artist">CLOUDEE</div>
							<div class="track-title">NHẢY CẦU (CLOUDEE REMIX)</div>
						</div>
						<div class="track-stats">
							<i class="bi bi-play-fill"></i> 198K
						</div>
					</div>

					<div class="track-item">
						<div class="track-number">6</div>
						<img src="assets/img/avt_doja-cat.png" alt="Artist" class="track-avatar">
						<div class="track-info">
							<div class="track-artist">prod.arya</div>
							<div class="track-title">cung tim nhau la cua nhau</div>
						</div>
						<div class="track-stats">
							<i class="bi bi-play-fill"></i> 142K
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
