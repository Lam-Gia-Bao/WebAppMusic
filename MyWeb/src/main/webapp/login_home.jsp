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

			<!-- Right Column extracted to separate JSP -->
			<%@ include file="right_column.jsp" %>
		</div>
	</div>

	<%@ include file="player.jsp" %>
	<%@ include file="footer.jsp" %>
	<script src="assets/js/app.js"></script>
</body>
</html>