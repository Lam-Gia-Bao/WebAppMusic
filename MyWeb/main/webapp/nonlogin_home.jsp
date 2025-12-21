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
<link rel="stylesheet" href="assets/css/home.css">
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
			<div class="d-flex gap-2">
				<button class="btn btn-sm btn-outline-light d-none d-md-inline">Đăng
					nhập</button>
				<button class="btn btn-sm btn-ghost">Tạo tài khoản</button>
			</div>
		</div>
	</nav>

	<div class="container home-wrapper">

		<!-- MAIN TITLE -->
		<h2 class="section-title">Khám phá các bản nhạc và danh sách phát</h2>

		<!-- Curated for your taste -->
		<h4 class="sub-title">Đề cử theo sở thích của bạn</h4>

		<div class="d-flex gap-4 flex-wrap mb-4">

			<!-- PLAYLIST CARD -->
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

		<!-- Artists to watch out for -->
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

</body>
</html>