<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!Doctype html>
<html lang="vi">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Đăng tải nhạc của bạn ngay</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/upload-intro.css">
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
					<li class="nav-item"><a class="nav-link" href="#">Trang
							chủ</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Thư viện
							nhạc</a></li>
				</ul>
			</div>

			<div class="d-flex gap-2">
				<button class="btn btn-sm btn-outline-light d-none d-md-inline">Đăng
					nhập</button>
				<button class="btn btn-sm btn-ghost">Tạo tài khoản</button>
			</div>
		</div>
	</nav>

	<!-- HERO -->
	<header class="hero">
		<div class="container">
			<div class="row align-items-start">
				<div class="col-lg-6 hero-left">
					<h1>Đăng lên album đầu tiên của bạn</h1>
					<p class="lead">Chia sẻ các bản nhạc của bạn và truy cập các
						công cụ bạn cần để đột phá và xây dựng di sản của mình.</p>
					<div class="mb-4">
						<button class="btn btn-ghost btn-lg">Đăng bản nhạc đầu
							tiên của bạn</button>
					</div>
				</div>
			</div>
		</div>

		<!-- black info strip overlapping bottom -->
		<div class="info-strip mt-4">
			<div class="container">
				<div class="row text-center text-md-start">
					<div class="col-md-4 info-item mb-3">
						<h6>Thống kê thời gian thực</h6>
						<p>Xem người hâm mộ nào nghe nhạc của bạn nhiều nhất và những
							người hâm mộ hàng đầu của bạn ở khu vực nào, tất cả đều theo thời
							gian thực.</p>
					</div>
					<div class="col-md-4 info-item mb-3">
						<h6>Tìm cộng đồng của bạn</h6>
						<p>Chia sẻ tác phẩm của bạn với hàng triệu người nghe hàng
							ngày hoặc chia sẻ liên kết riêng tư với một vài người rất đặc
							biệt của bạn</p>
					</div>
					<div class="col-md-4 info-item mb-3">
						<h6>Kết nối trực tiếp với người hâm mộ</h6>
						<p>Với tính năng nhắn tin trực tiếp và bình luận trong bài
							đăng, bạn luôn có thể giữ liên lạc với người hâm mộ.</p>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- MAIN SECTION -->
	<main class="main-section">
		<div class="container">
			<div class="row align-items-start mb-4">
				<div class="col-lg-8">
					<div class="main-title">Tạo ở đây, phát ở mọi nơi</div>
					<div class="accent-line"></div>
					<p class="text-muted">Hãy tham gia cộng đồng sáng tạo đa dạng
						nhất thế giới, từ những người chia sẻ ca khúc đầu tay cho đến
						những nghệ sĩ gây sốt. Dù bạn đang ở giai đoạn nào trong sự
						nghiệp, BeatFlow chính là nơi bạn hướng đến.</p>
				</div>
				<div class="col-lg-4 text-lg-end d-none d-lg-block">
					<button class="join-btn">Tham gia ngay</button>
				</div>
			</div>

			<div class="row g-4">
				<div class="col-md-4">
					<div class="testi-card">
						<div class="meta">
							<strong>Taylor Swift</strong>
							<div class="count">36.4M</div>
						</div>
						<img
							src="assets/img/taylor-swift.png"
							alt="cover"
							style="width: 100%; height: 350px; object-fit: cover; border-radius: 4px; margin-bottom: .6rem;">
						<p class="quote">"Khi tôi mới bắt đầu đưa âm nhạc của mình lên
							internet, tôi đã sử dụng BeatFlow vì nền tảng này đã giúp tôi tải
							lên và chia sẻ nhạc một cách dễ dàng và trực tiếp."</p>
					</div>
				</div>
				
				<div class="col-md-4">
					<div class="testi-card">
						<div class="meta">
							<strong>Ed Sheeran</strong>
							<div class="count">747K</div>
						</div>
						<img
							src="assets/img/ed-sheeran.jpg"
							alt="cover"
							style="width: 100%; height: 350px; object-fit: cover; border-radius: 4px; margin-bottom: .6rem;">
						<p class="quote">"BeatFlow là một công cụ thiết yếu cho những
							nghệ sĩ độc lập như tôi. Ngay từ đầu, nó đã cung cấp cho tôi một
							cách đơn giản và hiệu quả để chia sẻ âm nhạc của mình với thế
							giới!"</p>
					</div>
				</div>

				<div class="col-md-4">
					<div class="testi-card">
						<div class="meta">
							<strong>Drake</strong>
							<div class="count">325K</div>
						</div>
						<img
							src="assets/img/drake.jpg"
							alt="cover"
							style="width: 100%; height: 350px; object-fit: cover; border-radius: 4px; margin-bottom: .6rem;">
						<p class="quote">"BeatFlow cho phép tôi có một nơi để tải ngay
							các bài hát của mình lên và gửi những suy nghĩ và cảm xúc của
							mình đến mọi người trên khắp thế giới một cách đơn giản."</p>
					</div>
				</div>
			</div>

			<!-- Mobile place for Join Now -->
			<div class="d-block d-lg-none text-center mt-4">
				<button class="join-btn">Tham gia ngay</button>
			</div>
		</div>
	</main>

	<section class="py-5" style="background: #0d0d0d; color: #fff;">
		<div class="container">

			<div class="mb-4">
				<h2 class="fw-bold" style="font-size: 2rem;">
					Kết nối với người hâm mộ và xem<br>ai đang nghe nhạc của bạn
				</h2>
				<div class="accent-line"></div>
				<p class="text-light" style="max-width: 650px;">Tải lên chỉ là
					bước đầu: BeatFlow cung cấp cho bạn các công cụ để thăng tiến trong
					sự nghiệp.</p>
			</div>

			<!-- 3 Columns -->
			<div class="row text-center text-md-start mb-5">

				<div class="col-md-4 mb-4">
					<h5 class="fw-bold text-white">Chia sẻ các bản nhạc của bạn ở
						bất kỳ đâu trên web</h5>
					<p class="text-light">Sử dụng trình phát nhúng và thẻ âm thanh
						để chia sẻ các bản nhạc của bạn ở bất cứ nơi đâu, cho mọi đối
						tượng khán giả: từ blog âm nhạc đến mạng xã hội của bạn.</p>
				</div>

				<div class="col-md-4 mb-4">
					<h5 class="fw-bold text-white">Tìm hiểu và kết nối với khán
						giả của bạn</h5>
					<p class="text-light">Đo lường tiến trình của bạn bằng số liệu
						thống kê và tương tác trực tiếp với người hâm mộ thông qua bình
						luận và tin nhắn.</p>
				</div>

				<div class="col-md-4 mb-4">
					<h5 class="fw-bold text-white">Mang theo các công cụ sáng tạo
						mọi lúc mọi nơi</h5>
					<p class="text-light">Cho dù bạn đang ở phòng thu, ở nhà hay
						trên xe buýt, hãy duy trì sự sôi động cho cộng đồng của
						bạn bằng ứng dụng di động dành cho người sáng tạo của chúng tôi.</p>
				</div>

			</div>

			<!-- IMAGE MOCKUP (centered, overlapping) -->
			<div class="d-flex justify-content-center mb-4">
				<img src="assets/img/stats.png"
					class="img-fluid"
					style="max-width: 900px; border-radius: 6px; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);">
			</div>

			<!-- CTA buttons -->
			<div class="text-center mb-5">
				<button class="btn btn-light fw-bold px-4 py-2">Dùng thử ngay</button>
				<a href="#" class="ms-3 text-primary fw-bold">Tìm hiểu thêm về các gói Pro</a>
			</div>
		</div>
	</section>

	<!-- FOOTER -->
	<footer class="py-4"
		style="background: #0d0d0d; color: #bbb; font-size: 0.9rem;">
		<div class="container text-center">

			<div class="mb-3">
				<a href="#" class="text-secondary me-2">Hợp pháp</a> · <a href="#"
					class="text-secondary mx-2">Bảo mật</a> · <a href="#"
					class="text-secondary mx-2">Chính sách Cookie</a> · <a href="#"
					class="text-secondary mx-2">Trình quản lý Cookie</a> · <a href="#"
					class="text-secondary mx-2">Xuất bản</a> · <a href="#"
					class="text-secondary mx-2">Nguồn nghệ sĩ</a> · <a href="#"
					class="text-secondary mx-2">Tin tức</a> · <a href="#"
					class="text-secondary mx-2">Biểu đồ</a> · <a href="#"
					class="text-secondary mx-2">Báo cáo minh bạch</a>
			</div>

			<div class="text-secondary">
				Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt (VN)</a>
			</div>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
