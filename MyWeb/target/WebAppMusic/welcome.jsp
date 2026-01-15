<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BeatFlow | Khám phá & Nghe nhạc</title>
<link rel="stylesheet" href="assets/css/welcome.css">
</head>
<body>
	<!-- Thanh header -->
	<header class="bf-header">
		<div class="bf-header-inner">
			<div class="bf-logo">
				<img src="assets/img/logo.png" alt="BeatFlow logo"
					class="bf-logo-img"> <span class="bf-logo-text">BeatFlow</span>
			</div>
			<nav class="bf-nav">
				<a class="btn btn-ghost" href="login">Đăng nhập</a>
				<a class="btn btn-primary" href="register">Tạo tài khoản</a>
				<a class="bf-link" href="profile">Dành cho Nghệ sĩ</a>
			</nav>
		</div>
	</header>

	<!-- Hero Banner-->
	<section class="bf-hero">
		<div class="bf-hero-bg"></div>

		<div class="bf-hero-content">
			<h1>
				Tìm kiếm.<br>Được mọi người tìm kiếm.
			</h1>
			<p>
				Tìm kiếm bản nhạc, danh sách phát mà bạn yêu thích hoặc trở thành
				nghệ sĩ được mọi người biết đến. <br>BeatFlow là một cộng đồng
				nơi người hâm mộ và nghệ sĩ cùng nhau khám phá và kết nối thông qua
				âm nhạc.
			</p>

			<div class="bf-hero-btns">
				<a class="btn btn-primary" href="register">Bắt đầu</a>
				<a class="btn btn-outline-light" href="login">Tìm hiểu thêm</a>
			</div>
		</div>
	</section>

	<!-- Search bar -->
	<section class="bf-search-wrap">
		<div class="bf-search-inner">
			<input class="bf-search-input" type="search"
				placeholder="Tìm nghệ sĩ, ban nhạc, bài hát, podcast..."> <span
				class="bf-or">hoặc</span>
			<a class="btn btn-primary" href="upload.jsp">Tải nhạc lên</a>
		</div>
	</section>

	<!-- Trending -->
	<section class="bf-trending">
		<div class="bf-trending-inner">
			<p class="bf-trending-title">Nghe những gì đang thịnh hành miễn
				phí trên cộng đồng BeatFlow</p>
			<button class="btn btn-primary">Khám phá danh sách phát nổi
				bật</button>
		</div>
	</section>

	<!-- Apps -->
	<section class="bf-apps">
		<div class="bf-apps-container">
			<div class="bf-apps-right">
				<img src="assets/img/app-preview.png" alt="App preview"
					class="app-preview">
			</div>
			<div class="bf-apps-left">
				<h2>Không bao giờ ngừng nghe</h2>
				<div class="bf-apps-underline"></div>
				<p class="bf-apps-lead">BeatFlow có mặt trên Web, iOS, Android,
					Chromecast và nhiều nền tảng khác.</p>
				<div class="bf-store-buttons">
					<img src="assets/img/appstore.png" alt="App Store"
						class="store-badge"> <img src="assets/img/googleplay.png"
						alt="Google Play" class="store-badge">
				</div>
			</div>
		</div>
	</section>

	<!-- Creators -->
	<section class="bf-creators">
		<div class="bf-creators-container">
			<div class="bf-creators-left">
				<h2>Kêu gọi tất cả nghệ sĩ</h2>
				<p>Tham gia BeatFlow để kết nối với người hâm mộ, chia sẻ âm
					nhạc và mở rộng cộng đồng của bạn. Bạn còn chờ gì?</p>
				<button class="btn btn-primary">Tìm hiểu thêm</button>
			</div>

			<div class="bf-creators-right">
				<img src="assets/img/artist.png" alt="Artist" class="artist-image">
			</div>
		</div>
	</section>

	<!-- Call to action -->
	<section class="bf-cta-join">
		<div class="bf-cta-inner">
			<h3>Cảm ơn bạn đã lắng nghe. Hãy tham gia ngay.</h3>
			<p>Lưu bài, theo dõi nghệ sĩ và tạo danh sách phát. Hoàn toàn
				miễn phí.</p>
			<a class="btn btn-primary" href="register">Tạo tài khoản</a>
			<p class="small">
				Đã có tài khoản? <a href="login">Đăng nhập</a>
			</p>
		</div>
	</section>

	<!-- Footer -->
	<footer class="py-4"
		style="background: #0d0d0d; color: #bbb; font-size: 0.9rem;">
		<div class="container text-center">
            <div class="bf-footer-links">
			<div class="mb-3">
				<a href="#" class="text-secondary me-2">Trang chính thức</a> · <a href="#"
					class="text-secondary mx-2">Bảo mật</a> · <a href="#"
					class="text-secondary mx-2">Chính sách Cookie</a> · <a href="#"
					class="text-secondary mx-2">Trình quản lý Cookie</a> · <a href="#"
					class="text-secondary mx-2">Xuất bản</a> · <a href="#"
					class="text-secondary mx-2">Nguồn nghệ sĩ</a> · <a href="#"
					class="text-secondary mx-2">Tin tức</a> · <a href="#"
					class="text-secondary mx-2">Biểu đồ</a> · <a href="#"
					class="text-secondary mx-2">Uy tín</a>
			</div>
			<div class="text-secondary">
				Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt (VN)</a>
			</div>
		</div>
		</div>
	</footer>
</body>
</html>
